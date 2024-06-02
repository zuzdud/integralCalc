.global _start

.section .data
        in: .int 1000
        # some needed constants
        .align 16
	two: .float 2, 2, 2, 2
        
	.align 16
	six: .float 6, 6, 6, 6

	.align 16
	v1: .float 6.5, 10, 0, 0
	
	.align 16
	v2: .float 3, 6.5, 0, 0

	.align 16
	v3: .float 1000, 1000, 1, 1

	.align 16
	v4: .float 0, 0, 0, 0

.section .text

_start:
	mov in, %eax
	movaps v4, %xmm6 	

	movaps v1, %xmm0 
	movaps v2, %xmm1
	subps %xmm1, %xmm0 
	movaps v3, %xmm1
	divps %xmm1, %xmm0 # xmm0 = i = (b-a)/n
	

	movaps v2, %xmm1 # xmm1 = a
	
	movaps %xmm1, %xmm2
	addps %xmm0, %xmm2 # xmm2 = a+i
        
	loop:
		movaps %xmm1, %xmm3 
		addps %xmm2, %xmm3
		divps two, %xmm3 # xmm3 = x
		
		movaps %xmm3, %xmm4
		mulps %xmm3, %xmm4
		subps six, %xmm4 # xmm4 = x^2 - 6

		movaps %xmm1, %xmm5
		subps two, %xmm5 # xmm5 = x - 2
		
		divps %xmm5, %xmm4 # xmm4 = f(x)

		# calculate area F(x) * i

		mulps %xmm0, %xmm4 # xmm4 = area
		
		addps %xmm4, %xmm6	
		
		addps %xmm0, %xmm1
		addps %xmm0, %xmm2

		dec %eax
		jnz loop
	
nop # i dont know its just here

