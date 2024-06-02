.global timestamp

.text

timestamp:
push %ebx

xor %eax, %eax
cpuid
rdtsc

pop %ebx
ret
