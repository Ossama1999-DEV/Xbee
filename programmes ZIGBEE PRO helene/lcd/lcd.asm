
_main:

;lcd.c,28 :: 		void main() {
;lcd.c,30 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;lcd.c,31 :: 		Lcd_Cmd(_Lcd_CLEAR);                // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,32 :: 		Lcd_Cmd(_Lcd_CURSOR_OFF);           // Turn cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,34 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;lcd.c,35 :: 		TRISD = 0b01000000;               // Configure D6 en entrée et les autres en sorties
	MOVLW      64
	MOVWF      TRISD+0
;lcd.c,37 :: 		while(1) {
L_main0:
;lcd.c,38 :: 		Lcd_Out(1, 1, text);         // Print text to LCD, 1nd row, 1st column
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,39 :: 		Lcd_Out(2, 1, text2);        // Print text to LCD, 2nd row, 1st column
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text2+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,41 :: 		if (PORTD.F6 = 1){
	BSF        PORTD+0, 6
	BTFSS      PORTD+0, 6
	GOTO       L_main2
;lcd.c,42 :: 		PORTD.F7 =  ~PORTD.F7;      // toggle D7
	MOVLW      128
	XORWF      PORTD+0, 1
;lcd.c,44 :: 		delay_ms(1000);             // one second delay
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;lcd.c,45 :: 		}
	GOTO       L_main4
L_main2:
;lcd.c,47 :: 		PORTD.F7 = 0;
	BCF        PORTD+0, 7
L_main4:
;lcd.c,48 :: 		}
	GOTO       L_main0
;lcd.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
