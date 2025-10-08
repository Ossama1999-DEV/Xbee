#line 1 "C:/Users/hélène/Desktop/helene juil 2021/cesi/aspects technologiques/TP ZigBee/programmes ZIGBEE PRO helene/led1maquette/led1maquette.c"
#line 11 "C:/Users/hélène/Desktop/helene juil 2021/cesi/aspects technologiques/TP ZigBee/programmes ZIGBEE PRO helene/led1maquette/led1maquette.c"
void main() {


 PORTD = 0;
 TRISD = 0;

 while(1) {


 PORTD = ~PORTD;
 delay_ms(1000);
 }
 }
