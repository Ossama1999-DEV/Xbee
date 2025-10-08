
_saut_ligne:

;bonjourxbee1.c,6 :: 		void saut_ligne()          {
;bonjourxbee1.c,7 :: 		i = '\n'  ;
	MOVLW      10
	MOVWF      _i+0
;bonjourxbee1.c,8 :: 		Uart1_Write(i);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;bonjourxbee1.c,9 :: 		i = '\r'  ;
	MOVLW      13
	MOVWF      _i+0
;bonjourxbee1.c,10 :: 		Uart1_Write(i);    }
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
L_end_saut_ligne:
	RETURN
; end of _saut_ligne

_main:

;bonjourxbee1.c,11 :: 		void main()                {
;bonjourxbee1.c,12 :: 		PORTD = 0;                 // Initialize PORTD
	CLRF       PORTD+0
;bonjourxbee1.c,13 :: 		TRISD = 0;                 // Configure PORTD as output
	CLRF       TRISD+0
;bonjourxbee1.c,15 :: 		Uart1_Init(9600);   //(8 bit, 2400 baud rate, no parity bit..)
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;bonjourxbee1.c,17 :: 		do {
L_main0:
;bonjourxbee1.c,18 :: 		if (Uart1_Data_Ready()) {   // If data is received
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;bonjourxbee1.c,19 :: 		for (cpt=0; cpt<7; cpt++){
	CLRF       _cpt+0
	CLRF       _cpt+1
L_main4:
	MOVLW      128
	XORWF      _cpt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      7
	SUBWF      _cpt+0, 0
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;bonjourxbee1.c,20 :: 		i =tableau[cpt];
	MOVF       _cpt+0, 0
	ADDLW      _tableau+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _i+0
;bonjourxbee1.c,21 :: 		Uart1_Write(i);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;bonjourxbee1.c,19 :: 		for (cpt=0; cpt<7; cpt++){
	INCF       _cpt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cpt+1, 1
;bonjourxbee1.c,22 :: 		}
	GOTO       L_main4
L_main5:
;bonjourxbee1.c,23 :: 		saut_ligne() ;
	CALL       _saut_ligne+0
;bonjourxbee1.c,24 :: 		}
L_main3:
;bonjourxbee1.c,25 :: 		delay_ms(1000) ;
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;bonjourxbee1.c,26 :: 		PORTD =  ~PORTD ;
	COMF       PORTD+0, 1
;bonjourxbee1.c,27 :: 		}while(1);                 }
	GOTO       L_main0
L_end_main:
	GOTO       $+0
; end of _main
