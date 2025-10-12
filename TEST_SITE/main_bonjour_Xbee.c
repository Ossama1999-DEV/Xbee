/**!
 * @author DBIBIH Oussama
 * @file main_bonjour_Xbee.c
 * @brief Programme de test pour envoyer "Bonjour" via XBee à chaque réception de donnée.
 *      Le PORTD clignote toutes les secondes pour indiquer que le programme tourne.
 */

// --- Déclarations globales ---
char i;                   // Variable temporaire pour stocker un caractère
int cpt = 0;              // Compteur de boucle
char tableau[] = "Bonjour";  // Message à envoyer via UART

// -----------------------------------------------------------------------------
//  Fonction : saut_ligne()
//  --------------------------------
//  Envoie un retour à la ligne complet sur le port série (CR + LF)
//  -> '\n' : saut de ligne (line feed)
//  -> '\r' : retour chariot (carriage return)
// -----------------------------------------------------------------------------
void saut_ligne() {
    i = '\n';
    Uart1_Write(i);       // Envoie saut de ligne
    i = '\r';
    Uart1_Write(i);       // Envoie retour chariot
}

// -----------------------------------------------------------------------------
//  Fonction principale : main()
// -----------------------------------------------------------------------------
void main() {
    // -------------------------------------------------------------------------
    // 1️⃣  Initialisation des ports
    // -------------------------------------------------------------------------
    PORTD = 0;            // Valeur initiale du PORTD : tout à 0
    TRISD = 0;            // Configure le PORTD comme sorties (pour LED de test)

    // -------------------------------------------------------------------------
    // 2️⃣  Initialisation de la communication UART
    // -------------------------------------------------------------------------
    // Configure le module UART1 à 9600 bauds, 8 bits, pas de parité, 1 stop bit
    Uart1_Init(9600);
    Delay_ms(100);        // Court délai pour stabiliser la liaison UART

    do {

        // ---------------------------------------------------------
        // 🔹 Vérifie si une donnée a été reçue sur la liaison série
        // ---------------------------------------------------------
        if (Uart1_Data_Ready()) {       // Si un octet est disponible sur RX
            
            // --- Envoi du message "Bonjour" caractère par caractère ---
            for (cpt = 0; cpt < 7; cpt++) {
                i = tableau[cpt];        // Prend chaque lettre du tableau
                Uart1_Write(i);          // L’envoie sur la ligne série
            }

            // --- Envoie un retour à la ligne pour aérer l’affichage ---
            saut_ligne();
        }

        // ---------------------------------------------------------
        // 🔹 Attente et clignotement du PORTD
        // ---------------------------------------------------------
        Delay_ms(1000);     // Attente d’1 seconde
        PORTD = ~PORTD;     // Inverse tous les bits du PORTD → LED clignote

    } while (1);            // Boucle infinie
}
