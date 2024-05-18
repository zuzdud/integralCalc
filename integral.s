.global _start

.section .data
	a: .float 2
	b: .float 10
	n: .float 1000
	two: .float 2
	six: .float 6
	z: .float 0
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

fld %ST(0)
fmul %ST(1), %ST(0)
fsub six #r3 pierwsza czesc wyniku

fld %ST(1)
fsub two # r2 druga czesc wyniku

fld %ST(1)
fdiv %ST(1), %ST(0) # podzielic

fmul %ST(6), %ST(0) #pomnozyc razy i wynik w r1
fadd %ST(0)

fmul z, %ST(4)
