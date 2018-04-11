;************************************** LCD_01.asm **************************************
;
;	===================================================================
;	  Del libro "MICROCONTROLADOR PIC16F84. DESARROLLO DE PROYECTOS"
;	  E. Palacios, F. Remiro y L. López.
; 	  Editorial Ra-Ma.  www.ra-ma.es
;	===================================================================
;
; El módulo LCD visualiza el mensaje "Hola".
;
; ZONA DE DATOS **********************************************************************

	__CONFIG   _CP_OFF &  _WDT_OFF & _PWRTE_ON & _XT_OSC
	LIST	   P=16F84A
	INCLUDE  <P16F84A.INC>

	CBLOCK 0x0C
	ENDC

; ZONA DE CÓDIGOS ********************************************************************

	ORG	0
Inicio
	call	LCD_Inicializa
	movlw	'H'
	call	LCD_Caracter
	movlw	'o'
	call	LCD_Caracter
	movlw	'l'
	call	LCD_Caracter
	movlw	'a'
	call	LCD_Caracter
	sleep				; Entra en modo de bajo consumo.

	INCLUDE  <LCD_4BIT.INC>	; Subrutinas de control del módulo LCD.
	INCLUDE  <RETARDOS.INC>	; Subrutinas de retardo.
	END				; Fin del programa.

;	===================================================================
;	  Del libro "MICROCONTROLADOR PIC16F84. DESARROLLO DE PROYECTOS"
;	  E. Palacios, F. Remiro y L. López.
; 	  Editorial Ra-Ma.  www.ra-ma.es
;	===================================================================

