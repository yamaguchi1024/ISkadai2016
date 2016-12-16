#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define CODE_SIZE 30000
#define BUFF_SIZE 30000



fprintf(as, ".section .bss\n");
fprintf(as, "\t.lcomm buffer %s\n", info.arr_size);
fprintf(as, ".section .text\n");
fprintf(as, ".globl _start\n");
fprintf(as, "_start:\n");
fprintf(as, "\tmov $buffer, %%edi\n");
while ((c = fgetc(src)) != EOF) {
    switch (c) {
        case '>':
            fprintf(as, "\tinc %%edi\n"); 
            break;
        case '<':
            fprintf(as, "\tdec %%edi\n");
            break;
        case '+':
            fprintf(as, "\tincb (%%edi)\n");
            break;
        case '-':
            fprintf(as, "\tdecb (%%edi)\n");
            break;
        case ',':
            fprintf(as, "\tmovl $3, %%eax\n");
            fprintf(as, "\tmovl $0, %%ebx\n");
            fprintf(as, "\tmovl %%edi, %%ecx\n");
            fprintf(as, "\tmovl $1, %%edx\n");
            fprintf(as, "\tint $0x80\n");
            break;
        case '.':
            fprintf(as, "\tmovl $4, %%eax\n");
            fprintf(as, "\tmovl $1, %%ebx\n");
            fprintf(as, "\tmovl %%edi, %%ecx\n");
            fprintf(as, "\tmovl $1, %%edx\n");
            fprintf(as, "\tint $0x80\n");
            break;
        case '[':
            if (top == stack_size) {
                stack_size *= 1 + STACK_GROWTH_FACTOR;
                if ((stack = realloc(stack,
                                sizeof *stack * stack_size)) == NULL) {
                    fprintf(stderr, "%s: Out of memory while increasing "
                            "loop stack to size: %lu\n",
                            info.pname, stack_size);
                    exit(EXIT_FAILURE);
                }
            }
            stack[top++] = ++loop;
            fprintf(as, "\tcmpb $0, (%%edi)\n");
            fprintf(as, "\tjz .LE%u\n", loop);
            fprintf(as, ".LB%u:\n", loop);
            break;
        case ']':
            fprintf(as, "\tcmpb $0, (%%edi)\n");
            fprintf(as, "\tjnz .LB%u\n", stack[--top]);
            fprintf(as, ".LE%u:\n", stack[top]);
            break;
    }
}
fprintf(as, "movl $1, %%eax\n");
fprintf(as, "movl $0, %%ebx\n");
fprintf(as, "int $0x80\n");
