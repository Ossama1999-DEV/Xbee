  /*
    Nom du projet : LED_BP_LCD_DS1631
    Date de test : Juin 2020
    mikroC PRO for PIC v7.5.0
    Quartz : 8MHz
    PIC : 16F877

    Affectations LCD sur PORTB : 
    RS, EN, D7, D6, D5, D4 -> RB0, RB1, RB5, RB4, RB3, RB2

    Affectations DS1631 sur PORTC :
    SCL -> RC3, SDA -> RC4
  */

  // === LCD Pin Definitions ===
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

  // === DS1631 Pin Definitions ===
  sbit I2C1_Scl at RC3_bit;
  sbit I2C1_Sda at RC4_bit;
  sbit I2C1_Scl_Direction at TRISC3_bit;
  sbit I2C1_Sda_Direction at TRISC4_bit;

  // === Variables ===
  char LSB;
  signed char MSB;
  char msg[7];

  // === Prototypes ===
  void lcd(int li, int co, int nb, char receive[15]);
  void I2C1_TimeoutCallback(char errorCode);

  // === I2C Timeout Error Codes ===
  #define _I2C_TIMEOUT_RD             1
  #define _I2C_TIMEOUT_WR             2
  #define _I2C_TIMEOUT_START          3
  #define _I2C_TIMEOUT_REPEATED_START 4

  // === Main Function ===
  void main() {
    // LCD Initialization
    Lcd_Init();
    Lcd_Cmd(_Lcd_CLEAR);
    Lcd_Cmd(_Lcd_CURSOR_OFF);

    // I2C Initialization
    I2C1_Init(100000);
    //I2C1_SetTimeoutCallback(1000, I2C1_TimeoutCallback);

    // DS1631 Configuration
    I2C1_Start();
    I2C1_Wr(0x90);
    I2C1_Wr(0xAC);
    I2C1_Wr(0x0E);
    I2C1_Stop();
    Delay_ms(10);

    // Start Temperature Conversion
    I2C1_Start();
    I2C1_Wr(0x90);
    I2C1_Wr(0x51);
    I2C1_Stop();
    Delay_ms(10);

    // Seuils de température (commentés)
    /*
    // Seuil haut TH
    I2C1_Start();
    I2C1_Wr(0x90);
    I2C1_Wr(0xA1);
    I2C1_Wr(0x1E);
    I2C1_Wr(0x00);
    I2C1_Stop();
    Delay_ms(10);

    // Seuil bas TL
    I2C1_Start();
    I2C1_Wr(0x90);
    I2C1_Wr(0xA2);
    I2C1_Wr(0x14);
    I2C1_Wr(0x00);
    I2C1_Stop();
    Delay_ms(10);
    */

    PORTD = 0;
    TRISD = 0x01000000; // D6 en entrée, autres en sortie

    // === Main Loop ===
    while(1) {
      // Lecture température DS1631
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

      // Affichage LCD
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1, 5, "DS1631");
      Lcd_Out(2, 1, "Temp: ");

      IntToStr(MSB, msg);
      Lcd_Out_CP(msg + 3); // Ignore les 3 blancs
      Lcd_Chr_CP('.');

      // Prendre le bit du poids faible (0.5°C)
      if (LSB & 0x80) {
        msg[6] = '5';
      } else {
        msg[6] = '0';
      }
      Lcd_Chr_CP(msg[6]);

      Lcd_Chr_CP(223); // Symbole °
      Lcd_Chr_CP('C');

      // Gestion BP sur RD6 et LED sur RD7
      if (PORTD.F6 = 1) {
        PORTD.F7 = ~PORTD.F7; // Toggle D7
        Delay_ms(1000);
      } else {
        PORTD.F7 = 0;
      }
    }
  }

  // === LCD Affichage ===
  void lcd(int li, int co, int nb, char receive[15]) {
    int i;
    for(i = 0; i < nb; i++) {
      Lcd_chr(li, (co + i), receive[i]);
    }
  }

  // === I2C Timeout Callback ===
  void I2C1_TimeoutCallback(char errorCode) {
    if (errorCode == _I2C_TIMEOUT_RD) {
      // Timeout during read
    }
    if (errorCode == _I2C_TIMEOUT_WR) {
      // Timeout during write
    }
    if (errorCode == _I2C_TIMEOUT_START) {
      // Timeout during start
    }
    if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
      // Timeout during repeated start
    }
  }