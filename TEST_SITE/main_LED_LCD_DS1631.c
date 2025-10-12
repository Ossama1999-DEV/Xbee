/**!
 * @author DBIBIH Oussama
 * @date 2024-10-03
 * @file main_LED_LCD_DS1631.c
 * @brief Lecture de la température via le capteur DS1631 et affichage sur LCD
 *       avec gestion d'un bouton et d'une LED.
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
    TRISD = 0x01000000;

//  BOUCLE PRINCIPALE DU PROGRAMME
while(1) {

    // ------------------------------------------------------------------------
    // 1️⃣  Lecture de la température depuis le capteur DS1631
    // ------------------------------------------------------------------------
    // Le DS1631 communique en I2C : chaque transfert suit une séquence
    // "Start → Adresse → Commande → Stop" pour ordonner la mesure,
    // puis une autre séquence pour lire la donnée (MSB + LSB).
    I2C1_Start();          // Démarre la communication I2C
    I2C1_Wr(0x90);         // Envoie l’adresse du DS1631 (écriture : 0x90)
    I2C1_Wr(0xAA);         // Commande "Read Temperature"
    I2C1_Stop();           // Stop I2C (fin de la commande)
    Delay_ms(10);          // Petite pause pour la conversion interne

    I2C1_Start();          // Nouvelle séquence pour lecture
    I2C1_Wr(0x91);         // Adresse DS1631 en lecture (0x91)
    MSB = I2C1_Rd(1);      // Lecture du MSB (bit d’acquittement = 1 → continuer)
    LSB = I2C1_Rd(0);      // Lecture du LSB (dernier octet → ack = 0)
    I2C1_Stop();           // Stop I2C
    Delay_ms(10);          // Pause avant affichage

    // ------------------------------------------------------------------------
    // 2️⃣  Affichage de la température sur l’écran LCD
    // ------------------------------------------------------------------------
    Lcd_Cmd(_LCD_CLEAR);            // Efface l’écran avant nouvel affichage
    Lcd_Out(1, 5, "DS1631");        // Ligne 1 : identifiant du capteur
    Lcd_Out(2, 1, "Temp: ");        // Ligne 2 : début du texte de température

    IntToStr(MSB, msg);             // Conversion du MSB en texte ASCII
    Lcd_Out_CP(msg + 3);            // Affiche les 3 derniers caractères (évite espaces)
    Lcd_Chr_CP('.');                // Ajoute le point décimal

    // ------------------------------------------------------------------------
    // 3️⃣  Calcul et affichage du bit de fraction (0.5°C)
    // ------------------------------------------------------------------------
    // Le DS1631 encode la partie fractionnaire dans le bit 7 du LSB :
    //   - Si ce bit = 1 → ajouter 0.5°C
    //   - Si ce bit = 0 → partie fractionnaire = 0
    if (LSB & 0x80) {
        msg[6] = '5';               // Ajouter ".5"
    } else {
        msg[6] = '0';               // Ajouter ".0"
    }
    Lcd_Chr_CP(msg[6]);             // Affiche la fraction (.0 ou .5)
    Lcd_Chr_CP(223);                // Affiche le symbole ° (code ASCII 223)
    Lcd_Chr_CP('C');                // Ajoute la lettre C (°C)

    // ------------------------------------------------------------------------
    // 4️⃣  Gestion du bouton sur RD6 et de la LED sur RD7
    // ------------------------------------------------------------------------
    // Si le bouton (ou interrupteur) sur RD6 est activé (niveau haut),
    // alors la LED sur RD7 bascule d’état (clignote chaque seconde).
    // Sinon, elle reste éteinte.
    if (PORTD.F6 == 1) {
        PORTD.F7 = ~PORTD.F7;       // Inversion de l’état de la LED
        Delay_ms(1000);             // Délai d’1 seconde entre deux basculements
    } else {
        PORTD.F7 = 0;               // Si le bouton n’est pas appuyé → LED éteinte
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
}