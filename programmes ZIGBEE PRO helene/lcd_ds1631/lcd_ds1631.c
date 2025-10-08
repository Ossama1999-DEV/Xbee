  /*  Nom du projet : LED_BP_LCD_DS1631
    Date de test : Juin 2020
    mikroC PRO for PIC v 7.5.0
    Q 8Mhz
    Pour  utiliser  l'afficheur, on souhaite utiliser le port B avec les  affectations suivantes : 0,1,5,4,3,2 pour : RS, EN, D7, D6, D5, D4.
    PIC / 16F877
*/
//Broches du LCD.
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
  // Broches du DS1631
sbit I2C1_Scl at RC3_bit;
sbit I2C1_Sda at RC4_bit;
sbit I2C1_Scl_Direction at TRISC3_bit;
sbit I2C1_Sda_Direction at TRISC4_bit;

char LSB;               //temp[7], temptxt[]="Temperature",
signed char MSB;
char msg[7];                      // Message contenant la valeur contenue pour String.
/******Déclaration des fonctions*************************/
void lcd(int li, int co, int nb, char receive[15]);
    // define callback function
 I2C1_TimeoutCallback(char errorCode);


void main() {
  /******Configuration et initialisation de l'écran LCD******/
     Lcd_Init();
     Lcd_Cmd(_Lcd_CLEAR);                // Clear display
     Lcd_Cmd(_Lcd_CURSOR_OFF);           // Turn cursor off
     //Lcd_Out(1,6,txt3);

/*****Initialisation du module I2C*******************/
     I2C1_Init(100000);       //initialisation de la communication I2C
     // set timeout period and callback function
     //I2C1_SetTimeoutCallback(1000, I2C1_TimeoutCallback);
     I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0xAC);           //Accès au registre de configuration
     I2C1_Wr(0x0E);           //Registre de configuration mesure en continu
     I2C1_Stop();             //Arrêt du signal
     Delay_ms(10);

     I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0x51);           //Début de la conversion
     I2C1_Stop();             //Arrêt du signal
     Delay_ms(10);
   /*****configuration seuil température haut TH*******************/
/*I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0xA1);           //Configuration en mode écriture du TH
     //I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0x1E);           //envoie du MSB  (30)
     I2C1_Wr(0x00);           //envoie du LSB (0.5)
     I2C1_Stop();             //Arrêt du signal
     Delay_ms(10);*/
     /*****configuration seuil température haut TL*******************/
/*I2C1_Start();            //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0xA2);           //Configuration en mode écriture du TL
     //I2C1_Wr(0x90);           //Mode de contrôle en mode écriture
     I2C1_Wr(0x14);           //envoie du MSB  (20)
     I2C1_Wr(0x00);           //envoie du LSB (0.5)
     I2C1_Stop();             //Arrêt du signal
     Delay_ms(10);*/

     PORTD = 0;                        // Initialize PORTC
     TRISD = 0x01000000;               // Configure D6 en entrée et les autres en sorties*/

while(1) {
     I2C1_Start();        //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x90);       //Mode de contrôle en mode écriture
     I2C1_Wr(0xAA);       //Lecture de la température
     I2C1_Stop();         //Arrêt du sigal
     Delay_ms(10);
     I2C1_Start();        //Détermine si l'I2C est libre et lance le signal
     I2C1_Wr(0x91);       //Mode de contrôle en mode lecture
     MSB = I2C1_Rd(1);    //Nombre signé [température entre +125° et -55°C]
     LSB = I2C1_Rd(0);    //Si bit 7 = 1 température MSB +0,5°C
     //MSB = 0x25;
     //LSB = 0x80;
     I2C1_Stop();         //Arrêt du sigal
     Delay_ms(10);
     // Écrire sur l'écran LCD.
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1, 5, "DS1631");
     Lcd_Out(2, 1, "Temp: ");

     IntToStr(MSB, msg);               // Convertir la partie entière de la température en chaîne.
     Lcd_Out_CP(msg + 3);              // ignorer les 3 blancs au début de la chaîne
     Lcd_Chr_CP('.');                  // Point décimal.
     IntToStrWithZeros(LSB * 625, msg); // Convertit la partie décimale de la température en chaîne (String).
     Lcd_Out_CP(msg + 2);             //ignorer les 2 espaces vides au début de la chaîne.
     Lcd_Chr_CP(223);                 // Symbole du point °."
     Lcd_Chr_CP('C');

     if (PORTD.F6 = 1){
        PORTD.F7 =  ~PORTD.F7;   // toggle D7
        delay_ms(1000);          // one second delay
        }
        else
        PORTD.F7 = 0;
        }
}
/******Fonction affichage***********************************/
 void lcd(int li, int co, int nb, char receive[15])    {
    int i;
    for(i=0; i<nb ; i++) {                  //Boucle for
        Lcd_chr(li, (co+i), receive[i]);}}  //Affiche les caractères jusqu'à i
// define callback function
void I2C1_TimeoutCallback(char errorCode) {
   if (errorCode == _I2C_TIMEOUT_RD) {
     // do something if timeout is caused during read
   }
   if (errorCode == _I2C_TIMEOUT_WR) {
     // do something if timeout is caused during write
   }
   if (errorCode == _I2C_TIMEOUT_START) {
     // do something if timeout is caused during start
   }
   if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
     // do something if timeout is caused during repeated start
   }
}