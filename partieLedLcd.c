/*  Nom du projet : LED_BP_LCD
    Date de test : Juin 2020
    mikroC PRO for PIC v 7.6.0
    Q 20Mhz
    PIC / 16F877
*/

// LCD module connections
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
// End LCD module connections

char *text = "OUSSAMA";
char *text2 = "MATTHIS";

void main() {

  Lcd_Init();
  Lcd_Cmd(_Lcd_CLEAR);                // Clear display
  Lcd_Cmd(_Lcd_CURSOR_OFF);           // Turn cursor off

  PORTD = 0;                        // Initialize PORTC
  TRISD = 0b01000000;               // Configure D6 en entr?e et les autres en sorties

  while(1) {
    Lcd_Out(1, 1, text);         // Print text to LCD, 1nd row, 1st column
    Lcd_Out(2, 1, text2);        // Print text to LCD, 2nd row, 1st column

    if (PORTD.F6 = 1){
    PORTD.F7 =  ~PORTD.F7;      // toggle D7
    //PORTD =  ~PORTD;          // toggle PORTD
    delay_ms(1000);             // one second delay
    }
    else
    PORTD.F7 = 0;
  }
}