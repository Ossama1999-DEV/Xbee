#line 1 "C:/Users/hélène/Desktop/helene juil 2021/cesi/aspects technologiques/TP ZigBee/programmes ZIGBEE PRO helene/lcdmaquette/lcdmaquette.c"
#line 10 "C:/Users/hélène/Desktop/helene juil 2021/cesi/aspects technologiques/TP ZigBee/programmes ZIGBEE PRO helene/lcdmaquette/lcdmaquette.c"
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


char *text = "TEST";
char *text2 = "PAUSE CAFE";

void main() {

 Lcd_Init();
 Lcd_Cmd(_Lcd_CLEAR);
 Lcd_Cmd(_Lcd_CURSOR_OFF);

 PORTD = 0;
 TRISD = 0b01000000;

 while(1) {
 Lcd_Out(1, 1, text);
 Lcd_Out(2, 1, text2);

 if (PORTD.F6 = 1){
 PORTD.F7 = ~PORTD.F7;

 delay_ms(1000);
 }
 else
 PORTD.F7 = 0;
 }
}
