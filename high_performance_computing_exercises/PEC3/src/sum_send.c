#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mpi.h"

int main( argc, argv )
int argc;
char **argv;
{
  int id, ntasks, i, N=100;
  double r, sum, sum_total;
  double array[N];
  char hostname[256];
  
  MPI_Status status;
  MPI_Init (&argc, &argv);
  MPI_Comm_size ( MPI_COMM_WORLD, &ntasks );
  MPI_Comm_rank ( MPI_COMM_WORLD, &id );
  
 /*Create an array with random numbers*/
  if ( id == 0 ) 
  {
    for (i=0; i<N; i++) {
		array[i] = (double)rand()/RAND_MAX;
	  }
  }
  /*Broadcast the array to each process*/
  MPI_Bcast (array, N, MPI_DOUBLE, 0, MPI_COMM_WORLD );

  sum = 0.0;
  for ( i = 0; i < N; i++ )
  {
    sum += array[i];
  }
  
  printf("I am process %d of %d and my sum is %lf\n", id, ntasks, sum);
/* 
  Send the sum back to the master process.
*/
  if ( id != 0 ) 
  {
    MPI_Send ( &sum, 1, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD );
  }
  else 
  {
    sum_total = sum;
    for ( i = 1; i < ntasks; i++ ) 
    {
      MPI_Recv ( &sum, 1, MPI_DOUBLE, MPI_ANY_SOURCE, 1, MPI_COMM_WORLD, &status );
      sum_total += sum;
    }
  }

  if ( id == 0 )
  {     
    printf("The total sum is %f", sum_total);
  }

  MPI_Finalize();
  exit(0);
}