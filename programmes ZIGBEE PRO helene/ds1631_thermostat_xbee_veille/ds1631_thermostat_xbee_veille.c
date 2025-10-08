/*  Nom du projet : LED_BP_LCD_DS1631_Thermostat
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

// Broches du DS1631.
sbit Soft_I2C_Scl at RC3_bit;
sbit Soft_I2C_Sda at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;

// Commandes.
#define DS1631_CMD_START_CONVERT 0x51
#define DS1631_CMD_STOP_CONVERT 0x22
#define DS1631_CMD_READ 0xAA
#define DS1631_CMD_ACCESS_TH 0xA1
#define DS1631_CMD_ACCESS_TL 0xA2
#define DS1631_CMD_ACCESS_CFG 0xAC
#define DS1631_CMD_SOFT_POR 0x54

typedef union {
char ONE_SHOT : 1;          // 1 - One-Shot Mode, 0 - Mode conversion continue
char POL : 1;               // 1 - TOUT actif au niveau haut, 0 - TOUT actif au niveau bas
char R : 2 ;                // 00 -> 9 bits, 01 -> 10 bits, 10 -> 11 bits, 11 -> 12 bits
char NVB : 1;               // A write to EEPROM memory is in progress
char TLF : 1;
char THF : 1;
char DONE : 1;              // 1 = La conversion de temp�rature est termin�e.
} DS1631_Config;

typedef union {
char : 4;
char decimal : 4;
signed char entiere : 8;
} DS1631_Temperature;

#define DS1631_ADDRESS(addr) (0x90 | (addr << 1))

// Lire deux octets dans un registre.
unsigned DS1631_Read(char address, char reg) {
unsigned value;
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'�criture.
Soft_I2C_Write(reg);                         // Envoyer la commande pour acc�der � l'enregistrement.
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address) | 1); // Envoyer l'adresse du DS1631 + le mode de lecture.
((char*)&value)[1] = Soft_I2C_Read(1);       // Lire l'octet le plus significatif.
((char*)&value)[0] = Soft_I2C_Read(0);       // Lire l'octet le moins significatif.
Soft_I2C_Stop();                             // Signal de stop.
return value;
}

//�crire deux octets dans un registre.
void DS1631_Write(char address, char reg, unsigned value) {
Soft_I2C_Start();
Soft_I2C_Write(DS1631_ADDRESS(address));
Soft_I2C_Write(reg);
Soft_I2C_Write(((char*)&value)[1]); // MSB.
Soft_I2C_Write(((char*)&value)[0]); // LSB.
Soft_I2C_Stop();
}

// Initialise le DS1631 avec certaines configurations.
void DS1631_Init(char address, DS1631_Config * config) {
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'�criture.
Soft_I2C_Write(DS1631_CMD_ACCESS_CFG);       // Envoyer la commande pour acc�der � l'enregistrement de configuration.
Soft_I2C_Write(*(char*)config);              // Envoyer la valeur de configuration.
Soft_I2C_Stop();                             // Signal de stop.
Delay_ms(10);                                // EEPROM Write Cycle Time.
}

//D�marrer la conversion.
void DS1631_Start(char address) {
Soft_I2C_Start();                            // Signal de start
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'�criture.
Soft_I2C_Write(DS1631_CMD_START_CONVERT);    // Envoyer la commande pour d�marrer la conversion.
Soft_I2C_Stop();                             // Signal de stop.
}

// Mettre fin � la conversion.
void DS1631_Stop(char address) {
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'�criture.
Soft_I2C_Write(DS1631_CMD_STOP_CONVERT);     // Envoyer la commande pour arr�ter la conversion.
Soft_I2C_Stop();                            // Signal de stop.
}

void DS1631_Reset(char address) {
Soft_I2C_Start();                           // Signal de start
Soft_I2C_Write(DS1631_ADDRESS(address));    // Envoyer l'adresse du DS1631 + le mode d'�criture.
Soft_I2C_Write(DS1631_CMD_SOFT_POR);        // Envoyer la commande de r�initialisation.
Soft_I2C_Stop();                            // Signal de stop.
}

// Lire la temp�rature.
DS1631_Temperature DS1631_Read_Temperature(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_READ);
return temp;
}

// Lire la limite inf�rieure du thermostat TL
DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TL);
return temp;
}

// Lire la limite sup�rieure du thermostat TH
DS1631_Temperature DS1631_Read_Temperature_High(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TH);
return temp;
}

// Ecrire les limites inf�rieure et sup�rieure du thermostat TL et TH
void DS1631_Write_Temperature(char address, int low, int high) {
DS1631_Write(address, DS1631_CMD_ACCESS_TH, high << 8);
//EEPROM Write Cycle Time.
Delay_ms(10);
DS1631_Write(address, DS1631_CMD_ACCESS_TL, low << 8);
//EEPROM Write Cycle Time.
Delay_ms(10);
}

   // envoi des  donnees sur l emetteur xbee
   void xbee(int nb, char receive [15]){
   int i;
  Uart1_Init(9600);
        for (i=0; i<nb; i++){
            Uart1_Write(receive[i]);

            }

      }







void main() {
DS1631_Config config;
DS1631_Temperature temp;
char msg[15];                      // Message contenant la valeur contenue pour String.
 char tableau[] = "Temperature ";
 char saut[] = "\r" ;
 char point[] = "." ;
// char degres[] = "�C";

PORTD = 0;                        // Initialize PORTC
TRISD = 0x01000000;               // Configure D6 en entr�e et les autres en sorties*/
// Initialisation du LCD.
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
config.ONE_SHOT = 1;              // Mode one-shot.
config.POL = 1;                   // TOUT actif avec un niveau logique haut.
config.R = 3;                     // Resolution de 12 bits. //config.R = 0; // Resolution de 9 bits.
// Initialisation du DS1631.
DS1631_Init(0, &config);
// D�finir les limites sup�rieure TH et TL inf�rieure du thermostat.
DS1631_Write_Temperature(0, 20, 25);

while(1) {
// D�marre la conversion One-Shot.
DS1631_Start(0);
//Attendre 750 ms, car la r�solution est de 12 bits.
Delay_ms(750);
// �crire sur l'�cran LCD.
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1, 5, "DS1631");

Lcd_Out(2, 1, "Temp: ");
/**
partie veille du xbee
 */
PORTD.F1 = 0;  //reveille le XBEE
delay_ms(100);
//Effectuer la lecture de la temp�rature et convertir en cha�ne
temp = DS1631_Read_Temperature(0);

IntToStr(temp.entiere, msg);      // Convertir la partie enti�re de la temp�rature en cha�ne.
xbee(11,tableau) ;
xbee(1,saut);
delay_ms(100);
Lcd_Out_CP(msg + 3);    // ignorer les 3 blancs au d�but de la cha�ne
xbee(7,msg   );
delay_ms(100);
Lcd_Chr_CP('.');      // Point d�cimal.
xbee (1, point) ;
delay_ms(100);
LongIntToStrWithZeros(temp.decimal * 625, msg); // Convertit la partie d�cimale de la temp�rature en cha�ne (String).
Lcd_Out_CP(msg + 7);             //ignorer les 2 espaces vides au d�but de la cha�ne.
 xbee(7,msg +7  );
 xbee(1,saut);
Lcd_Chr_CP(223);                 // Symbole du point �."
Lcd_Chr_CP('C');
//xbee(2,degres);
PORTD.F1 = 1; // endort le xbee
  delay_ms(100);
  
if (PORTD.F6 = 1){
    PORTD.F7 =  ~PORTD.F7;      // toggle D7
    //PORTD =  ~PORTD;          // toggle PORTD
    delay_ms(1000);             // one second delay
    }
    else
    PORTD.F7 = 0;
}
}