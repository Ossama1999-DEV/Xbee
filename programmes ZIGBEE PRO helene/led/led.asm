
_main:

;led.c,6 :: 		void main() {
;led.c,7 :: 		PORTD = 0;
	CLRF       PORTD+0
;led.c,8 :: 		TRISD = 0;
	CLRF       TRISD+0
;led.c,9 :: 		while(1){
L_main0:
;led.c,10 :: 		PORTD.F7=~PORTD.F7;
	MOVLW      128
	XORWF      PORTD+0, 1
;led.c,11 :: 		delay_ms( 1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;led.c,12 :: 		}
	GOTO       L_main0
;led.c,13 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
