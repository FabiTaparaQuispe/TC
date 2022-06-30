%{
int flag_operador1=0,flag_operador2=0, flag_operacion=0;
void evaluate();
float operador1=0, operador2=0, respuesta=0;
%}
DIGIT [0-9]
NUM {DIGIT}+(\.{DIGIT}+)?

%%
{NUM} {
  if (flag_operador1 == 0){
    operador1 = atof(yytext);
    flag_operador1 = 1;
    printf("operador 1: %0.2f\n", operador1);
  } else if (flag_operador2 == -1){
    operador2 = atof(yytext);
    flag_operador2 = 1;
    printf("operador 2: %0.2f\n", operador2);
  }
  if((flag_operador1 == 1) && (flag_operador2 == 1)) {
    flag_operador1 = 0;
    flag_operador2 = 0;
  }
}

[+] {
  printf("es suma\n");
  flag_operador2 = -1;
  flag_operacion = 1;
}

[-] {
  printf("es resta\n");
  flag_operador2 = -1;
  flag_operacion = 2;
}

[*] {
  printf("es multiplicacion\n");
  flag_operador2 = -1;
  flag_operacion = 3;
}

[/] {
  printf("es division\n");
  flag_operador2 = -1;
  flag_operacion = 4;
}

[%] {
  printf("es modulo, los operadores se convertiran forzosamente a enteros.\n");
  flag_operador2 = -1;
  flag_operacion = 5;
}

[\^] {
  printf("es potencia\n");
  flag_operador2 = -1;
  flag_operacion = 6;
}

[\n] {
  evaluate();
  if((flag_operador1 == 1) && (flag_operador2 == 1) && (flag_operacion != 0)) {
    flag_operador1 = 0;
    flag_operador2 = 0;
    flag_operacion = 0;
  }
}
%%

int yywrap(){}
int main(){

  printf("Ingrese la operacion en una linea, sin espacios y en forma real (entero).(parte decimal)\n");
  yylex();
  return 0;
}
void evaluate(){
  if(flag_operacion == 1){ //suma
    respuesta = operador1 + operador2;
  } else if (flag_operacion == 2) { //resta
    respuesta = operador1 - operador2;
  } else if (flag_operacion == 3) { //multiplicacion
    respuesta = operador1 * operador2;
  } else if (flag_operacion == 4) { //division
    respuesta = operador1 / operador2;
  } else if (flag_operacion == 5) { //modulo
    respuesta = (int)operador1 % (int)operador2;
  } else if (flag_operacion == 6) { //potencia
    if(operador2 == 0){
      respuesta = 1;
    } else {
      respuesta = operador1;
      int i;
      for(i = 1 ; i < operador2 ; i++)
        respuesta = respuesta * operador1;
    }
  } else {
    printf("Operacion incorrecta.");
  }

  printf("respuesta es: %0.2f\n", respuesta);
}
