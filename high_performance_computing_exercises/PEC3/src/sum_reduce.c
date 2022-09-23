#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

int main(int argc, char *argv[]) {
  double r, sum=0.0;
  double sum_total;
  int id, ntasks, i, n;
  char hostname[256];
  
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &ntasks);
  MPI_Comm_rank(MPI_COMM_WORLD, &id);
  gethostname(hostname,255);
  
  n = 1000;
  srand(id);

  

  for (i=0; i<n; i++) {
    r = (double)rand()/RAND_MAX;   /* Random number between 0 and 1 */
    sum += r;
  }

  printf("I am process %d of %d and my sum is %lf\n", id, ntasks, sum);

  /* Sum the values in all processes with a reduction operation */
  MPI_Reduce(&sum, &sum_total, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

  if (id == 0) {
    printf("The total sum is %f", sum_total);
  }

  MPI_Finalize();
  exit(0);
}