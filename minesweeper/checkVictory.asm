.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0
	
	li $v0, 0 #cont = 0
	
	li $s3, 0 # i = 0
	li $s4, SIZE 
	
	fordoi:
		bgt $s3, $s4, finaldofordoi #(pule se for maior) pula para o finaldofordoi se o valor de s3(i) for maior que o valor de s4
		
	li $s5, 0 #j = 0
	li $s6, SIZE
	fordoj:
		bgt $s5, $s6, finaldofordoj #pula para o finaldofordoj se o valor de s5(j) for maior que o valor de s6
		
	#if aq
	sll $t1, $s3, 5 #esquema de andar no vetor 
	sll $t2, $s5, 2
	
	add $t0, $t1, $t2
	add $t0, $t0, $s0
	lw $s7, 0($t0) #guarda em s7 o valor de t0 (esta dando erro)
	
	bge $s7, 0, continua  # se o valor que esta s7(cordenada do board) for maior ou igual a 0 ele nao entra na condição
	
	addi $v0, $v0, 1 #adiciona mais um no cont, pois encontrou uma bomba
	
	continua:
	addi $s5, $s5, 1 #adiciona mais um no j
	j fordoj 
	
	finaldofordoj:
	addi $s3, $s3, 1
	j fordoi
	
	finaldofordoi:
	
	
	beq $v0, BOMB_COUNT, retorne1 #se v0 for igual a bomb count ele retorna 1, ou seja, todas as celulas foram reveladas
	
	li $v0, 0 #tem alguma bomba no jogo
	restore_context
	jr $ra
	
	retorne1:
	li $v0, 1 #revelou tudo
	restore_context
	jr $ra
