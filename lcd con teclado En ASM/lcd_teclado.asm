	list p = 18F452
#include<p18f452.inc>



	CBLOCK			0X0A
JJ,KK,inc2,Tecla,jj,kk,aa,respaldo
	ENDC
		
			
		org			0x00
		goto		inicio

inicio
				call			BORRAR_BASURA
				call			CONFIGURAR_PUERTOS
				call			INICIAR_LCD 
				call			MENSAJE
				call			conf_interrupcion

				clrf				inc2
				comf			inc2
				bcf				inc2,0
				movff			inc2,PORTB

				goto		testeo






					
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
				bcf		PORTE,0
				bcf		PORTE,1
				bcf		PORTE,2
			
				movwf	PORTD

				bsf		PORTE,2
				nop
				nop
				bcf		PORTE,2
				
	
				movlw	d'15'
				movwf	JJ
				call	RETARDO

				return				

R_D
; Rutina que ejecuta instrucciones de la LCD
				bsf		PORTE,0
				bcf		PORTE,1
				bcf		PORTE,2
			
				movwf	PORTD

				bsf		PORTE,2
				nop
				nop
				bcf		PORTE,2	
				
	
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

conf_interrupcion

		bcf				INTCON2,7	
		return	






















CONFIGURAR_PUERTOS
		movlw		B'11110000'
		movwf    	TRISB
		movlw		B'000000'
		movwf    	TRISA

		movlw		0x07
		movwf    	ADCON1

		clrf			TRISE

		clrf			TRISD	
		clrf			TRISC

		return


BORRAR_BASURA
		clrf			PRODL
		clrf			inc2
		clrf			LATA

		clrf			LATC
		clrf			LATD
		clrf			LATE
	
		clrf			TRISA
		clrf			TRISB
		clrf			TRISC
		clrf			TRISD
		clrf			TRISE

		clrf			PORTA
		clrf			PORTB
		clrf			PORTC
		clrf			PORTD
		clrf			PORTE
		
				return

MENSAJE		
				movlw	d'132'		; Direccion Primer Renglon	5 caracter
				call	R_I

				movlw	'M'
				call	R_D

				movlw	'e'
				call	R_D

				movlw	'N'
				call	R_D

				movlw	's'
				call	R_D
	
				movlw	'A'
				call	R_D

				movlw	'j'
				call	R_D

				movlw	'E'
				call	R_D

				movlw	d'197'		; Direccion Segundo Renglon 6 Caracter
				call	R_I

				movlw	'P'
				call	R_D
				
				movlw	'r'
				call	R_D

				movlw	'U'
				call	R_D

				movlw	'e'
				call	R_D

				movlw	'B'
				call	R_D
	
				movlw	'A'
				call	R_D


				return

















  

testeo    							; pone un uno a rodar de RB0 a  RB3
	movlw			b'11110111'
	cpfseq			inc2
	goto			mult

	clrf				inc2
	comf			inc2
	bcf				inc2,0
	movff			inc2,PORTB

	goto			testeo1

mult
	comf			inc2
	movf			inc2,W
	mullw			d'2'

	movff			PRODL,inc2
	comf			inc2
	movff			inc2,PORTB

	goto			testeo1




testeo1
			movff			PORTB,respaldo
			btfss			PORTB,7	
			goto			c_7	
			btfss			PORTB,6	
			goto			c_6	
			btfss			PORTB,5	
			goto			c_5
			btfss			PORTB,4	
			goto			c_4

			goto			testeo







c_7
			movlw			d'7'          
			movwf			jj
			call				retardo

			btfss			inc2,0		
			goto			T_ast
			btfss			inc2,1		
			goto			T_7
			btfss			inc2,2		
			goto			T_4
			btfss			inc2,3		
			goto			T_1

			goto			testeo


c_6	
			movlw			d'7'          
			movwf			jj
			call				retardo

			btfss			inc2,0		
			goto			T_0	
			btfss			inc2,1		
			goto			T_8
			btfss			inc2,2		
			goto			T_5
			btfss			inc2,3		
			goto			T_2

			goto			testeo



c_5
			movlw			d'7'          
			movwf			jj
			call				retardo

			btfss			inc2,0		
			goto			T_#
			btfss			inc2,1		
			goto			T_9
			btfss			inc2,2		
			goto			T_6
			btfss			inc2,3		
			goto			T_3

			goto			testeo


c_4
			movlw			d'7'          
			movwf			jj
			call				retardo

			btfss			inc2,0		
			goto			T_D
			btfss			inc2,1		
			goto			T_C
			btfss			inc2,2		
			goto			T_B
			btfss			inc2,3		
			goto			T_A

			goto			testeo










T_ast
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'*'
		call				R_D
		
		goto			testeo
T_7
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'7'
		call				R_D
		
		goto			testeo
T_4
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'4'
		call				R_D
		
		goto			testeo
T_1
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'1'
		call				R_D
		
		goto			testeo





T_0	
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'0'
		call				R_D
		
		goto			testeo
T_8
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'8'
		call				R_D
		
		goto			testeo
T_5
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'5'
		call				R_D
		
		goto			testeo
T_2
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'2'
		call				R_D
		
		goto			testeo





T_#
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'#'
		call				R_D
		
		goto			testeo
T_9
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'9'
		call				R_D
		
		goto			testeo
T_6
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'6'
		call				R_D
		goto			testeo
T_3
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'3'
		call				R_D

		goto			testeo





T_D
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'd'
		call				R_D

		goto			testeo
T_C
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'c'
		call				R_D

		goto			testeo
T_B
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'b'
		call				R_D

		goto			testeo
T_A
		call			REBOTE
		movlw		d'5'          
		movwf		jj
		call			retardo

		movlw			'a'
		call				R_D

		goto			testeo







retardo			
	decfsz	jj,f
	goto	lapso1
	return

lapso1
	movlw		d'5'          
	movwf		aa

	decfsz	kk,f			    
	goto	lapso1
	goto	dec
dec	
	decfsz	aa,f
	goto	dec_sub
	goto	retardo

dec_sub
	decfsz	kk,f		      
	goto	dec_sub
	goto	dec	

REBOTE
PRIM
		BTFSS			PORTB,4
		GOTO 			PRIM
		BTFSS			PORTB,5
		GOTO 			PRIM
		BTFSS 			PORTB,6
		GOTO 			PRIM
		BTFSS 			PORTB,7
		GOTO 			PRIM

		movlw		d'5'          
		movwf		jj
		call			retardo	

		RETURN



				end