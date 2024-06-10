.global integralv2

.section .data
        steps: .int 250

	.align 32
	a: .float 3

	.align 32
	b: .float 10

        .align 32
	two: .float 2, 2, 2, 2
        
	.align 32
	four: .float 4, 4, 4, 4

	.align 32
	six: .float 6, 6, 6, 6
		
	.align 32
	dsteps: .float 1000

.section .text

integralv2:
# shufps
	mov steps, %eax # initialize rectangle counter
	xorpd %xmm6, %xmm6 # xmm6 = cumulative area

	movaps b, %xmm0 # b
	movaps a, %xmm1 # a
	subps %xmm1, %xmm0 # b-a
	divps dsteps, %xmm0 # i = (b-a)/n
	shufps $0x00, %xmm0, %xmm0 # xmm0 = i 
	movaps a, %xmm1 # a
	shufps $0x00, %xmm1, %xmm1 # xmm1 = a
	movaps %xmm0, %xmm2 # xmm2 = i
	pslldq $4, %xmm2
	addps %xmm2, %xmm1
	pslldq $4, %xmm2
	addps %xmm2, %xmm1
	pslldq $4, %xmm2
        addps %xmm2, %xmm1 # xmm1 = a, a+i, a+2i, a+3i
	movaps %xmm1, %xmm2 # a
	addps %xmm0, %xmm1 # b

	movaps %xmm0, %xmm7
	mulps four, %xmm7
		
	loop:
		movaps %xmm1, %xmm3 
		addps %xmm2, %xmm3
		divps two, %xmm3 # xmm3 = x
		
		movaps %xmm3, %xmm4
		mulps %xmm3, %xmm4
		subps six, %xmm4 # xmm4 = x^2 - 6

		movaps %xmm3, %xmm5
		subps two, %xmm5 # xmm5 = x - 2
		
		divps %xmm5, %xmm4 # xmm4 = f(x)

		# calculate area F(x) * i

		mulps %xmm0, %xmm4 # xmm4 = area
		
		addps %xmm4, %xmm6 # add to cumulative area
		
		addps %xmm7, %xmm1 # go to next rectangle
		addps %xmm7, %xmm2

		dec %eax # decrement counter
		jnz loop # jump to loop if counter not zero
	
ret
