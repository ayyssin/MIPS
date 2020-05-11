.data
	Arr: .word 21 20 51 83 20 20
	length: .word 6
	x: .word 20
	y: .word 5
	counter: .word 0
	nl: .asciiz "\n"
	
.text
	la $s0, Arr
	lw $t2, x
	lw $t3, y
	lw $t4, counter
	lw $t5, length
	
	Loop:
		beq $t0, $0, skip 	#skip printing the first element if its value was not loaded yet 
	
		li $v0, 1 		#printing the array
		move $a0, $t0
		syscall
		
		li $v0, 4 		#printing newline
		la $a0, nl
		syscall
				
	skip:	beq $t4, $t5, finish 	#finish loop if counter equals the length
		
		lw $t0, 0($s0) 		#t0 = a0[0]
		addi $s0, $s0, 4 	#next element
		addi $t4, $t4, 1 	#increment the counter
				
		beq $t0, $t2, replace 	#if t0 == x, goto replace func to replace with y
				
		j Loop
	
	replace:
		addi $t0, $0, 0 
		add $t0, $t0, $t3
		j Loop
		
	finish:
		li $v0, 10
		syscall
		
