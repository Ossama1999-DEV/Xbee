#line 1 "C:/Users/hélène/Desktop/helene NOV 2020/cesi/Electronique de base/capteurs/TP/Simulation des TP à distance/TP à distance juin 2020/TP3_Capteurs_DS1631 protheus pic/tp helene1 pic pro et protheus ds1631/led.c"
#line 6 "C:/Users/hélène/Desktop/helene NOV 2020/cesi/Electronique de base/capteurs/TP/Simulation des TP à distance/TP à distance juin 2020/TP3_Capteurs_DS1631 protheus pic/tp helene1 pic pro et protheus ds1631/led.c"
 void main() {
 PORTD = 0;
 TRISD = 0;
 while(1){
 PORTD.F7=~PORTD.F7;
 delay_ms( 1000);
 }
 }
