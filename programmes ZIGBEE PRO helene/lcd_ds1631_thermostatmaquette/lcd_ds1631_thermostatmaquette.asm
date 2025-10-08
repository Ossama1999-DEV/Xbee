
_DS1631_Read:

;lcd_ds1631_thermostatmaquette.c,56 :: 		unsigned DS1631_Read(char address, char reg) {
;lcd_ds1631_thermostatmaquette.c,58 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,59 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,60 :: 		Soft_I2C_Write(reg);                         // Envoyer la commande pour accéder à l'enregistrement.
	MOVF       FARG_DS1631_Read_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,61 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,62 :: 		Soft_I2C_Write(DS1631_ADDRESS(address) | 1); // Envoyer l'adresse du DS1631 + le mode de lecture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	BSF        FARG_Soft_I2C_Write_data_+0, 0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,63 :: 		((char*)&value)[1] = Soft_I2C_Read(1);       // Lire l'octet le plus significatif.
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+1
;lcd_ds1631_thermostatmaquette.c,64 :: 		((char*)&value)[0] = Soft_I2C_Read(0);       // Lire l'octet le moins significatif.
	CLRF       FARG_Soft_I2C_Read_ack+0
	CLRF       FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+0
;lcd_ds1631_thermostatmaquette.c,65 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,66 :: 		return value;
	MOVF       DS1631_Read_value_L0+0, 0
	MOVWF      R0+0
	MOVF       DS1631_Read_value_L0+1, 0
	MOVWF      R0+1
;lcd_ds1631_thermostatmaquette.c,67 :: 		}
L_end_DS1631_Read:
	RETURN
; end of _DS1631_Read

_DS1631_Write:

;lcd_ds1631_thermostatmaquette.c,70 :: 		void DS1631_Write(char address, char reg, unsigned value) {
;lcd_ds1631_thermostatmaquette.c,71 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,72 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));
	MOVF       FARG_DS1631_Write_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,73 :: 		Soft_I2C_Write(reg);
	MOVF       FARG_DS1631_Write_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,74 :: 		Soft_I2C_Write(((char*)&value)[1]); // MSB.
	MOVF       FARG_DS1631_Write_value+1, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,75 :: 		Soft_I2C_Write(((char*)&value)[0]); // LSB.
	MOVF       FARG_DS1631_Write_value+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,76 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,77 :: 		}
L_end_DS1631_Write:
	RETURN
; end of _DS1631_Write

_DS1631_Init:

;lcd_ds1631_thermostatmaquette.c,80 :: 		void DS1631_Init(char address, DS1631_Config * config) {
;lcd_ds1631_thermostatmaquette.c,81 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,82 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Init_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,83 :: 		Soft_I2C_Write(DS1631_CMD_ACCESS_CFG);       // Envoyer la commande pour accéder à l'enregistrement de configuration.
	MOVLW      172
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,84 :: 		Soft_I2C_Write(*(char*)config);              // Envoyer la valeur de configuration.
	MOVF       FARG_DS1631_Init_config+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,85 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,86 :: 		Delay_ms(10);                                // EEPROM Write Cycle Time.
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_DS1631_Init0:
	DECFSZ     R13+0, 1
	GOTO       L_DS1631_Init0
	DECFSZ     R12+0, 1
	GOTO       L_DS1631_Init0
	NOP
;lcd_ds1631_thermostatmaquette.c,87 :: 		}
L_end_DS1631_Init:
	RETURN
; end of _DS1631_Init

_DS1631_Start:

;lcd_ds1631_thermostatmaquette.c,90 :: 		void DS1631_Start(char address) {
;lcd_ds1631_thermostatmaquette.c,91 :: 		Soft_I2C_Start();                            // Signal de start
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,92 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Start_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,93 :: 		Soft_I2C_Write(DS1631_CMD_START_CONVERT);    // Envoyer la commande pour démarrer la conversion.
	MOVLW      81
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,94 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,95 :: 		}
L_end_DS1631_Start:
	RETURN
; end of _DS1631_Start

_DS1631_Stop:

;lcd_ds1631_thermostatmaquette.c,98 :: 		void DS1631_Stop(char address) {
;lcd_ds1631_thermostatmaquette.c,99 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,100 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Stop_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,101 :: 		Soft_I2C_Write(DS1631_CMD_STOP_CONVERT);     // Envoyer la commande pour arrêter la conversion.
	MOVLW      34
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,102 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,103 :: 		}
L_end_DS1631_Stop:
	RETURN
; end of _DS1631_Stop

_DS1631_Reset:

;lcd_ds1631_thermostatmaquette.c,105 :: 		void DS1631_Reset(char address) {
;lcd_ds1631_thermostatmaquette.c,106 :: 		Soft_I2C_Start();                           // Signal de start
	CALL       _Soft_I2C_Start+0
;lcd_ds1631_thermostatmaquette.c,107 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));    // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Reset_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,108 :: 		Soft_I2C_Write(DS1631_CMD_SOFT_POR);        // Envoyer la commande de réinitialisation.
	MOVLW      84
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;lcd_ds1631_thermostatmaquette.c,109 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;lcd_ds1631_thermostatmaquette.c,110 :: 		}
L_end_DS1631_Reset:
	RETURN
; end of _DS1631_Reset

_DS1631_Read_Temperature:

;lcd_ds1631_thermostatmaquette.c,113 :: 		DS1631_Temperature DS1631_Read_Temperature(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_su_addr+0
;lcd_ds1631_thermostatmaquette.c,115 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_READ);
	MOVF       FARG_DS1631_Read_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      170
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+1
;lcd_ds1631_thermostatmaquette.c,116 :: 		return temp;
	MOVLW      2
	MOVWF      R3+0
	MOVF       _DS1631_Read_Temperature_su_addr+0, 0
	MOVWF      R2+0
	MOVLW      DS1631_Read_Temperature_temp_L0+0
	MOVWF      R1+0
L_DS1631_Read_Temperature1:
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R2+0, 1
	INCF       R1+0, 1
	DECF       R3+0, 1
	BTFSS      STATUS+0, 2
	GOTO       L_DS1631_Read_Temperature1
;lcd_ds1631_thermostatmaquette.c,117 :: 		}
L_end_DS1631_Read_Temperature:
	RETURN
; end of _DS1631_Read_Temperature

_DS1631_Read_Temperature_Low:

;lcd_ds1631_thermostatmaquette.c,120 :: 		DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_Low_su_addr+0
;lcd_ds1631_thermostatmaquette.c,122 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TL);
	MOVF       FARG_DS1631_Read_Temperature_Low_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+1
;lcd_ds1631_thermostatmaquette.c,123 :: 		return temp;
	MOVLW      2
	MOVWF      R3+0
	MOVF       _DS1631_Read_Temperature_Low_su_addr+0, 0
	MOVWF      R2+0
	MOVLW      DS1631_Read_Temperature_Low_temp_L0+0
	MOVWF      R1+0
L_DS1631_Read_Temperature_Low2:
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R2+0, 1
	INCF       R1+0, 1
	DECF       R3+0, 1
	BTFSS      STATUS+0, 2
	GOTO       L_DS1631_Read_Temperature_Low2
;lcd_ds1631_thermostatmaquette.c,124 :: 		}
L_end_DS1631_Read_Temperature_Low:
	RETURN
; end of _DS1631_Read_Temperature_Low

_DS1631_Read_Temperature_High:

;lcd_ds1631_thermostatmaquette.c,127 :: 		DS1631_Temperature DS1631_Read_Temperature_High(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_High_su_addr+0
;lcd_ds1631_thermostatmaquette.c,129 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TH);
	MOVF       FARG_DS1631_Read_Temperature_High_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+1
;lcd_ds1631_thermostatmaquette.c,130 :: 		return temp;
	MOVLW      2
	MOVWF      R3+0
	MOVF       _DS1631_Read_Temperature_High_su_addr+0, 0
	MOVWF      R2+0
	MOVLW      DS1631_Read_Temperature_High_temp_L0+0
	MOVWF      R1+0
L_DS1631_Read_Temperature_High3:
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R2+0, 1
	INCF       R1+0, 1
	DECF       R3+0, 1
	BTFSS      STATUS+0, 2
	GOTO       L_DS1631_Read_Temperature_High3
;lcd_ds1631_thermostatmaquette.c,131 :: 		}
L_end_DS1631_Read_Temperature_High:
	RETURN
; end of _DS1631_Read_Temperature_High

_DS1631_Write_Temperature:

;lcd_ds1631_thermostatmaquette.c,134 :: 		void DS1631_Write_Temperature(char address, int low, int high) {
;lcd_ds1631_thermostatmaquette.c,135 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TH, high << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_high+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;lcd_ds1631_thermostatmaquette.c,137 :: 		Delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_DS1631_Write_Temperature4:
	DECFSZ     R13+0, 1
	GOTO       L_DS1631_Write_Temperature4
	DECFSZ     R12+0, 1
	GOTO       L_DS1631_Write_Temperature4
	NOP
;lcd_ds1631_thermostatmaquette.c,138 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TL, low << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_low+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;lcd_ds1631_thermostatmaquette.c,140 :: 		Delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_DS1631_Write_Temperature5:
	DECFSZ     R13+0, 1
	GOTO       L_DS1631_Write_Temperature5
	DECFSZ     R12+0, 1
	GOTO       L_DS1631_Write_Temperature5
	NOP
;lcd_ds1631_thermostatmaquette.c,141 :: 		}
L_end_DS1631_Write_Temperature:
	RETURN
; end of _DS1631_Write_Temperature

_main:

;lcd_ds1631_thermostatmaquette.c,143 :: 		void main() {
;lcd_ds1631_thermostatmaquette.c,148 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;lcd_ds1631_thermostatmaquette.c,149 :: 		TRISD = 0x01000000;               // Configure D6 en entrée et les autres en sorties*/
	MOVLW      0
	MOVWF      TRISD+0
;lcd_ds1631_thermostatmaquette.c,151 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;lcd_ds1631_thermostatmaquette.c,152 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631_thermostatmaquette.c,153 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631_thermostatmaquette.c,154 :: 		config.ONE_SHOT = 1;              // Mode one-shot.
	BSF        main_config_L0+0, 0
;lcd_ds1631_thermostatmaquette.c,155 :: 		config.POL = 0;                   // TOUT actif avec un niveau logique haut.
	BCF        main_config_L0+0, 1
;lcd_ds1631_thermostatmaquette.c,156 :: 		config.R = 0;                     // Resolution de 12 bits. //config.R = 0; // Resolution de 9 bits.
	MOVLW      243
	ANDWF      main_config_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_config_L0+0
;lcd_ds1631_thermostatmaquette.c,158 :: 		DS1631_Init(0, &config);
	CLRF       FARG_DS1631_Init_address+0
	MOVLW      main_config_L0+0
	MOVWF      FARG_DS1631_Init_config+0
	CALL       _DS1631_Init+0
;lcd_ds1631_thermostatmaquette.c,160 :: 		DS1631_Write_Temperature(0, 20, 25);
	CLRF       FARG_DS1631_Write_Temperature_address+0
	MOVLW      20
	MOVWF      FARG_DS1631_Write_Temperature_low+0
	MOVLW      0
	MOVWF      FARG_DS1631_Write_Temperature_low+1
	MOVLW      25
	MOVWF      FARG_DS1631_Write_Temperature_high+0
	MOVLW      0
	MOVWF      FARG_DS1631_Write_Temperature_high+1
	CALL       _DS1631_Write_Temperature+0
;lcd_ds1631_thermostatmaquette.c,162 :: 		while(1) {
L_main6:
;lcd_ds1631_thermostatmaquette.c,164 :: 		DS1631_Start(0);
	CLRF       FARG_DS1631_Start_address+0
	CALL       _DS1631_Start+0
;lcd_ds1631_thermostatmaquette.c,166 :: 		Delay_ms(750);
	MOVLW      20
	MOVWF      R11+0
	MOVLW      7
	MOVWF      R12+0
	MOVLW      17
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;lcd_ds1631_thermostatmaquette.c,168 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd_ds1631_thermostatmaquette.c,169 :: 		Lcd_Out(1, 5, "DS1631");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lcd_ds1631_thermostatmaquette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd_ds1631_thermostatmaquette.c,170 :: 		Lcd_Out(2, 1, "Temp: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_lcd_ds1631_thermostatmaquette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd_ds1631_thermostatmaquette.c,173 :: 		temp = DS1631_Read_Temperature(0);
	CLRF       FARG_DS1631_Read_Temperature_address+0
	MOVLW      FLOC__main+0
	MOVWF      R0+0
	CALL       _DS1631_Read_Temperature+0
	MOVLW      2
	MOVWF      R3+0
	MOVLW      main_temp_L0+0
	MOVWF      R2+0
	MOVLW      FLOC__main+0
	MOVWF      R1+0
L_main9:
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R2+0, 1
	INCF       R1+0, 1
	DECF       R3+0, 1
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;lcd_ds1631_thermostatmaquette.c,174 :: 		IntToStr(temp.entiere, msg);      // Convertir la partie entière de la température en chaîne.
	MOVLW      255
	ANDWF      main_temp_L0+1, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      0
	ANDWF      FARG_IntToStr_input+1, 1
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_msg_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;lcd_ds1631_thermostatmaquette.c,175 :: 		Lcd_Out_CP(msg + 3);              // ignorer les 3 blancs au début de la chaîne
	MOVLW      main_msg_L0+3
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lcd_ds1631_thermostatmaquette.c,176 :: 		Lcd_Chr_CP('.');                  // Point décimal.
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631_thermostatmaquette.c,177 :: 		IntToStrWithZeros(temp.decimal * 625, msg); // Convertit la partie décimale de la température en chaîne (String).
	MOVLW      240
	ANDWF      main_temp_L0+0, 0
	MOVWF      R4+0
	RRF        R4+0, 1
	BCF        R4+0, 7
	RRF        R4+0, 1
	BCF        R4+0, 7
	RRF        R4+0, 1
	BCF        R4+0, 7
	RRF        R4+0, 1
	BCF        R4+0, 7
	MOVLW      113
	MOVWF      R0+0
	MOVLW      2
	MOVWF      R0+1
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      main_msg_L0+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;lcd_ds1631_thermostatmaquette.c,178 :: 		Lcd_Out_CP(msg + 2);             //ignorer les 2 espaces vides au début de la chaîne.
	MOVLW      main_msg_L0+2
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lcd_ds1631_thermostatmaquette.c,179 :: 		Lcd_Chr_CP(223);                 // Symbole du point °."
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631_thermostatmaquette.c,180 :: 		Lcd_Chr_CP('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;lcd_ds1631_thermostatmaquette.c,182 :: 		if (PORTD.F6 = 1){
	BSF        PORTD+0, 6
	BTFSS      PORTD+0, 6
	GOTO       L_main10
;lcd_ds1631_thermostatmaquette.c,183 :: 		PORTD.F7 =  ~PORTD.F7;      // toggle D7
	MOVLW      128
	XORWF      PORTD+0, 1
;lcd_ds1631_thermostatmaquette.c,185 :: 		delay_ms(1000);             // one second delay
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
;lcd_ds1631_thermostatmaquette.c,186 :: 		}
	GOTO       L_main12
L_main10:
;lcd_ds1631_thermostatmaquette.c,188 :: 		PORTD.F7 = 0;
	BCF        PORTD+0, 7
L_main12:
;lcd_ds1631_thermostatmaquette.c,189 :: 		}
	GOTO       L_main6
;lcd_ds1631_thermostatmaquette.c,190 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
