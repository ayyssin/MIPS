.data
	DISPLAY: .space 0x00100 # 8*8*4, we need to reserve this space at the beginning of .data segment
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	RED: .word 0xff0000
	
.text
j main

set_pixel_color:
# Assume a display of width DISPLAYWIDTH and height DISPLAYHEIGHT
# Pixels are numbered from 0,0 at the top left
# a0: x-coordinate
# a1: y-coordinate
# a2: color
# address of pixel = DISPLAY + (y*DISPLAYWIDTH + x)*4
#			y rows down and x pixels across
# write color (a2) at arrayposition

	lw $t0, DISPLAYWIDTH
	addi $a1, $a1, 32
	mul $t0, $t0, $a1 	# y*DISPLAYWIDTH
	add $t0,$t0, $a0 	# +x
	addi $t0, $t0, 32
	sll $t0, $t0, 2 	# *4
	la $t1, DISPLAY 	# get address of display: DISPLAY
	add $t1, $t1, $t0	# add the calculated address of the pixel
	sw $a2, ($t1) 		# write color to that pixel
	jr $ra 			# return

main:
	li $s1, 15
	li $s0, 0
	mul $s2, $s1, $s1	#r^2
	li $s6, 16
	lw $a2, RED
	lw $t0, RED
	for:
		li $s0, 0
		beq $a2, $t0, for2
		addi $a2, $a2, 20000
		addi $a1, $a1, 1
	for2:
		mul $s3, $s0, $s0
		sub $s3, $s2, $s3 	#r^2 - x^2
		mtc1 $s3, $f1
		cvt.s.w $f1, $f1
		sqrt.s $f0, $f1
		cvt.w.s $f0, $f0
		mfc1 $s3, $f0
		move $a0, $s0	
		move $a1, $s3
		
		jal set_pixel_color
		addi $s0, $s0, 1
		beq $s0, $s6, for
		j for2
	
	exit:
		li $v0, 10
		syscall
