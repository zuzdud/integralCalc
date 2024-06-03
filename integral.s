.global integral

.section .data
	.align 32
	a: .float 3 # left limit
	.align 32
	b: .float 10 # right limit
	.align 32
	n: .float 1000 # rectangles number
	
	steps: .int 1000
	
	.align 32
	two: .float 2 
	.align 32
	six: .float 6
	
.section .text

integral:

	finit # initialize fpu

	mov steps, %eax # initialize rectangles counter

	fldz # reserve place for cumulative area in fpu stack (r7)

	# calculate step
	fld a 
	fld b
	fsubp 
	fdiv n # r6 = i=(b-a)/n

	fld a # r5 = a

	fld a 
	fadd %ST(2), %ST(0) # r4 = a+i

	# loop should start here
	loop:
		# calculate x
		fld %ST(1)
		fadd %ST(1)
		fdiv two # r3 = x

		#caluclate f(x) = (x^2 - 6)/(x-2)
		fld %ST(0)
		fmul %ST(1), %ST(0)
		fsub six # r2 = x^2 - 6

		fld %ST(1)
		fsub two # r1 = x-2

		fdivrp # r2 = f(x)

		# calculate area F(x) * i
		fmul %ST(4), %ST(0) # r2 = area

		faddp %ST(0), %ST(5) # add area to cumulative area

		fstp %ST(0) # pop stack
		
		#go to next rectangle
		fadd %ST(2), %ST(0)
		fincstp 
		fadd %ST(1), %ST(0)
		fdecstp

		dec %eax # decrement rectangle counter
		jnz loop # jump if counter not 0
	 
ret
