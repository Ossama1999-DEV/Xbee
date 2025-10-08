
_main:

;lcd_ds1631.c,35 :: 		void main() {
;lcd_ds1631.c,37 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;lcd_ds1631.c,38 :: 		Lcd_Cmd(_Lcd_CLEAR);                // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631.c,39 :: 		Lcd_Cmd(_Lcd_CURSOR_OFF);           // Turn cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631.c,43 :: 		I2C1_Init(100000);       //initialisation de la communication I2C
	MOVLW      20
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;lcd_ds1631.c,46 :: 		I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
	CALL       _I2C1_Start+0
;lcd_ds1631.c,47 :: 		I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
	MOVLW      144
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,48 :: 		I2C1_Wr(0xAC);           //Accès au registre de configuration
	MOVLW      172
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,49 :: 		I2C1_Wr(0x0E);           //Registre de configuration mesure en continu
	MOVLW      14
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,50 :: 		I2C1_Stop();             //Arrêt du signal
	CALL       _I2C1_Stop+0
;lcd_ds1631.c,51 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
;lcd_ds1631.c,53 :: 		I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
	CALL       _I2C1_Start+0
;lcd_ds1631.c,54 :: 		I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
	MOVLW      144
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,55 :: 		I2C1_Wr(0x51);           //Début de la conversion
	MOVLW      81
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,56 :: 		I2C1_Stop();             //Arrêt du signal
	CALL       _I2C1_Stop+0
;lcd_ds1631.c,57 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	NOP
;lcd_ds1631.c,77 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;lcd_ds1631.c,78 :: 		TRISD = 0x01000000;               // Configure D6 en entrée et les autres en sorties*/
	MOVLW      0
	MOVWF      TRISD+0
;lcd_ds1631.c,80 :: 		while(1) {
L_main2:
;lcd_ds1631.c,81 :: 		I2C1_Start();        //Détermine si l'I2C est libre et lance le signal
	CALL       _I2C1_Start+0
;lcd_ds1631.c,82 :: 		I2C1_Wr(0x90);       //Mode de contrôle en mode écriture
	MOVLW      144
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,83 :: 		I2C1_Wr(0xAA);       //Lecture de la température
	MOVLW      170
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,84 :: 		I2C1_Stop();         //Arrêt du sigal
	CALL       _I2C1_Stop+0
;lcd_ds1631.c,85 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
;lcd_ds1631.c,86 :: 		I2C1_Start();        //Détermine si l'I2C est libre et lance le signal
	CALL       _I2C1_Start+0
;lcd_ds1631.c,87 :: 		I2C1_Wr(0x91);       //Mode de contrôle en mode lecture
	MOVLW      145
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;lcd_ds1631.c,88 :: 		MSB = I2C1_Rd(1);    //Nombre signé [température entre +125° et -55°C]
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _MSB+0
;lcd_ds1631.c,89 :: 		LSB = I2C1_Rd(0);    //Si bit 7 = 1 température MSB +0,5°C
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _LSB+0
;lcd_ds1631.c,92 :: 		I2C1_Stop();         //Arrêt du sigal
	CALL       _I2C1_Stop+0
;lcd_ds1631.c,93 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
;lcd_ds1631.c,95 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631.c,96 :: 		Lcd_Out(1, 5, "DS1631");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lcd_ds1631+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd_ds1631.c,97 :: 		Lcd_Out(2, 1, "Temp: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_lcd_ds1631+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd_ds1631.c,99 :: 		IntToStr(MSB, msg);               // Convertir la partie entière de la température en chaîne.
	MOVF       _MSB+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	BTFSC      FARG_IntToStr_input+0, 7
	MOVLW      255
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _msg+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;lcd_ds1631.c,100 :: 		Lcd_Out_CP(msg + 3);              // ignorer les 3 blancs au début de la chaîne
	MOVLW      _msg+3
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lcd_ds1631.c,101 :: 		Lcd_Chr_CP('.');                  // Point décimal.
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631.c,102 :: 		IntToStrWithZeros(LSB * 625, msg); // Convertit la partie décimale de la température en chaîne (String).
	MOVF       _LSB+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      113
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _msg+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;lcd_ds1631.c,103 :: 		Lcd_Out_CP(msg + 2);             //ignorer les 2 espaces vides au début de la chaîne.
	MOVLW      _msg+2
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lcd_ds1631.c,104 :: 		Lcd_Chr_CP(223);                 // Symbole du point °."
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631.c,105 :: 		Lcd_Chr_CP('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631.c,107 :: 		if (PORTD.F6 = 1){
	BSF        PORTD+0, 6
	BTFSS      PORTD+0, 6
	GOTO       L_main6
;lcd_ds1631.c,108 :: 		PORTD.F7 =  ~PORTD.F7;   // toggle D7
	MOVLW      128
	XORWF      PORTD+0, 1
;lcd_ds1631.c,109 :: 		delay_ms(1000);          // one second delay
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;lcd_ds1631.c,110 :: 		}
	GOTO       L_main8
L_main6:
;lcd_ds1631.c,112 :: 		PORTD.F7 = 0;
	BCF        PORTD+0, 7
L_main8:
;lcd_ds1631.c,113 :: 		}
	GOTO       L_main2
;lcd_ds1631.c,114 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_lcd:

;lcd_ds1631.c,116 :: 		void lcd(int li, int co, int nb, char receive[15])    {
;lcd_ds1631.c,118 :: 		for(i=0; i<nb ; i++) {                  //Boucle for
	CLRF       lcd_i_L0+0
	CLRF       lcd_i_L0+1
L_lcd9:
	MOVLW      128
	XORWF      lcd_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_lcd_nb+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__lcd18
	MOVF       FARG_lcd_nb+0, 0
	SUBWF      lcd_i_L0+0, 0
L__lcd18:
	BTFSC      STATUS+0, 0
	GOTO       L_lcd10
;lcd_ds1631.c,119 :: 		Lcd_chr(li, (co+i), receive[i]);}}  //Affiche les caractères jusqu'à i
	MOVF       FARG_lcd_li+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       lcd_i_L0+0, 0
	ADDWF      FARG_lcd_co+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       lcd_i_L0+0, 0
	ADDWF      FARG_lcd_receive+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;lcd_ds1631.c,118 :: 		for(i=0; i<nb ; i++) {                  //Boucle for
	INCF       lcd_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       lcd_i_L0+1, 1
;lcd_ds1631.c,119 :: 		Lcd_chr(li, (co+i), receive[i]);}}  //Affiche les caractères jusqu'à i
	GOTO       L_lcd9
L_lcd10:
L_end_lcd:
	RETURN
; end of _lcd

_I2C1_TimeoutCallback:

;lcd_ds1631.c,121 :: 		void I2C1_TimeoutCallback(char errorCode) {
;lcd_ds1631.c,122 :: 		if (errorCode == _I2C_TIMEOUT_RD) {
	MOVF       FARG_I2C1_TimeoutCallback_errorCode+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_I2C1_TimeoutCallback12
;lcd_ds1631.c,124 :: 		}
L_I2C1_TimeoutCallback12:
;lcd_ds1631.c,125 :: 		if (errorCode == _I2C_TIMEOUT_WR) {
	MOVF       FARG_I2C1_TimeoutCallback_errorCode+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_I2C1_TimeoutCallback13
;lcd_ds1631.c,127 :: 		}
L_I2C1_TimeoutCallback13:
;lcd_ds1631.c,128 :: 		if (errorCode == _I2C_TIMEOUT_START) {
	MOVF       FARG_I2C1_TimeoutCallback_errorCode+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_I2C1_TimeoutCallback14
;lcd_ds1631.c,130 :: 		}
L_I2C1_TimeoutCallback14:
;lcd_ds1631.c,131 :: 		if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
	MOVF       FARG_I2C1_TimeoutCallback_errorCode+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_I2C1_TimeoutCallback15
;lcd_ds1631.c,133 :: 		}
L_I2C1_TimeoutCallback15:
;lcd_ds1631.c,134 :: 		}
L_end_I2C1_TimeoutCallback:
	RETURN
; end of _I2C1_TimeoutCallback
