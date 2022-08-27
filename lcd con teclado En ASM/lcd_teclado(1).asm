	list p=18f452
#include<p18f452.inc>


JJ 		equ 	0X0A
KK	 	equ 	0X0B
 
        org 0x00

		call			CONFIGURAR_PUERTOS
		call			BORRAR_BASURA
		call			INICIAR_LCD 


		goto		testeo



CONFIGURAR_PUERTOS


		movlw		B'00001111'
		movwf    	TRISB

		clrf			TRISD	
		clrf			TRISC

		return




BORRAR_BASURA
		
		clrf			PORTC
		clrf			PORTD
				
				return
					
INICIAR_LCD

				movlw	b'00110000'
				call	R_I
				
				movlw	d'70'
				movwf	JJ
				call	RETARDO

				movlw	b'00110000'
				call	R_I
				
				movlw	d'45'
				movwf	JJ
				call	RETARDO

				movlw	b'00110000'
				call	R_I
				
				movlw	d'20'
				movwf	JJ
				call	RETARDO

				movlw	b'00111000'
				call	R_I
			
				movlw	b'00001100'
				call	R_I

				movlw	b'00000001'
				call	R_I

				return	


R_I
; Rutina que ejecuta instrucciones de la LCD

				bcf		PORTC,0
				bcf		PORTC,1
				bcf		PORTC,2
			
				movwf	PORTD

				bsf		PORTC,2
				nop
				nop
				bcf		PORTC,2
				
	
				movlw	d'15'
				movwf	JJ
				call	RETARDO

				return					



R_D
; Rutina que ejecuta instrucciones de la LCD

				bsf		PORTC,0
				bcf		PORTC,1
				bcf		PORTC,2
			
				movwf	PORTD

				bsf		PORTC,2
				nop
				nop
				bcf		PORTC,2	
				
	
				movlw	d'15'
				movwf	JJ
				call	RETARDO

				return

RETARDO
; Rutina que sirve para generar retardos
			
				movlw	d'100'
				movwf	KK
				decfsz	JJ,F
				goto	LAPSO
				return
		
LAPSO
				decfsz	KK,F
				goto	LAPSO
				goto	RETARDO







testeo

	
	clrf			PORTB
	bsf			PORTB,4   ;COLUMNA  1, MIRANDO EL TECLADO DE DERECHA A IZQUIERDA

	BTFSS		 PORTB,0
	GOTO 		 S16
	BTFSS		 PORTB,1
	GOTO 		 S15
	BTFSS 		 PORTB,2
	GOTO 		 S14
	BTFSS 		 PORTB,3
	GOTO 		 S13


	clrf			PORTB
	bsf			PORTB,5

	BTFSS		 PORTB,0
	GOTO 		 S12
	BTFSS 		 PORTB,1
	GOTO 		 S11
	BTFSS 		 PORTB,2
	GOTO 		 S10
	BTFSS 		 PORTB,3
	GOTO 		 S9


	clrf			PORTB
	bsf			PORTB,6

	BTFSS		 PORTB,0
	GOTO 		 S8
	BTFSS 		 PORTB,1
	GOTO 		 S7
	BTFSS 		 PORTB,2
	GOTO 		 S6
	BTFSS 		 PORTB,3
	GOTO 		 S5


	clrf			PORTB
	bsf			PORTB,7

	BTFSS		 PORTB,0
	GOTO 		 S4
	BTFSS		 PORTB,1
	GOTO 		 S3
	BTFSS 		 PORTB,2
	GOTO 		 S2
	BTFSS		 PORTB,3
	GOTO 		 S1

	GOTO testeo




S1 
	CALL 		REBOTE
	MOVLW 		'D'
	call			R_D
	GOTO 		testeo


S2
	CALL 		REBOTE
	MOVLW 		'#'
	call			R_D
	GOTO 		testeo


S3
	CALL 		REBOTE
	MOVLW 		'0'
	call			R_D
	GOTO 		testeo


S4
	CALL 		REBOTE
	MOVLW 		'*'
	call			R_D
	GOTO 		testeo


S5
	CALL 		REBOTE
	MOVLW 		'C'
	call			R_D
	GOTO 		testeo


S6
	CALL 		REBOTE
	MOVLW 		'9'
	call			R_D
	GOTO 		testeo


S7
	CALL	 	REBOTE
	MOVLW 		'8'
	call			R_D
	GOTO 		testeo


S8
	CALL 		REBOTE
	MOVLW 		'7'
	call			R_D
	GOTO 		testeo


S9
	CALL 		REBOTE
	MOVLW 		'B'
	call			R_D
	GOTO 		testeo


S10
	CALL 		REBOTE
	MOVLW		'6'
	call			R_D
	GOTO 		testeo


S11
	CALL 		REBOTE
	MOVLW 		'5'
	call			R_D
	GOTO 		testeo


S12
	CALL 		REBOTE
	MOVLW 		'4'
	call			R_D
	GOTO 		testeo


S13
	CALL 		REBOTE
	MOVLW 		'A'
	call			R_D
	GOTO 		testeo


S14
	CALL 		REBOTE
	MOVLW 		'3'
	call			R_D
	GOTO 		testeo


S15
	CALL 		REBOTE
	MOVLW 		'2'
	call			R_D
	GOTO 		testeo


S16
	CALL 		REBOTE
	MOVLW 		'1'
	call			R_D
	GOTO 		testeo



REBOTE
PRIM
	BTFSC 		 PORTB,0
	GOTO 		 PRIM
	BTFSC 		 PORTB,1
	GOTO 		 PRIM
	BTFSC		 PORTB,2
	GOTO 		 PRIM
	BTFSC		 PORTB,3
	GOTO 		 PRIM
	RETURN


	end
