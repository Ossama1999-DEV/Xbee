
_main:

;led1maquette.c,11 :: 		void main() {
;led1maquette.c,14 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;led1maquette.c,15 :: 		TRISD = 0;               // Configure D  en sorties
	CLRF       TRISD+0
;led1maquette.c,17 :: 		while(1) {
L_main0:
;led1maquette.c,20 :: 		PORTD =  ~PORTD;          // toggle PORTD
	COMF       PORTD+0, 1
;led1maquette.c,21 :: 		delay_ms(1000);             // one second delay
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;led1maquette.c,22 :: 		}
	GOTO       L_main0
;led1maquette.c,23 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
