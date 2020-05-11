.data
	Arr: .word 21 20 51 83 20 20
	length: .word 6
	x: .word 20
	y: .word 5
	counter: .word 0
	ws: .asciiz " "
	
.text
	main:
		la $a0, Arr
		lw $a1, length
		lw $a2, x
		lw $a3, y
		lw $s2, counter
		
		la $s4, 0($a0)
		jal printArrInt 
		
		jal replace

		jal printArrInt	
		
		li $v0, 10
		syscall	
			
	printArrInt:
			addi $sp, $sp, -4
			sw $s2, 0($sp)
			
		LoopPrint:	
						
			sll $t0, $s2, 2
			add $t0, $t0, $s4
			lw $t1, 0($t0)
			
			beq $s2, $a1, exit
			li $v0, 1
			move $a0, $t1
			syscall
			
			li $v0, 4
			la $a0, ws
			syscall
			
			addi $s2, $s2, 1
			
			j LoopPrint
					
		exit:
			addi $sp, $sp, 4
			lw $s2, 0($sp)
			jr $ra
			
	replace:	
			addi $sp, $sp, -4
			sw $s3, 0($sp)
			
		LoopReplace:
		
			sll $t0, $s0, 2
			add $t0, $t0, $s4
			lw $t1, 0($t0)
			
			beq $s3, $a1, replaceExit
			addi $s3, $s3, 1
			beq $t1, $a2, repl
						
			j LoopReplace
			
		repl:
			sw $a3, 0($t0)
			jr $ra
		
		replaceExit:
			addi $sp, $sp, 4
			lw $s3, 0($sp)
			jr $ra
			
		
		
