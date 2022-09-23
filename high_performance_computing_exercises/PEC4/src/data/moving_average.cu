#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <iostream>
#include <fstream>

using namespace std;

//CUDA kernels
__global__ void smooth(float *in, float *out, int n) {
	//Get our global and block thread ID
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	if (col < n) {
		float tmpAvg = 0.0;
		for (int i = 0; i < 9; i++) {
			if (col - i >= 0) {
				tmpAvg += *(in + col-i) ;
			} else {
				tmpAvg += 0;
			}
		}
		
		//out[col][row] = tmpAvg;
		*(out + col) = tmpAvg / (float)9.0;
	}
}
	
//Main function	
int main(int argc, char *argv[]) {
	//Length of array
	//Matriz 1000*50
	int n = 50000;
	
	//Device input array
	float *d_A;
	
	//Device output array
	float *d_B;
	
	//Host input array
	float *h_A;
	
	//Host output arra
	float *h_B;
	
	//Size, in bytes, of each array
	size_t bytes = n*sizeof(float);
	
	//Allocate host arrays
	h_A = (float*)malloc(bytes);
	h_B = (float*)malloc(bytes);
	
	//Allocate device arrays
	cudaMalloc(&d_A, bytes);
	cudaMalloc(&d_B, bytes);
	
	//Initialize content of input array
	int i;
	for(i=0; i<n; i++) {
		*(h_A + i) = rand() % 10 + 1;
	}

	//Copy host vector to device
	cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
	
	//Number of threads in each thread block
	dim3 blockSize(32,1,1);
	
	//Number of thread blocks in grid
	int grid = (int)ceil((float)n / blockSize.x);
	dim3 gridSize(grid,1,1);
	
	//Execute the kernel
	smooth<<<gridSize,blockSize>>>(d_A, d_B, n);
	
	//Copy device vector to host
	cudaMemcpy(h_B, d_B, bytes, cudaMemcpyDeviceToHost);
	
	//Write array to txt file
	ofstream myfile ("moving_average.txt");
	if (myfile.is_open())
	{
		for(int i = 0; i < n; i ++){
			myfile << *(h_B + i) << " " ;
		}
		myfile.close();
	} else cout << "Unable to open file";
	
	//Release device memory
	cudaFree(d_A);
	cudaFree(d_B);

	//Release host memory
	free(h_A);
	free(h_B);
	
	return 0;
	}