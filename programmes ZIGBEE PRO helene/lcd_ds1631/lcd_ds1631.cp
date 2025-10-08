#line 1 "E:/programmes ZIGBEE PRO helene/lcd_ds1631/lcd_ds1631.c"
#line 9 "E:/programmes ZIGBEE PRO helene/lcd_ds1631/lcd_ds1631.c"
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

sbit I2C1_Scl at RC3_bit;
sbit I2C1_Sda at RC4_bit;
sbit I2C1_Scl_Direction at TRISC3_bit;
sbit I2C1_Sda_Direction at TRISC4_bit;

char LSB;
signed char MSB;
char msg[7];

void lcd(int li, int co, int nb, char receive[15]);

 I2C1_TimeoutCallback(char errorCode);


void main() {

 Lcd_Init();
 Lcd_Cmd(_Lcd_CLEAR);
 Lcd_Cmd(_Lcd_CURSOR_OFF);



 I2C1_Init(100000);


 I2C1_Start();
 I2C1_Wr(0x90);
 I2C1_Wr(0xAC);
 I2C1_Wr(0x0E);
 I2C1_Stop();
 Delay_ms(10);

 I2C1_Start();
 I2C1_Wr(0x90);
 I2C1_Wr(0x51);
 I2C1_Stop();
 Delay_ms(10);
#line 78 "E:/programmes ZIGBEE PRO helene/lcd_ds1631/lcd_ds1631.c"
 PORTD = 0;
 TRISD = 0x01000000;

while(1) {
 I2C1_Start();
 I2C1_Wr(0x90);
 I2C1_Wr(0xAA);
 I2C1_Stop();
 Delay_ms(10);
 I2C1_Start();
 I2C1_Wr(0x91);
 MSB = I2C1_Rd(1);
 LSB = I2C1_Rd(0);


 I2C1_Stop();
 Delay_ms(10);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 5, "DS1631");
 Lcd_Out(2, 1, "Temp: ");

 IntToStr(MSB, msg);
 Lcd_Out_CP(msg + 3);
 Lcd_Chr_CP('.');
 IntToStrWithZeros(LSB * 625, msg);
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

 void lcd(int li, int co, int nb, char receive[15]) {
 int i;
 for(i=0; i<nb ; i++) {
 Lcd_chr(li, (co+i), receive[i]);}}

void I2C1_TimeoutCallback(char errorCode) {
 if (errorCode == _I2C_TIMEOUT_RD) {

 }
 if (errorCode == _I2C_TIMEOUT_WR) {

 }
 if (errorCode == _I2C_TIMEOUT_START) {

 }
 if (errorCode == _I2C_TIMEOUT_REPEATED_START) {

 }
}
