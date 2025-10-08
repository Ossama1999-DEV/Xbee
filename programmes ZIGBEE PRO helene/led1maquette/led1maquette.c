/*  Nom du projet : LED_BP_LCD
    Date de test : nov 2021
    mikroC PRO for PIC v 7.6.0
    Q 20Mhz
    Pour  utiliser  l'afficheur, on souhaite utiliser le port B avec les  affectations suivantes : 0,1,5,4,3,2 pour : RS, EN, D7, D6, D5, D4.
    PIC / 16F877A
*/



void main() {


  PORTD = 0;                        // Initialize PORTC
  TRISD = 0;               // Configure D  en sorties

  while(1) {


    PORTD =  ~PORTD;          // toggle PORTD
    delay_ms(1000);             // one second delay
    }
    }
