.global _start

.section .data
	a: .float 2
	b: .float 10
	n: .float 1000
	two: .float 2

.section .text

_start:

finit

#count step
fld a
fld b
fsubp
fdiv n # r7 = i=(b-a)/n

fld a # r6 = a
fld a 
fadd %ST(2), %ST(0) # r5 = a+i

fld %ST(1)
fadd %ST(1)
fdiv two #r4 = x

fmul %ST(2), %ST(0)

