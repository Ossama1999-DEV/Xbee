#line 1 "C:/Users/EEA/Desktop/tp helene pic pro et protheus ds1631/bonjourxbee1.c"

char i;
int cpt=0;
char tableau[] = "Bonjour";

void saut_ligne() {
 i = '\n' ;
 Uart1_Write(i);
 i = '\r' ;
 Uart1_Write(i); }
void main() {
 PORTD = 0;
 TRISD = 0;

 Uart1_Init(9600);

 do {
 if (Uart1_Data_Ready()) {
 for (cpt=0; cpt<7; cpt++){
 i =tableau[cpt];
 Uart1_Write(i);
 }
 saut_ligne() ;
 }
 delay_ms(1000) ;
 PORTD = ~PORTD ;
}while(1); }
