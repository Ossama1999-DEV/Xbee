// testXbeebonjour ok le 09122012
char i;
int cpt=0;
char tableau[] = "Bonjour";

void saut_ligne()          {
        i = '\n'  ;
        Uart1_Write(i);
        i = '\r'  ;
        Uart1_Write(i);    }
void main()                {
  PORTD = 0;                 // Initialize PORTD
  TRISD = 0;                 // Configure PORTD as output
//----------Initialisation USART--------------
  Uart1_Init(9600);   //(8 bit, 2400 baud rate, no parity bit..)
//----------Programme principal-------------
  do {
      if (Uart1_Data_Ready()) {   // If data is received
        for (cpt=0; cpt<7; cpt++){
            i =tableau[cpt];
            Uart1_Write(i);
            }
        saut_ligne() ;
      }
      delay_ms(1000) ;
      PORTD =  ~PORTD ;
}while(1);                 }