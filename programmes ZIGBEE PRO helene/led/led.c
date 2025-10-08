/* nom du projet: LED
  Date de test juin 2020
  mikroC PRO for PIC v7.6.0
  Q 8Mhz
*/
void main() {
   // Initialisation : toutes les broches du PORTD en sortie
   TRISD = 0;
   // Éteindre toutes les LEDs au départ
   PORTD = 0;

   while(1) {
      // Inverse l'état de la LED sur RD7
      PORTD.F7 = ~PORTD.F7;
      // Attendre 1 seconde
      delay_ms(1000);
   }
}
