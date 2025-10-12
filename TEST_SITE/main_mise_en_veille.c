/**!
 * @author DBIBIH Oussama
 * @file main_mise_en_veille.c
 * @brief Lecture de la température via le capteur DS1631 et affichage sur LCD
 *      avec gestion d'un bouton et d'une LED, et communication via XBee.
 *     Le XBee est mis en veille (sleep) entre chaque envoi de température.
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
char DONE : 1;              // 1 = La conversion de temp?rature est termin?e.
} DS1631_Config;

typedef union {
char : 4;
char decimal : 4;
signed char entiere : 8;
unsigned char lsb;
signed char msb;
} DS1631_Temperature;

#define DS1631_ADDRESS(addr) (0x90 | (addr << 1))

// Lire deux octets dans un registre.
unsigned DS1631_Read(char address, char reg) {
unsigned value;
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
Soft_I2C_Write(reg);                         // Envoyer la commande pour acc?der ? l'enregistrement.
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address) | 1); // Envoyer l'adresse du DS1631 + le mode de lecture.
((char*)&value)[1] = Soft_I2C_Read(1);       // Lire l'octet le plus significatif.
((char*)&value)[0] = Soft_I2C_Read(0);       // Lire l'octet le moins significatif.
Soft_I2C_Stop();                             // Signal de stop.
return value;
}

//?crire deux octets dans un registre.
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
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
Soft_I2C_Write(DS1631_CMD_ACCESS_CFG);       // Envoyer la commande pour acc?der ? l'enregistrement de configuration.
Soft_I2C_Write(*(char*)config);              // Envoyer la valeur de configuration.
Soft_I2C_Stop();                             // Signal de stop.
Delay_ms(10);                                // EEPROM Write Cycle Time.
}

//D?marrer la conversion.
void DS1631_Start(char address) {
Soft_I2C_Start();                            // Signal de start
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
Soft_I2C_Write(DS1631_CMD_START_CONVERT);    // Envoyer la commande pour d?marrer la conversion.
Soft_I2C_Stop();                             // Signal de stop.
}

// Mettre fin ? la conversion.
void DS1631_Stop(char address) {
Soft_I2C_Start();                            // Signal de start.
Soft_I2C_Write(DS1631_ADDRESS(address));     // Envoyer l'adresse du DS1631 + le mode d'?criture.
Soft_I2C_Write(DS1631_CMD_STOP_CONVERT);     // Envoyer la commande pour arr?ter la conversion.
Soft_I2C_Stop();                            // Signal de stop.
}

void DS1631_Reset(char address) {
Soft_I2C_Start();                           // Signal de start
Soft_I2C_Write(DS1631_ADDRESS(address));    // Envoyer l'adresse du DS1631 + le mode d'?criture.
Soft_I2C_Write(DS1631_CMD_SOFT_POR);        // Envoyer la commande de r?initialisation.
Soft_I2C_Stop();                            // Signal de stop.
}

// Lire la temp?rature.
DS1631_Temperature DS1631_Read_Temperature(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_READ);
return temp;
}

// Lire la limite inf?rieure du thermostat TL
DS1631_Temperature DS1631_Read_Temperature_Low(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TL);
return temp;
}

// Lire la limite sup?rieure du thermostat TH
DS1631_Temperature DS1631_Read_Temperature_High(char address) {
DS1631_Temperature temp;
*((unsigned*)&temp) = DS1631_Read(address, DS1631_CMD_ACCESS_TH);
return temp;
}

// Ecrire les limites inf?rieure et sup?rieure du thermostat TL et TH
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

void xbee_hibernate() {
    PORTD.F1 = 1;     // SLEEP_RQ = 1 => hibernation
    delay_ms(100);
    PORTD.F3 = 1;     // LED allumée pendant le sommeil
    delay_ms(2000);   // Laisse la LED allumée 2 secondes pour bien voir
    PORTD.F3 = 0;     // Puis éteinte
}

void xbee_wake() {
    PORTD.F0 = 0;     // reset actif bas
    delay_ms(10);
    PORTD.F0 = 1;     // reset relâché
    delay_ms(500);    // attendre que le XBee démarre

    PORTD.F1 = 0;     // SLEEP_RQ = 0 => réveil
    delay_ms(100);

    PORTD.F2 = 1;     // Allume une LED pendant wake
    delay_ms(1000);   // Durée visible (1s)
    PORTD.F2 = 0;     // Éteint après
}

void main() {

    // =========================================================================
    // 1️⃣  Déclarations et variables
    // =========================================================================
    DS1631_Config config;           // Structure de configuration du DS1631
    DS1631_Temperature temp;        // Structure pour stocker température (entier + décimal)
    char msg[15];                   // Chaîne utilisée pour convertir les valeurs numériques
    char tableau[] = "Temperature "; // Message de base pour XBee
    char saut[] = "\r\n";           // Retour à la ligne pour XBee
    char point[] = ".";             // Séparateur décimal
    char degres[] = "C";            // Symbole d’unité °C

    // =========================================================================
    // 2️⃣  Configuration des ports
    // =========================================================================
    PORTD = 0;                        // Mise à zéro initiale du PORTD
    TRISD = 0b00100000;               // RD5 = entrée, les autres = sorties

    // --- Lignes dédiées au XBee et aux indicateurs LED ---
    TRISD.F0 = 0; // RD0 : RESET (sortie)
    TRISD.F1 = 0; // RD1 : SLEEP_RQ (sortie)
    TRISD.F2 = 0; // RD2 : LED témoin "wake"
    TRISD.F3 = 0; // RD3 : LED témoin "sleep"
    TRISD.F6 = 1; // RD6 : bouton poussoir (entrée)
    // RD7 : sortie LED de test (toggling manuel dans la boucle)

    // =========================================================================
    // 3️⃣  Initialisation des périphériques
    // =========================================================================
    // --- LCD ---
    Lcd_Init();                      // Initialisation de l’écran LCD
    Lcd_Cmd(_LCD_CLEAR);             // Effacer l’écran
    Lcd_Cmd(_LCD_CURSOR_OFF);        // Cacher le curseur

    // --- DS1631 (capteur de température I2C) ---
    config.ONE_SHOT = 1;             // Mode One-Shot (mesure ponctuelle)
    config.POL = 1;                  // Sortie TOUT active à l’état haut
    config.R = 3;                    // Résolution 12 bits
    DS1631_Init(0, &config);         // Initialisation du capteur
    DS1631_Write_Temperature(0, 20, 25); // Définition des seuils TH/TL (20°C et 25°C)

    // =========================================================================
    // 4️⃣  Boucle principale
    // =========================================================================
    while(1) {

        // ---------------------------------------------------------------------
        // 🔹 Étape 1 : Lecture de la température via I2C
        // ---------------------------------------------------------------------
        DS1631_Start(0);                 // Lancer une conversion One-Shot
        Delay_ms(750);                   // Attendre la fin de conversion (résolution 12 bits)
        temp = DS1631_Read_Temperature(0); // Lire la température (MSB + LSB)

        // ---------------------------------------------------------------------
        // 🔹 Étape 2 : Traitement de la valeur lue
        // ---------------------------------------------------------------------
        // Si le bit 7 du LSB = 1 → ajouter +0.5°C
        if (((unsigned*)&temp)[0] & 0x80) {
            temp.decimal = 5;            // partie décimale = .5
        } else {
            temp.decimal = 0;            // partie décimale = .0
        }

        // ---------------------------------------------------------------------
        // 🔹 Étape 3 : Affichage LCD
        // ---------------------------------------------------------------------
        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out(1, 5, "DS1631");
        Lcd_Out(2, 1, "Temp: ");

        IntToStr(temp.entiere, msg);     // Convertir la partie entière en texte
        Lcd_Out_CP(msg + 3);             // Afficher sans les espaces
        Lcd_Chr_CP('.');                 // Afficher le point décimal

        msg[0] = temp.decimal + '0';     // Convertir la partie décimale (.0 / .5)
        msg[1] = '\0';
        Lcd_Out_CP(msg);                 // Afficher .0 ou .5
        Lcd_Chr_CP(223);                 // Afficher le symbole ° 
        Lcd_Chr_CP('C');                 // puis "C"

        // ---------------------------------------------------------------------
        // 🔹 Étape 4 : Communication XBee (UART)
        // ---------------------------------------------------------------------
        xbee_wake();                     // Réveiller le module XBee
        xbee(11, tableau);               // Envoyer "Temperature "
        xbee(3, msg + 3);                // Envoyer la partie entière
        xbee(1, point);                  // Envoyer le point
        xbee(1, msg);                    // Envoyer la partie décimale
        xbee(1, degres);                 // Envoyer "C"
        xbee(2, saut);                   // Saut de ligne
        xbee_hibernate();                // Remettre le XBee en veille

        // ---------------------------------------------------------------------
        // 🔹 Étape 5 : Gestion du bouton sur RD6 et LED sur RD7
        // ---------------------------------------------------------------------
        if (PORTD.F6 == 1) {
            PORTD.F7 = ~PORTD.F7;        // Inversion de la LED sur RD7
            Delay_ms(1000);              // Attente 1 seconde
        } else {
            PORTD.F7 = 0;                // LED éteinte si le bouton n’est pas appuyé
        }
    }
}

