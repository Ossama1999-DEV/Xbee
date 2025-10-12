# 🔥 Projet : LED_BP_LCD_DS1631  
**Microcontrôleur :** PIC16F877A  
**Logiciel :** MikroC PRO for PIC v7.5.0  
**Fréquence quartz :** 8 MHz  
**Date de test :** Juin 2020  

---

## 🧩 Description générale
Ce projet a pour objectif de **mesurer la température à l’aide du capteur DS1631**, d’afficher la valeur sur un **écran LCD 16x2**, et de **contrôler une LED via un bouton poussoir**.  
Le tout est géré par le microcontrôleur **PIC16F877A**, programmé en C avec MikroC PRO.

Le système combine :
- **Communication I²C** (entre le PIC et le capteur DS1631),
- **Affichage LCD** pour visualiser la température en temps réel,
- **Gestion d’entrée/sortie** pour le contrôle d’une LED par bouton.

---

## ⚙️ Schéma fonctionnel
```
+--------------------------+
|        PIC16F877A        |
|                          |
|  [PORTC] I²C             |
|   ├── RC3 → SCL → DS1631 |
|   └── RC4 → SDA → DS1631 |
|                          |
|  [PORTB] LCD (4 bits)    |
|   ├── RB0 → RS           |
|   ├── RB1 → EN           |
|   └── RB2..RB5 → D4..D7  |
|                          |
|  [PORTD] LED & BP        |
|   ├── RD6 → Bouton       |
|   └── RD7 → LED          |
+--------------------------+
```

---

## 🧠 Fonctionnement du programme

### 1️⃣ Initialisation
- Configuration des ports (LCD, I²C, LED, bouton).  
- Initialisation du bus I²C à 100 kHz.  
- Configuration du capteur DS1631 en mode **One-Shot** (mesure ponctuelle, résolution 12 bits).  
- Initialisation du LCD et affichage du titre.

### 2️⃣ Lecture de la température
- Le PIC envoie la commande **0xAA** au DS1631 pour lire la température.  
- Le capteur renvoie 2 octets :  
  - **MSB** → partie entière  
  - **LSB (bit7)** → bit de fraction (0.5 °C)  
- Le PIC calcule la température finale et l’affiche sous la forme :
  ```
  Temp: 23.5°C
  ```

### 3️⃣ Gestion du bouton et de la LED
- Le bouton connecté à **RD6** permet d’activer la LED (RD7).  
- Si le bouton est pressé → la LED **clignote** toutes les secondes.  
- Si le bouton est relâché → la LED reste **éteinte**.

---

## 📟 Affichage LCD
| Ligne | Contenu |
|:--|:--|
| 1 | `DS1631` |
| 2 | `Temp: XX.X°C` |

Exemple :
```
DS1631
Temp: 24.5°C
```

---

## 🧰 Matériel nécessaire
- Microcontrôleur **PIC16F877A**  
- Capteur de température **DS1631 (I²C)**  
- Écran **LCD 16x2 (mode 4 bits)**  
- Bouton poussoir  
- LED + résistance (220 Ω)  
- Quartz 8 MHz  
- Breadboard + câblage

---

## 🔬 Résultats expérimentaux
- La trame I²C mesurée à l’oscilloscope montre bien :
  - L’adresse `0x48` (DS1631)
  - Les données de température (`MSB`, `LSB`)
- Exemple : `MSB = 0x17`, `LSB = 0x00` → **23.0°C**
- L’affichage sur LCD est stable et précis.
- Le bouton déclenche correctement le clignotement de la LED.

---

## 🧾 Conclusion
Ce TP permet de maîtriser :
- La **communication I²C** entre un microcontrôleur et un capteur numérique,
- La **lecture et le traitement** de données binaires (température codée),
- L’**affichage LCD** et la **gestion d’entrées/sorties** simultanément.

> ✅ Résultat final : système embarqué complet et fonctionnel capable de mesurer, afficher et interagir avec l’utilisateur.

---

## 👨‍💻 Auteur
**DBIBIH Oussama**  
École d’ingénieur CESI – Filière Systèmes Électroniques Embarqués  
