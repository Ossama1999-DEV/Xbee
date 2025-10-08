
_DS1631_Read:

;ds1631_xbee_thermostat.c,57 :: 		unsigned DS1631_Read(char address, char reg) {
;ds1631_xbee_thermostat.c,59 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,60 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,61 :: 		Soft_I2C_Write(reg);                         // Envoyer la commande pour accéder à l'enregistrement.
	MOVF       FARG_DS1631_Read_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,62 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,63 :: 		Soft_I2C_Write(DS1631_ADDRESS(address) | 1); // Envoyer l'adresse du DS1631 + le mode de lecture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	BSF        FARG_Soft_I2C_Write_data_+0, 0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,64 :: 		((char*)&value)[1] = Soft_I2C_Read(1);       // Lire l'octet le plus significatif.
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+1
;ds1631_xbee_thermostat.c,65 :: 		((char*)&value)[0] = Soft_I2C_Read(0);       // Lire l'octet le moins significatif.
	CLRF       FARG_Soft_I2C_Read_ack+0
	CLRF       FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+0
;ds1631_xbee_thermostat.c,66 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,67 :: 		return value;
	MOVF       DS1631_Read_value_L0+0, 0
	MOVWF      R0+0
	MOVF       DS1631_Read_value_L0+1, 0
	MOVWF      R0+1
;ds1631_xbee_thermostat.c,68 :: 		}
L_end_DS1631_Read:
	RETURN
; end of _DS1631_Read

_DS1631_Write:

;ds1631_xbee_thermostat.c,71 :: 		void DS1631_Write(char address, char reg, unsigned value) {
;ds1631_xbee_thermostat.c,72 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,73 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));
	MOVF       FARG_DS1631_Write_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,74 :: 		Soft_I2C_Write(reg);
	MOVF       FARG_DS1631_Write_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,75 :: 		Soft_I2C_Write(((char*)&value)[1]); // MSB.
	MOVF       FARG_DS1631_Write_value+1, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,76 :: 		Soft_I2C_Write(((char*)&value)[0]); // LSB.
	MOVF       FARG_DS1631_Write_value+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,77 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,78 :: 		}
L_end_DS1631_Write:
	RETURN
; end of _DS1631_Write

_DS1631_Init:

;ds1631_xbee_thermostat.c,81 :: 		void DS1631_Init(char address, DS1631_Config * config) {
;ds1631_xbee_thermostat.c,82 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,83 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Init_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,84 :: 		Soft_I2C_Write(DS1631_CMD_ACCESS_CFG);       // Envoyer la commande pour accéder à l'enregistrement de configuration.
	MOVLW      172
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,85 :: 		Soft_I2C_Write(*(char*)config);              // Envoyer la valeur de configuration.
	MOVF       FARG_DS1631_Init_config+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,86 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,87 :: 		Delay_ms(10);                                // EEPROM Write Cycle Time.
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
;ds1631_xbee_thermostat.c,88 :: 		}
L_end_DS1631_Init:
	RETURN
; end of _DS1631_Init

_DS1631_Start:

;ds1631_xbee_thermostat.c,91 :: 		void DS1631_Start(char address) {
;ds1631_xbee_thermostat.c,92 :: 		Soft_I2C_Start();                            // Signal de start
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,93 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Start_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,94 :: 		Soft_I2C_Write(DS1631_CMD_START_CONVERT);    // Envoyer la commande pour démarrer la conversion.
	MOVLW      81
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,95 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,96 :: 		}
L_end_DS1631_Start:
	RETURN
; end of _DS1631_Start

_DS1631_Stop:

;ds1631_xbee_thermostat.c,99 :: 		void DS1631_Stop(char address) {
;ds1631_xbee_thermostat.c,100 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,101 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Stop_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,102 :: 		Soft_I2C_Write(DS1631_CMD_STOP_CONVERT);     // Envoyer la commande pour arrêter la conversion.
	MOVLW      34
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,103 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,104 :: 		}
L_end_DS1631_Stop:
	RETURN
; end of _DS1631_Stop

_DS1631_Reset:

;ds1631_xbee_thermostat.c,106 :: 		void DS1631_Reset(char address) {
;ds1631_xbee_thermostat.c,107 :: 		Soft_I2C_Start();                           // Signal de start
	CALL       _Soft_I2C_Start+0
;ds1631_xbee_thermostat.c,108 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));    // Envoyer l'adresse du DS1631 + le mode d'écriture.
	MOVF       FARG_DS1631_Reset_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,109 :: 		Soft_I2C_Write(DS1631_CMD_SOFT_POR);        // Envoyer la commande de réinitialisation.
	MOVLW      84
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;ds1631_xbee_thermostat.c,110 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;ds1631_xbee_thermostat.c,111 :: 		}
L_end_DS1631_Reset:
	RETURN
; end of _DS1631_Reset

_DS1631_Read_Temperature:

;ds1631_xbee_thermostat.c,114 :: 		DS1631_Temperature DS1631_Read_Temperature(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_su_addr+0
;ds1631_xbee_thermostat.c,116 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_READ);
	MOVF       FARG_DS1631_Read_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      170
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+1
;ds1631_xbee_thermostat.c,117 :: 		return temp;
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
;ds1631_xbee_thermostat.c,118 :: 		}
L_end_DS1631_Read_Temperature:
	RETURN
; end of _DS1631_Read_Temperature

_DS1631_Read_Temperature_Low:

;ds1631_xbee_thermostat.c,121 :: 		DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_Low_su_addr+0
;ds1631_xbee_thermostat.c,123 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TL);
	MOVF       FARG_DS1631_Read_Temperature_Low_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+1
;ds1631_xbee_thermostat.c,124 :: 		return temp;
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
;ds1631_xbee_thermostat.c,125 :: 		}
L_end_DS1631_Read_Temperature_Low:
	RETURN
; end of _DS1631_Read_Temperature_Low

_DS1631_Read_Temperature_High:

;ds1631_xbee_thermostat.c,128 :: 		DS1631_Temperature DS1631_Read_Temperature_High(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_High_su_addr+0
;ds1631_xbee_thermostat.c,130 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TH);
	MOVF       FARG_DS1631_Read_Temperature_High_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+1
;ds1631_xbee_thermostat.c,131 :: 		return temp;
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
;ds1631_xbee_thermostat.c,132 :: 		}
L_end_DS1631_Read_Temperature_High:
	RETURN
; end of _DS1631_Read_Temperature_High

_DS1631_Write_Temperature:

;ds1631_xbee_thermostat.c,135 :: 		void DS1631_Write_Temperature(char address, int low, int high) {
;ds1631_xbee_thermostat.c,136 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TH, high << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_high+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;ds1631_xbee_thermostat.c,138 :: 		Delay_ms(10);
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
;ds1631_xbee_thermostat.c,139 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TL, low << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_low+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;ds1631_xbee_thermostat.c,141 :: 		Delay_ms(10);
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
;ds1631_xbee_thermostat.c,142 :: 		}
L_end_DS1631_Write_Temperature:
	RETURN
; end of _DS1631_Write_Temperature

_xbee:

;ds1631_xbee_thermostat.c,145 :: 		void xbee(int nb, char receive [15]){
;ds1631_xbee_thermostat.c,147 :: 		Uart1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;ds1631_xbee_thermostat.c,148 :: 		for (i=0; i<nb; i++){
	CLRF       xbee_i_L0+0
	CLRF       xbee_i_L0+1
L_xbee6:
	MOVLW      128
	XORWF      xbee_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_xbee_nb+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__xbee27
	MOVF       FARG_xbee_nb+0, 0
	SUBWF      xbee_i_L0+0, 0
L__xbee27:
	BTFSC      STATUS+0, 0
	GOTO       L_xbee7
;ds1631_xbee_thermostat.c,149 :: 		Uart1_Write(receive[i]);
	MOVF       xbee_i_L0+0, 0
	ADDWF      FARG_xbee_receive+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;ds1631_xbee_thermostat.c,148 :: 		for (i=0; i<nb; i++){
	INCF       xbee_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       xbee_i_L0+1, 1
;ds1631_xbee_thermostat.c,151 :: 		}
	GOTO       L_xbee6
L_xbee7:
;ds1631_xbee_thermostat.c,153 :: 		}
L_end_xbee:
	RETURN
; end of _xbee

_main:

;ds1631_xbee_thermostat.c,161 :: 		void main() {
;ds1631_xbee_thermostat.c,165 :: 		char tableau[] = "Temperature ";
	MOVLW      84
	MOVWF      main_tableau_L0+0
	MOVLW      101
	MOVWF      main_tableau_L0+1
	MOVLW      109
	MOVWF      main_tableau_L0+2
	MOVLW      112
	MOVWF      main_tableau_L0+3
	MOVLW      101
	MOVWF      main_tableau_L0+4
	MOVLW      114
	MOVWF      main_tableau_L0+5
	MOVLW      97
	MOVWF      main_tableau_L0+6
	MOVLW      116
	MOVWF      main_tableau_L0+7
	MOVLW      117
	MOVWF      main_tableau_L0+8
	MOVLW      114
	MOVWF      main_tableau_L0+9
	MOVLW      101
	MOVWF      main_tableau_L0+10
	MOVLW      32
	MOVWF      main_tableau_L0+11
	CLRF       main_tableau_L0+12
	MOVLW      13
	MOVWF      main_saut_L0+0
	CLRF       main_saut_L0+1
	MOVLW      46
	MOVWF      main_point_L0+0
	CLRF       main_point_L0+1
;ds1631_xbee_thermostat.c,170 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;ds1631_xbee_thermostat.c,171 :: 		TRISD = 0x00100000;               // Configure D5 en entrée et les autres en sorties*/
	MOVLW      0
	MOVWF      TRISD+0
;ds1631_xbee_thermostat.c,173 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ds1631_xbee_thermostat.c,174 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ds1631_xbee_thermostat.c,175 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ds1631_xbee_thermostat.c,176 :: 		config.ONE_SHOT = 1;              // Mode one-shot.
	BSF        main_config_L0+0, 0
;ds1631_xbee_thermostat.c,177 :: 		config.POL = 1;                   // TOUT actif avec un niveau logique haut.
	BSF        main_config_L0+0, 1
;ds1631_xbee_thermostat.c,178 :: 		config.R = 3;                     // Resolution de 12 bits. //config.R = 0; // Resolution de 9 bits.
	MOVLW      12
	IORWF      main_config_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_config_L0+0
;ds1631_xbee_thermostat.c,180 :: 		DS1631_Init(0, &config);
	CLRF       FARG_DS1631_Init_address+0
	MOVLW      main_config_L0+0
	MOVWF      FARG_DS1631_Init_config+0
	CALL       _DS1631_Init+0
;ds1631_xbee_thermostat.c,182 :: 		DS1631_Write_Temperature(0, 20, 25);
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
;ds1631_xbee_thermostat.c,184 :: 		while(1) {
L_main9:
;ds1631_xbee_thermostat.c,186 :: 		DS1631_Start(0);
	CLRF       FARG_DS1631_Start_address+0
	CALL       _DS1631_Start+0
;ds1631_xbee_thermostat.c,188 :: 		Delay_ms(750);
	MOVLW      20
	MOVWF      R11+0
	MOVLW      7
	MOVWF      R12+0
	MOVLW      17
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;ds1631_xbee_thermostat.c,190 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ds1631_xbee_thermostat.c,191 :: 		Lcd_Out(1, 5, "DS1631");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ds1631_xbee_thermostat+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ds1631_xbee_thermostat.c,193 :: 		Lcd_Out(2
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
;ds1631_xbee_thermostat.c,194 :: 		, 1, "Temp: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ds1631_xbee_thermostat+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ds1631_xbee_thermostat.c,198 :: 		temp = DS1631_Read_Temperature(0);
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
L_main12:
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
	GOTO       L_main12
;ds1631_xbee_thermostat.c,199 :: 		IntToStr(temp.entiere, msg);      // Convertir la partie entière de la température en chaîne.
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
;ds1631_xbee_thermostat.c,200 :: 		xbee(11,tableau) ;
	MOVLW      11
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_tableau_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,201 :: 		xbee(1,saut);
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_saut_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,202 :: 		Lcd_Out_CP(msg + 3);    // ignorer les 3 blancs au début de la chaîne
	MOVLW      main_msg_L0+3
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;ds1631_xbee_thermostat.c,203 :: 		xbee(7,msg   );
	MOVLW      7
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_msg_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,204 :: 		Lcd_Chr_CP('.');      // Point décimal.
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;ds1631_xbee_thermostat.c,205 :: 		xbee (1, point) ;
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_point_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,206 :: 		LongIntToStrWithZeros(temp.decimal * 625, msg); // Convertit la partie décimale de la température en chaîne (String).
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
	MOVWF      FARG_LongIntToStrWithZeros_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_LongIntToStrWithZeros_input+1
	MOVLW      0
	BTFSC      FARG_LongIntToStrWithZeros_input+1, 7
	MOVLW      255
	MOVWF      FARG_LongIntToStrWithZeros_input+2
	MOVWF      FARG_LongIntToStrWithZeros_input+3
	MOVLW      main_msg_L0+0
	MOVWF      FARG_LongIntToStrWithZeros_output+0
	CALL       _LongIntToStrWithZeros+0
;ds1631_xbee_thermostat.c,207 :: 		Lcd_Out_CP(msg + 7);             //ignorer les 2 espaces vides au début de la chaîne.
	MOVLW      main_msg_L0+7
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;ds1631_xbee_thermostat.c,208 :: 		xbee(7,msg +7  );
	MOVLW      7
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_msg_L0+7
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,209 :: 		xbee(1,saut);
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_saut_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;ds1631_xbee_thermostat.c,210 :: 		Lcd_Chr_CP(223);                 // Symbole du point °."
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;ds1631_xbee_thermostat.c,211 :: 		Lcd_Chr_CP('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;ds1631_xbee_thermostat.c,215 :: 		if (PORTD.F5 = 1){
	BSF        PORTD+0, 5
	BTFSS      PORTD+0, 5
	GOTO       L_main13
;ds1631_xbee_thermostat.c,216 :: 		PORTD.F7 =  ~PORTD.F7;      // toggle D7
	MOVLW      128
	XORWF      PORTD+0, 1
;ds1631_xbee_thermostat.c,218 :: 		delay_ms(1000);             // one second delay
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
;ds1631_xbee_thermostat.c,219 :: 		}
	GOTO       L_main15
L_main13:
;ds1631_xbee_thermostat.c,221 :: 		PORTD.F7 = 0;
	BCF        PORTD+0, 7
L_main15:
;ds1631_xbee_thermostat.c,222 :: 		}
	GOTO       L_main9
;ds1631_xbee_thermostat.c,223 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
