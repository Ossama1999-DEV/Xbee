#line 1 "E:/programmes ZIGBEE PRO helene/lcd_ds1631_thermostatmaquette/lcd_ds1631_thermostatmaquette.c"
#line 9 "E:/programmes ZIGBEE PRO helene/lcd_ds1631_thermostatmaquette/lcd_ds1631_thermostatmaquette.c"
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;


sbit Soft_I2C_Scl at RC3_bit;
sbit Soft_I2C_Sda at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;










typedef union {
char ONE_SHOT : 1;
char POL : 1;
char R : 2 ;
char NVB : 1;
char TLF : 1;
char THF : 1;
char DONE : 1;
} DS1631_Config;

typedef union {
char : 4;
char decimal : 4;
signed char entiere : 8;
} DS1631_Temperature;




unsigned DS1631_Read(char address, char reg) {
unsigned value;
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write(reg);
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1))  | 1);
((char*)&value)[1] = Soft_I2C_Read(1);
((char*)&value)[0] = Soft_I2C_Read(0);
Soft_I2C_Stop();
return value;
}


void DS1631_Write(char address, char reg, unsigned value) {
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write(reg);
Soft_I2C_Write(((char*)&value)[1]);
Soft_I2C_Write(((char*)&value)[0]);
Soft_I2C_Stop();
}


void DS1631_Init(char address, DS1631_Config * config) {
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write( 0xAC );
Soft_I2C_Write(*(char*)config);
Soft_I2C_Stop();
Delay_ms(10);
}


void DS1631_Start(char address) {
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write( 0x51 );
Soft_I2C_Stop();
}


void DS1631_Stop(char address) {
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write( 0x22 );
Soft_I2C_Stop();
}

void DS1631_Reset(char address) {
Soft_I2C_Start();
Soft_I2C_Write( (0x90 | (address << 1)) );
Soft_I2C_Write( 0x54 );
Soft_I2C_Stop();
}


DS1631_Temperature DS1631_Read_Temperature(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address,  0xAA );
return temp;
}


DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address,  0xA2 );
return temp;
}


DS1631_Temperature DS1631_Read_Temperature_High(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address,  0xA1 );
return temp;
}


void DS1631_Write_Temperature(char address, int low, int high) {
DS1631_Write(address,  0xA1 , high << 8);

Delay_ms(10);
DS1631_Write(address,  0xA2 , low << 8);

Delay_ms(10);
}

void main() {
DS1631_Config config;
DS1631_Temperature temp;
char msg[7];

PORTD = 0;
TRISD = 0x01000000;

Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
config.ONE_SHOT = 1;
config.POL = 0;
config.R = 0;

DS1631_Init(0, &config);

DS1631_Write_Temperature(0, 20, 25);

while(1) {

DS1631_Start(0);

Delay_ms(750);

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1, 5, "DS1631");
Lcd_Out(2, 1, "Temp: ");


temp = DS1631_Read_Temperature(0);
IntToStr(temp.entiere, msg);
Lcd_Out_CP(msg + 3);
Lcd_Chr_CP('.');
IntToStrWithZeros(temp.decimal * 625, msg);
Lcd_Out_CP(msg + 2);
Lcd_Chr_CP(223);
Lcd_Chr_CP('C');

if (PORTD.F6 = 1){
 PORTD.F7 = ~PORTD.F7;

 delay_ms(1000);
 }
 else
 PORTD.F7 = 0;
}
}
