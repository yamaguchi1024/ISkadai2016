f = open('test.txt','w')
s = ""
for i in range(0,10000):
  s += "%d\n" % i

f.write(s)
f.close()
