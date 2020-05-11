.data
  	msg1: .asciiz "Enter the value:"
  	nl: .ascii "\n"
 	pi: .double 3.142
  	half: .double 180.0
 	res: .double 1.0
 	fact: .double 1.0
 	pow: .double 1.0
 	sign: .double 1.0
  	negsign: .double -1.0
  	toFinish: .word -1
  
.text

   main:
 
   	lw $s7, toFinish
   	
  	li $v0, 4 #display message
  	la $a0, msg1
  	syscall

	li $v0, 7 #take input
  	syscall
  	
  	move $s6, $v0
	mtc1 $s6, $f0
  	
  	beq $s6, $s7, finish

 	jal degToRad
 
	li $s1, 14 #n
  	li $s2, 1 #counter
  	ldc1 $f8, res
  	ldc1 $f10, fact
 	ldc1 $f14, pow
  	ldc1 $f16, sign
  	ldc1 $f18, negsign
  
  	jal cosine
 
  	li $v0, 3
  	mov.d $f12, $f8  
  	syscall
  	
  	li $v0, 4
  	la $a0, nl
  	syscall
  	
  	j main
 
   finish:
  	li $v0, 10
  	syscall
 
 	degToRad:
 	 	ldc1 $f2, pi
  		ldc1 $f4, half 
  
  		mul.d $f6, $f2, $f0
  		div.d $f0, $f6, $f4
  		jr $ra
  
 	cosine:
  		beq $s2, $s1, exit
  
  		mul $s3, $s2, 2  #2i
  		addi $s4, $s3, -1 #2i - 1
  		mul $s5, $s4, $s3 #2i * (2i -1)
  		mtc1 $s5, $f20 #i
  		cvt.d.w $f20, $f20
  
  		mul.d $f16, $f16, $f18 #sign
  		mul.d $f24, $f0, $f0 #x^2
  		mul.d $f14, $f14, $f24 #power *= x^2  
  		mul.d $f10, $f10, $f20 #factorial
  		div.d $f26, $f14, $f10 #power/factorial
  		mul.d $f26, $f26, $f16 #sign*power/factorial
  
  		add.d $f8, $f8, $f26  
   
  		addi $s2, $s2, 1
  
  		j cosine
  
 	exit:
  		jr $ra
