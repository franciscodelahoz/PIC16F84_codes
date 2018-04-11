;*********************************** Int_INT_04.asm *************************************
;
;	===================================================================
;	  Del libro "MICROCONTROLADOR PIC16F84. DESARROLLO DE PROYECTOS"
;	  E. Palacios, F. Remiro y L. López.
; 	  Editorial Ra-Ma.  www.ra-ma.es
;	===================================================================
;
; Cada vez que presiona el pulsador conectado a la línea RB0/INT conmutará el estado
; de un LED conectado a la línea RB1.
;
; ZONA DE DATOS **********************************************************************

	__CONFIG   _CP_OFF &  _WDT_OFF & _PWRTE_ON & _XT_OSC
	LIST	   P=16F84A
	INCLUDE  <P16F84A.INC>

	CBLOCK  0x0C
	ENDC

#DEFINE  Pulsador	PORTB,0		; Línea donde se conecta el pulsador.
#DEFINE  LED	PORTB,1			; Línea donde se conecta el LED.

; ZONA DE CÓDIGOS ********************************************************************

	ORG 	0
	goto	Inicio
	ORG	4			; Vector de interrupción
	goto	ServicioInterrupcion
Inicio
	bsf	STATUS,RP0		; Acceso al Banco 1.
	bsf	Pulsador		; La línea RB0/INT se configura como entrada.
	bcf	LED			; Se configura como salida.
	bcf	OPTION_REG,NOT_RBPU	; Activa las resistencias de Pull-Up del Puerto B.
	bcf	OPTION_REG,INTEDG	; Interrupción INT se activa por flanco de bajada.
	bcf	STATUS,RP0		; Acceso al Banco 0.
	movlw	b'10010000'		; Habilita la interrupción INT y la general.
	movwf	INTCON
Principal
	sleep				; Pasa a modo bajo consumo y espera interrupciones.
	goto	Principal

; Subrutina "ServicioInterrupcion" ------------------------------------------------------
;
; Subrutina de atención a la interrupción. Conmuta el estado del LED.
;
ServicioInterrupcion
	call	Retardo_20ms
	btfsc	Pulsador
	goto	FinInterrupcion		; Era un rebote y por tanto sale.
	btfsc	LED			; Testea el último estado del LED.
 	goto	EstabaEncendido
EstabaApagado
	bsf	LED			; Estaba apagado y lo enciende.
	goto	FinInterrupcion
EstabaEncendido
	bcf	LED			; Estaba encendido y lo apaga.
FinInterrupcion
	bcf	INTCON,INTF		; Limpia flag de reconocimiento de la interrupción.
	retfie				; Retorna y rehabilita las interrupciones.

	INCLUDE   <RETARDOS.INC>
	END

;	===================================================================
;	  Del libro "MICROCONTROLADOR PIC16F84. DESARROLLO DE PROYECTOS"
;	  E. Palacios, F. Remiro y L. López.
; 	  Editorial Ra-Ma.  www.ra-ma.es
;	===================================================================


