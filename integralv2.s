.global integralv2

.section .data
        steps: .int 500

	.align 32
	a: .double 3

	.align 32
	b: .double 10

        .align 32
	two: .double 2, 2
        
	.align 32
	six: .double 6, 6

	.align 32
	dsteps: .double 500, 500
.section .text

integralv2:
	mov steps, %eax
	xorpd %xmm6, %xmm6 # xmm6 = cumulative area

	movlpd b, %xmm0 # 10, 0
	movlpd a, %xmm1 # 3, 0
	subpd %xmm1, %xmm0 # 7, 0
	divpd two, %xmm0 # 3.5, 0
	addpd %xmm1, %xmm0 # 6.5, 0
	movhpd b, %xmm0 # 6.5, 10
	movlhps %xmm0, %xmm1 # 3, 6.5
 	
	subpd %xmm1, %xmm0 
	divpd dsteps, %xmm0 # xmm0 = i = (b-a)/n
	
	movapd %xmm1, %xmm2
	addpd %xmm0, %xmm2 # xmm2 = a+i
        
	loop:
		movapd %xmm1, %xmm3 
		addpd %xmm2, %xmm3
		divpd two, %xmm3 # xmm3 = x
		
		movapd %xmm3, %xmm4
		mulpd %xmm3, %xmm4
		subpd six, %xmm4 # xmm4 = x^2 - 6

		movapd %xmm1, %xmm5
		subpd two, %xmm5 # xmm5 = x - 2
		
		divpd %xmm5, %xmm4 # xmm4 = f(x)

		# calculate area F(x) * i

		mulpd %xmm0, %xmm4 # xmm4 = area
		
		addpd %xmm4, %xmm6	
		
		addpd %xmm0, %xmm1
		addpd %xmm0, %xmm2

		dec %eax
		jnz loop
	
# nop # i dont know its just here
ret
