#include "mpi.h"
#include <stdio.h>

int main(argc,argv)
int argc;
char **argv;
{

  int MyProc, tag=1;
  char msg='A', msg_recpt;
  MPI_Status status;
  
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &MyProc);

  printf("Process # %d started \n", MyProc);
  MPI_Barrier(MPI_COMM_WORLD);
  
  if (MyProc == 0)
  {
    printf("Proc #0 sending message to Proc #1 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD);
	printf("Proc #0 sending message to Proc #2 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 2, tag, MPI_COMM_WORLD);
    
    MPI_Recv(&msg_recpt, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD, &status);
    printf("Proc #0 received message from Proc #1 \n") ;
	MPI_Recv(&msg_recpt, 1, MPI_CHAR, 2, tag, MPI_COMM_WORLD, &status);
    printf("Proc #0 received message from Proc #2 \n") ;
  }
  else if (MyProc == 1)
  {
	printf("Proc #1 sending message to Proc #0 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD);
	printf("Proc #1 sending message to Proc #2 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 2, tag, MPI_COMM_WORLD);
    
    MPI_Recv(&msg_recpt, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD, &status);
    printf("Proc #1 received message from Proc #0 \n") ;
	MPI_Recv(&msg_recpt, 1, MPI_CHAR, 2, tag, MPI_COMM_WORLD, &status);
    printf("Proc #1 received message from Proc #2 \n") ;
  }
  else
  {
	printf("Proc #2 sending message to Proc #1 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD);
	printf("Proc #2 sending message to Proc #2 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD);
    
    MPI_Recv(&msg_recpt, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD, &status);
    printf("Proc #2 received message from Proc #1 \n") ;
	MPI_Recv(&msg_recpt, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD, &status);
    printf("Proc #2 received message from Proc #2 \n") ;
  }
  
  printf("Finishing proc %d\n", MyProc); 

  MPI_Barrier(MPI_COMM_WORLD); 
  MPI_Finalize();
}

