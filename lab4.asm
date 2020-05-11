.data
	str: .asciiz "Hello"
	length: .word 5
	nl: .ascii "\n'

.text
	main:
		la $a2, str
		la $a3, length
		
		jal LoadStr
		
		li $v0, 4
		la $a0, nl
		syscall 

		jal ReverseStr
		
		li $v0, 10
		syscall

	LoadStr:
		lb $t0, str($t1)
		beq $t0, $zero, exLoop
		
		addi $sp, $sp, -4
		sb $t0, 0($sp)
		
		li $v0, 4		#print
		la $a0, 0($sp)
		syscall
		
		add $t1, $t1, 1
		j LoadStr
		
	ReverseStr:
		li $v0, 4		#print
		la $a0, 0($sp)
		syscall
	
		lb $t0, ($sp)
		addi $sp, $sp, 4
		beq $t0, $zero, exLoop
		
		sb $t0, str($t1)
			
		add $t1, $t1, 1
		
		j ReverseStr
		
	exLoop: 
		jr $ra
		
