#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

int main(int argc, char *argv[]) {
  double r, sum, sum_total=0.0;
  int rank, ntasks, i, n;
  double *sums = NULL;
  
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &ntasks);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  n = 1000;
  srand(rank);

  for (i=0; i<n; i++) {
    r = (double)rand()/RAND_MAX;   /* Random number between 0 and 1 */
    sum += r;
  }

  printf("I am process %d of %d and my sum is %lf\n", rank, ntasks, sum);
  
  if (!rank) {
	sums = (double *)malloc(sizeof(double) * ntasks);
  }
  
  MPI_Gather(&sum, 1, MPI_DOUBLE, sums, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  
  if (rank == 0) {
	for (i = 0; i < ntasks; i++) {
		sum_total += sums[i];
	}
	printf("The total sum is %f", sum_total);
  }
  MPI_Finalize();
  exit(0);
}