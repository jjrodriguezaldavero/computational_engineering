#include <stdio.h>


int main(int argc, char **argv) {

  double input=100000;
  double output;
  int i;
  double m;
  double sum;
  double x;

  m = 1.0 / ( double ) ( 2 * input );

  sum = 0.0;

  for ( i = 1; i <= input; i++ )
  {
    x = m * ( double ) ( 2 * i - 1 );
    sum = sum + 1.5 / ( 1.0 + x * x );
  }

  output = 4.0 * sum / ( double ) ( input );

  return(0);
}
