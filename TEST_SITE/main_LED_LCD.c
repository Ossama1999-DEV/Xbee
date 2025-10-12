/**!
 * @author DBIBIH Oussama
 * @date 2024-10-03
 * @file partieLedLcd.c
 * @brief Gestion d'un bouton et d'une LED avec affichage sur écran LCD
 *      (sans capteur de température).
 */

// LCD module connections
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

//  LCD module direction pins
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;

// Variables
char *text = "OUSSAMA";
char *text2 = "MATTHIS";

// Prototypes
void main() {

  Lcd_Init();
  Lcd_Cmd(_Lcd_CLEAR);                  // Clear display
  Lcd_Cmd(_Lcd_CURSOR_OFF);             // Turn cursor off

  PORTD = 0;                            // Initialize PORTC
  TRISD = 0b01000000;                   // Configure D6 en entrée et les autres en sorties

    while(1) {

        // --- Affichage sur l'écran LCD ---
        // Affiche le texte contenu dans la variable 'text=OUSSAMA' sur la première ligne du LCD
        Lcd_Out(1, 1, text);          // Ligne 1, Colonne 1

        // Affiche le texte contenu dans la variable 'text2=MATTHIS' sur la deuxième ligne du LCD
        Lcd_Out(2, 1, text2);         // Ligne 2, Colonne 1

        // --- Lecture et traitement de l'entrée D6 ---
        // Si le bit F6 du PORTD est à l’état haut (bouton)
        if (PORTD.F6 == 1) {
            // Inversion de l’état de la broche D7 (clignotement)
            // Si D7 = 1 → passe à 0 ; si D7 = 0 → passe à 1
            PORTD.F7 = ~PORTD.F7;

            // Délai d’attente de 1 seconde avant de répéter le test
            delay_ms(1000);

        } else {
            // Si D6 est à l’état bas, on force D7 à 0
            PORTD.F7 = 0;
        }
    }
}