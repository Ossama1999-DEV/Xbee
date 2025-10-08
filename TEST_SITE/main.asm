
_DS1631_Read:

;main.c,59 :: 		unsigned DS1631_Read(char address, char reg) {
;main.c,61 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;main.c,62 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,63 :: 		Soft_I2C_Write(reg);                         // Envoyer la commande pour acc?der ? l'enregistrement.
	MOVF       FARG_DS1631_Read_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,64 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;main.c,65 :: 		Soft_I2C_Write(DS1631_ADDRESS(address) | 1); // Envoyer l'adresse du DS1631 + le mode de lecture.
	MOVF       FARG_DS1631_Read_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	BSF        FARG_Soft_I2C_Write_data_+0, 0
	CALL       _Soft_I2C_Write+0
;main.c,66 :: 		((char*)&value)[1] = Soft_I2C_Read(1);       // Lire l'octet le plus significatif.
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+1
;main.c,67 :: 		((char*)&value)[0] = Soft_I2C_Read(0);       // Lire l'octet le moins significatif.
	CLRF       FARG_Soft_I2C_Read_ack+0
	CLRF       FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_value_L0+0
;main.c,68 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;main.c,69 :: 		return value;
	MOVF       DS1631_Read_value_L0+0, 0
	MOVWF      R0+0
	MOVF       DS1631_Read_value_L0+1, 0
	MOVWF      R0+1
;main.c,70 :: 		}
L_end_DS1631_Read:
	RETURN
; end of _DS1631_Read

_DS1631_Write:

;main.c,73 :: 		void DS1631_Write(char address, char reg, unsigned value) {
;main.c,74 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;main.c,75 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));
	MOVF       FARG_DS1631_Write_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,76 :: 		Soft_I2C_Write(reg);
	MOVF       FARG_DS1631_Write_reg+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,77 :: 		Soft_I2C_Write(((char*)&value)[1]); // MSB.
	MOVF       FARG_DS1631_Write_value+1, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,78 :: 		Soft_I2C_Write(((char*)&value)[0]); // LSB.
	MOVF       FARG_DS1631_Write_value+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,79 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;main.c,80 :: 		}
L_end_DS1631_Write:
	RETURN
; end of _DS1631_Write

_DS1631_Init:

;main.c,83 :: 		void DS1631_Init(char address, DS1631_Config * config) {
;main.c,84 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;main.c,85 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
	MOVF       FARG_DS1631_Init_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,86 :: 		Soft_I2C_Write(DS1631_CMD_ACCESS_CFG);       // Envoyer la commande pour acc?der ? l'enregistrement de configuration.
	MOVLW      172
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,87 :: 		Soft_I2C_Write(*(char*)config);              // Envoyer la valeur de configuration.
	MOVF       FARG_DS1631_Init_config+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,88 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;main.c,89 :: 		Delay_ms(10);                                // EEPROM Write Cycle Time.
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
;main.c,90 :: 		}
L_end_DS1631_Init:
	RETURN
; end of _DS1631_Init

_DS1631_Start:

;main.c,93 :: 		void DS1631_Start(char address) {
;main.c,94 :: 		Soft_I2C_Start();                            // Signal de start
	CALL       _Soft_I2C_Start+0
;main.c,95 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
	MOVF       FARG_DS1631_Start_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,96 :: 		Soft_I2C_Write(DS1631_CMD_START_CONVERT);    // Envoyer la commande pour d?marrer la conversion.
	MOVLW      81
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,97 :: 		Soft_I2C_Stop();                             // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;main.c,98 :: 		}
L_end_DS1631_Start:
	RETURN
; end of _DS1631_Start

_DS1631_Stop:

;main.c,101 :: 		void DS1631_Stop(char address) {
;main.c,102 :: 		Soft_I2C_Start();                            // Signal de start.
	CALL       _Soft_I2C_Start+0
;main.c,103 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
	MOVF       FARG_DS1631_Stop_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,104 :: 		Soft_I2C_Write(DS1631_CMD_STOP_CONVERT);     // Envoyer la commande pour arr?ter la conversion.
	MOVLW      34
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,105 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;main.c,106 :: 		}
L_end_DS1631_Stop:
	RETURN
; end of _DS1631_Stop

_DS1631_Reset:

;main.c,108 :: 		void DS1631_Reset(char address) {
;main.c,109 :: 		Soft_I2C_Start();                           // Signal de start
	CALL       _Soft_I2C_Start+0
;main.c,110 :: 		Soft_I2C_Write(DS1631_ADDRESS(address));    // Envoyer l'adresse du DS1631 + le mode d'?criture.
	MOVF       FARG_DS1631_Reset_address+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      144
	IORWF      R0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,111 :: 		Soft_I2C_Write(DS1631_CMD_SOFT_POR);        // Envoyer la commande de r?initialisation.
	MOVLW      84
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;main.c,112 :: 		Soft_I2C_Stop();                            // Signal de stop.
	CALL       _Soft_I2C_Stop+0
;main.c,113 :: 		}
L_end_DS1631_Reset:
	RETURN
; end of _DS1631_Reset

_DS1631_Read_Temperature:

;main.c,116 :: 		DS1631_Temperature DS1631_Read_Temperature(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_su_addr+0
;main.c,118 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_READ);
	MOVF       FARG_DS1631_Read_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      170
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_temp_L0+1
;main.c,119 :: 		return temp;
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
;main.c,120 :: 		}
L_end_DS1631_Read_Temperature:
	RETURN
; end of _DS1631_Read_Temperature

_DS1631_Read_Temperature_Low:

;main.c,123 :: 		DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_Low_su_addr+0
;main.c,125 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TL);
	MOVF       FARG_DS1631_Read_Temperature_Low_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_Low_temp_L0+1
;main.c,126 :: 		return temp;
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
;main.c,127 :: 		}
L_end_DS1631_Read_Temperature_Low:
	RETURN
; end of _DS1631_Read_Temperature_Low

_DS1631_Read_Temperature_High:

;main.c,130 :: 		DS1631_Temperature DS1631_Read_Temperature_High(char address) {
	MOVF       R0+0, 0
	MOVWF      _DS1631_Read_Temperature_High_su_addr+0
;main.c,132 :: 		*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TH);
	MOVF       FARG_DS1631_Read_Temperature_High_address+0, 0
	MOVWF      FARG_DS1631_Read_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Read_reg+0
	CALL       _DS1631_Read+0
	MOVF       R0+0, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      DS1631_Read_Temperature_High_temp_L0+1
;main.c,133 :: 		return temp;
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
;main.c,134 :: 		}
L_end_DS1631_Read_Temperature_High:
	RETURN
; end of _DS1631_Read_Temperature_High

_DS1631_Write_Temperature:

;main.c,137 :: 		void DS1631_Write_Temperature(char address, int low, int high) {
;main.c,138 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TH, high << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      161
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_high+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;main.c,140 :: 		Delay_ms(10);
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
;main.c,141 :: 		DS1631_Write(address, DS1631_CMD_ACCESS_TL, low << 8);
	MOVF       FARG_DS1631_Write_Temperature_address+0, 0
	MOVWF      FARG_DS1631_Write_address+0
	MOVLW      162
	MOVWF      FARG_DS1631_Write_reg+0
	MOVF       FARG_DS1631_Write_Temperature_low+0, 0
	MOVWF      FARG_DS1631_Write_value+1
	CLRF       FARG_DS1631_Write_value+0
	CALL       _DS1631_Write+0
;main.c,143 :: 		Delay_ms(10);
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
;main.c,144 :: 		}
L_end_DS1631_Write_Temperature:
	RETURN
; end of _DS1631_Write_Temperature

_xbee:

;main.c,147 :: 		void xbee(int nb, char receive [15]){
;main.c,149 :: 		Uart1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,150 :: 		for (i=0; i<nb; i++){
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
	GOTO       L__xbee35
	MOVF       FARG_xbee_nb+0, 0
	SUBWF      xbee_i_L0+0, 0
L__xbee35:
	BTFSC      STATUS+0, 0
	GOTO       L_xbee7
;main.c,151 :: 		Uart1_Write(receive[i]);
	MOVF       xbee_i_L0+0, 0
	ADDWF      FARG_xbee_receive+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;main.c,150 :: 		for (i=0; i<nb; i++){
	INCF       xbee_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       xbee_i_L0+1, 1
;main.c,152 :: 		}
	GOTO       L_xbee6
L_xbee7:
;main.c,153 :: 		}
L_end_xbee:
	RETURN
; end of _xbee

_xbee_hibernate:

;main.c,155 :: 		void xbee_hibernate() {
;main.c,156 :: 		PORTD.F1 = 1;     // SLEEP_RQ = 1 => hibernation
	BSF        PORTD+0, 1
;main.c,157 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_xbee_hibernate9:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_hibernate9
	DECFSZ     R12+0, 1
	GOTO       L_xbee_hibernate9
	DECFSZ     R11+0, 1
	GOTO       L_xbee_hibernate9
	NOP
	NOP
;main.c,158 :: 		PORTD.F3 = 1;     // LED allumée pendant le sommeil
	BSF        PORTD+0, 3
;main.c,159 :: 		delay_ms(2000);   // Laisse la LED allumée 2 secondes pour bien voir
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_xbee_hibernate10:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_hibernate10
	DECFSZ     R12+0, 1
	GOTO       L_xbee_hibernate10
	DECFSZ     R11+0, 1
	GOTO       L_xbee_hibernate10
	NOP
	NOP
;main.c,160 :: 		PORTD.F3 = 0;     // Puis éteinte
	BCF        PORTD+0, 3
;main.c,161 :: 		}
L_end_xbee_hibernate:
	RETURN
; end of _xbee_hibernate

_xbee_wake:

;main.c,163 :: 		void xbee_wake() {
;main.c,164 :: 		PORTD.F0 = 0;     // reset actif bas
	BCF        PORTD+0, 0
;main.c,165 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_xbee_wake11:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_wake11
	DECFSZ     R12+0, 1
	GOTO       L_xbee_wake11
	NOP
;main.c,166 :: 		PORTD.F0 = 1;     // reset relâché
	BSF        PORTD+0, 0
;main.c,167 :: 		delay_ms(500);    // attendre que le XBee démarre
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_xbee_wake12:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_wake12
	DECFSZ     R12+0, 1
	GOTO       L_xbee_wake12
	DECFSZ     R11+0, 1
	GOTO       L_xbee_wake12
	NOP
;main.c,169 :: 		PORTD.F1 = 0;     // SLEEP_RQ = 0 => réveil
	BCF        PORTD+0, 1
;main.c,170 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_xbee_wake13:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_wake13
	DECFSZ     R12+0, 1
	GOTO       L_xbee_wake13
	DECFSZ     R11+0, 1
	GOTO       L_xbee_wake13
	NOP
	NOP
;main.c,172 :: 		PORTD.F2 = 1;     // Allume une LED pendant wake
	BSF        PORTD+0, 2
;main.c,173 :: 		delay_ms(1000);   // Durée visible (1s)
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_xbee_wake14:
	DECFSZ     R13+0, 1
	GOTO       L_xbee_wake14
	DECFSZ     R12+0, 1
	GOTO       L_xbee_wake14
	DECFSZ     R11+0, 1
	GOTO       L_xbee_wake14
	NOP
;main.c,174 :: 		PORTD.F2 = 0;     // Éteint après
	BCF        PORTD+0, 2
;main.c,175 :: 		}
L_end_xbee_wake:
	RETURN
; end of _xbee_wake

_main:

;main.c,178 :: 		void main() {
;main.c,182 :: 		char tableau[] = "Temperature ";
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
	MOVLW      10
	MOVWF      main_saut_L0+1
	CLRF       main_saut_L0+2
	MOVLW      46
	MOVWF      main_point_L0+0
	CLRF       main_point_L0+1
	MOVLW      67
	MOVWF      main_degres_L0+0
	CLRF       main_degres_L0+1
;main.c,187 :: 		PORTD = 0;                        // Initialize PORTC
	CLRF       PORTD+0
;main.c,188 :: 		TRISD = 0b00100000;               // Configure D5 en entr?e et les autres en sorties
	MOVLW      32
	MOVWF      TRISD+0
;main.c,193 :: 		TRISD.F0 = 0; // RD0 : RESET -> sortie
	BCF        TRISD+0, 0
;main.c,194 :: 		TRISD.F1 = 0; // RD1 : SLEEP_RQ -> sortie
	BCF        TRISD+0, 1
;main.c,195 :: 		TRISD.F6 = 1; // RD6 : bouton -> entrée
	BSF        TRISD+0, 6
;main.c,196 :: 		TRISD.F2 = 0; // LED témoin wake
	BCF        TRISD+0, 2
;main.c,197 :: 		TRISD.F3 = 0; // LED témoin sleep
	BCF        TRISD+0, 3
;main.c,201 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;main.c,202 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,203 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,204 :: 		config.ONE_SHOT = 1;              // Mode one-shot.
	BSF        main_config_L0+0, 0
;main.c,205 :: 		config.POL = 1;                   // TOUT actif avec un niveau logique haut.
	BSF        main_config_L0+0, 1
;main.c,206 :: 		config.R = 3;                     // Resolution de 12 bits. //config.R = 0; // Resolution de 9 bits.
	MOVLW      12
	IORWF      main_config_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_config_L0+0
;main.c,208 :: 		DS1631_Init(0, &config);
	CLRF       FARG_DS1631_Init_address+0
	MOVLW      main_config_L0+0
	MOVWF      FARG_DS1631_Init_config+0
	CALL       _DS1631_Init+0
;main.c,210 :: 		DS1631_Write_Temperature(0, 20, 25);
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
;main.c,212 :: 		while(1) {
L_main15:
;main.c,214 :: 		DS1631_Start(0);
	CLRF       FARG_DS1631_Start_address+0
	CALL       _DS1631_Start+0
;main.c,216 :: 		Delay_ms(750);
	MOVLW      20
	MOVWF      R11+0
	MOVLW      7
	MOVWF      R12+0
	MOVLW      17
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;main.c,218 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,219 :: 		Lcd_Out(1, 5, "DS1631");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,221 :: 		Lcd_Out(2, 1, "Temp: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,228 :: 		xbee_wake();  // réveiller le XBee
	CALL       _xbee_wake+0
;main.c,231 :: 		temp = DS1631_Read_Temperature(0);
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
L_main18:
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
	GOTO       L_main18
;main.c,234 :: 		if (((unsigned*)&temp)[0] & 0x80) {
	BTFSS      main_temp_L0+0, 7
	GOTO       L_main19
;main.c,235 :: 		temp.entiere += 0;          // on garde l'entier
	MOVLW      255
	ANDWF      main_temp_L0+1, 0
	MOVWF      R0+0
	MOVF       main_temp_L0+1, 0
	XORWF      R0+0, 1
	MOVLW      255
	ANDWF      R0+0, 1
	MOVF       main_temp_L0+1, 0
	XORWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+1
;main.c,236 :: 		temp.decimal = 5;           // on force 0.5
	MOVLW      80
	XORWF      main_temp_L0+0, 0
	MOVWF      R0+0
	MOVLW      240
	ANDWF      R0+0, 1
	MOVF       main_temp_L0+0, 0
	XORWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
;main.c,237 :: 		} else {
	GOTO       L_main20
L_main19:
;main.c,238 :: 		temp.decimal = 0;           // sinon, c'est .0
	MOVLW      15
	ANDWF      main_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
;main.c,239 :: 		}
L_main20:
;main.c,242 :: 		IntToStr(temp.entiere, msg);  // msg contient des blancs initiaux
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
;main.c,243 :: 		xbee(11,tableau);           // afficher température
	MOVLW      11
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_tableau_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,244 :: 		Lcd_Out_CP(msg);          // sauter les 3 blancs
	MOVLW      main_msg_L0+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;main.c,245 :: 		xbee(3, msg + 3);
	MOVLW      3
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_msg_L0+3
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,246 :: 		xbee(1, point);               // envoyer le point décimal
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_point_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,247 :: 		Lcd_Chr_CP('.');
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,250 :: 		msg[0] = temp.decimal + '0';  // convertir chiffre en ASCII
	MOVLW      240
	ANDWF      main_temp_L0+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	MOVLW      48
	ADDWF      R1+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      main_msg_L0+0
;main.c,251 :: 		msg[1] = '\0';                // fin de chaîne
	CLRF       main_msg_L0+1
;main.c,252 :: 		Lcd_Out_CP(msg);              // afficher .0 ou .5
	MOVLW      main_msg_L0+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;main.c,253 :: 		xbee(1, msg);
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_msg_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,255 :: 		Lcd_Chr_CP(223);
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,256 :: 		Lcd_Chr_CP('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,257 :: 		xbee(1, degres);
	MOVLW      1
	MOVWF      FARG_xbee_nb+0
	MOVLW      0
	MOVWF      FARG_xbee_nb+1
	MOVLW      main_degres_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,258 :: 		xbee(2, saut);
	MOVLW      2
	MOVWF      FARG_xbee_nb+0
	CLRF       FARG_xbee_nb+1
	MOVLW      main_saut_L0+0
	MOVWF      FARG_xbee_receive+0
	CALL       _xbee+0
;main.c,265 :: 		xbee_hibernate();  // endormir le XBee
	CALL       _xbee_hibernate+0
;main.c,267 :: 		if (PORTD.F6 = 1){
	BSF        PORTD+0, 6
	BTFSS      PORTD+0, 6
	GOTO       L_main21
;main.c,268 :: 		PORTD.F7 =  ~PORTD.F7;      // toggle D7
	MOVLW      128
	XORWF      PORTD+0, 1
;main.c,269 :: 		delay_ms(1000);             // one second delay
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
;main.c,270 :: 		}
	GOTO       L_main23
L_main21:
;main.c,272 :: 		PORTD.F7 = 0;
	BCF        PORTD+0, 7
L_main23:
;main.c,273 :: 		}
	GOTO       L_main15
;main.c,274 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
