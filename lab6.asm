.data
	str: .asciiz "Enter the integers:"
	main: .word 00400000
	str2: .asciiz "Try again\n"
	
.text
  
	addi $v0, $0, 4
	la $a0, str
	syscall
	
	addi $v0, $0, 5
	syscall
	move $a1, $v0
	
	addi $v0, $0, 5
	syscall
	move $a2, $v0
	
	add $t0, $a1, $a2
		
	li $v0, 1
	move $a0, $t0
	syscall
	
  	li $v0, 10
	syscall
	
.ktext 0x80000180

	 mfc0 $k0, $14
	 
	 addi $v0, $0, 4
	 la $a0, str2
	 syscall
	 
	 addi $k0, $k0, 4
	 mtc0 $k0, $14
	 la $k0, main
	 
	 eret
	
	
	
	
	
