// bf2elf.c
#include <stdio.h>
#include <stdlib.h>
#include <elf.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#define ARRAY_SIZE (0xffff * 2)

__asm__ ("start_:             \n\t"
         "inc %dl             \n\t" // len = 1
         "mov $0x6a, %di      \n\t" // addr of write
         "lea 6(%edi), %esi   \n\t" // addr of read
         "mov $0xffff, %bp    \n\t" // ARRAY_SIZE / 2
         "call end_           \n\t"
         "mov $1, %al         \n\t" // exit()
         "int $0x80           \n\t"
         "mov $4, %al         \n\t" // write()
         "mov $1, %bl         \n\t" // stdout
         "jmp syscall_        \n\t"
         "mov $3, %al         \n\t" // read()
         "xor %bl, %bl        \n\t" // stdin
         "movb %bl, (%ebp)    \n\t" // EOFのときは0埋め
         "syscall_:           \n\t"
         "mov %ebp, %ecx      \n\t" // addr
         "int $0x80           \n\t"
         "xor %eax, %eax      \n\t"
         "ret                 \n\t"
         "end_:               \n\t"
);
extern char *start_, *end_;

void write_elf_header(int fd) {
  Elf32_Ehdr ehdr = {
    { ELFMAG0, ELFMAG1, ELFMAG2 ,ELFMAG3, ELFCLASS32, ELFDATA2LSB, EV_CURRENT, ELFOSABI_SYSV },
    ET_EXEC, EM_386, EV_CURRENT, 52 + 32, 52, 0, 0x0, 52, 32, 1, 0, 0, 0,
  };
  write(fd, &ehdr, sizeof(Elf32_Ehdr));
}

void write_program_header(int fd, size_t code_size) {
  size_t sz = 52 + 32 + code_size;
  Elf32_Phdr phdr = {
    PT_LOAD, 0x0, 0x0, 0, sz, sz + ARRAY_SIZE, PF_R | PF_W | PF_X, 0x1000,
  };
  write(fd, &phdr, sizeof(Elf32_Phdr));
}

size_t write_code(int fd) {
  uintptr_t base_len = (uintptr_t)&end_ - (uintptr_t)&start_;
  write(fd, &start_, base_len);

  static const struct insn {
    size_t len;
    unsigned char code[10];
  } insns[8] = {
    { 1,  { 0x45 } },             // ">", inc    %ebp
    { 1,  { 0x4d } },             // "<", dec    %ebp
    { 3,  { 0xfe, 0x45, 0x00 } }, // "+", incb  (%ebp)
    { 3,  { 0xfe, 0x4d, 0x00 } }, // "-", decb  (%ebp)
    { 2,  { 0xff, 0xd7 } },       // ".", call  *%edi　←この記事のテーマ
    { 2,  { 0xff, 0xd6 } },       // ",", call  *%esi　←これも
    { 10, { 0x80, 0x4d, 0x00, 0x00, 0x0f, 0x84, 0xFF, 0xFF, 0xFF, 0xFF } },
                                  // "[", orb $0, (%ebp); jz XX
    { 5,  { 0xe9, 0xFF, 0xFF, 0xFF, 0xFF } },
                                  // "]", jmp XX
  }; // TODO: short jump

  struct block { size_t b; size_t e; } blocks[1024] = {{0,0}};
  size_t b_used = 0, insn_len = 0;
  char c;

  int c2n() {
    switch(c) {
    case '>': return 0; case '<': return 1;
    case '+': return 2; case '-': return 3;
    case '.': return 4; case ',': return 5;
    case '[': return 6; case ']': return 7;
    }
    return -1;
  }

  ssize_t p;
  while(read(0, &c, 1) > 0) {
    int n = c2n();
    if (n >= 0) {
      insn_len += insns[n].len;
      write(fd, insns[n].code, insns[n].len);
      if (n == 6) {
        if (b_used == 1024) _exit(1);
        blocks[b_used++].b = insn_len;
      } else if (n == 7) {
        p = b_used;
        while(--p >= 0) {
          if (blocks[p].e == 0) {
            blocks[p].e = insn_len;
            break;
          }
        }
        if (p < 0) _exit(2);
      }
    }
  }

  for(p = 0; p < b_used; ++p) {
    uint32_t rel = blocks[p].e - blocks[p].b;
    lseek(fd, 52 + 32 + base_len + blocks[p].b - 4, SEEK_SET);
    write(fd, &rel, 4);
    rel = blocks[p].b - blocks[p].e - insns[6].len;
    lseek(fd, 52 + 32 + base_len + blocks[p].e - 4, SEEK_SET);
    write(fd, &rel, 4);
  }
  lseek(fd, 52 + 32 + base_len + insn_len, SEEK_SET);
  c = 0xc3; // ret
  write(fd, &c, 1);
  return base_len + (++insn_len);
}

int main() {
  char fn[] = "/tmp/BF_XXXXXX";
  int fd = mkstemp(fn);
  size_t code_size;
  lseek(fd, 52 + 32, SEEK_SET);
  code_size = write_code(fd);
  lseek(fd, 0, SEEK_SET);
  write_elf_header(fd);
  write_program_header(fd, code_size);
  fchmod(fd, 0755);
  close(fd);
  fprintf(stderr, "%s\n", fn);
  return 0;
}
