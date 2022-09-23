#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <iostream>
#include <fstream>

using namespace std;

//CUDA kernels
/* __global__ void avg(float *in, float *out, int n, int m) {
	//Identify the thread ID as the column number
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	//Calculate the loop iterations for the corresponding vector elements
	if (col < n) {
		float tmpAvg = 0.0;
		for (int i = 0; i < m; i++) {
			int k = n * i;
			tmpAvg += *(in + k) ;
		}
		
		*(out + col) = tmpAvg;
	}
} */
	
__global__ void smooth(float *in, float *out, int n, int l) {
	//Get our global and block thread ID
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	if (col < n) {
		float tmpAvg = 0.0;
		for (int i = 0; i < l; i++) {
			if (col - i >= 0) {
				tmpAvg += *(in + col-i) ;
			} else {
				tmpAvg += 0;
			}
		}
		
		//out[col][row] = tmpAvg;
		*(out + col) = tmpAvg / (float)l;
	}
}	
	
//Main function	
int main(int argc, char *argv[]) {
	//Length of array
	//Matriz 1000*50
	int n = 1000;
	int m = 50;
	int l = 1
	//Device input array
	float *d_A;
	
	//Device output array
	float *d_B;
	
	//Host input array
	float *h_A;
	
	//Host output arra
	float *h_B;
	
	//Size, in bytes, of each array
	size_t bytes = n*m*sizeof(float);
	//size_t bytes_vec = n*sizeof(float);
	size_t bytes_vec = n*m*sizeof(float);
	//Allocate host arrays
	h_A = (float*)malloc(bytes);
	//h_B = (float*)malloc(bytes_vec);
	h_B = (float*)malloc(bytes);
	//Allocate device arrays
	cudaMalloc(&d_A, bytes);
	//cudaMalloc(&d_B, bytes_vec);
	cudaMalloc(&d_B, bytes);
	
	//Initialize content of input array
	int i;
	for(i=0; i<(n*m); i++) {
		*(h_A + i) = i;
	}

	//Copy host vector to device
	cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
	
	//Number of threads in each thread block
	dim3 blockSize(1000,1,1);
	
	//Number of thread blocks in grid
	int grid = (int)ceil((float)(n*m) / blockSize.x);
	dim3 gridSize(grid,1,1);
	
	//Execute the kernel
	float<<<gridSize,blockSize>>>(d_A, d_B, n, m, l);
	
	//Copy device vector to host
	cudaMemcpy(h_B, d_B, bytes_vec, cudaMemcpyDeviceToHost);
	
	//Write array to txt file
	ofstream myfile ("avg_vector.txt");
	if (myfile.is_open())
	{
		for(int i = 0; i < n*m; i ++){
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