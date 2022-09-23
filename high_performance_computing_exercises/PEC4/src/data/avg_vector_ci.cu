#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <iostream>
#include <fstream>

using namespace std;

//CUDA kernels
__global__ void avg(float *in, float *out, int n, int m) {
	//Identify the thread ID as the column number
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	//Calculate the loop iterations for the corresponding vector elements
	if (col < n) {
		float tmpAvg = 0.0;
		//Calculate the sum of all the elements in the column
		for (int i = 0; i < m; i++) {
			int k = n * i;
			tmpAvg += *(in + col + k) ;
		}
		*(out + col) = tmpAvg;
	}
}
	
//Main function	
int main(int argc, char *argv[]) {
	
	//Define matrix dimensions and pointers
	int n = 1000; //columns
	int m = 50; //rows 
	float *d_A;
	float *d_B;
	float *h_A;
	float *h_B;
	
	size_t bytes = n*m*sizeof(float);
	size_t bytes_vec = n*sizeof(float);
	
	//Allocate host arrays
	h_A = (float*)malloc(bytes);
	h_B = (float*)malloc(bytes_vec);
	
	//Allocate device arrays
	cudaMalloc(&d_A, bytes);
	cudaMalloc(&d_B, bytes_vec);
	
	//Initialize content of input array
	int i;
	ifstream file("file.txt");
    if(file.is_open())
    {
        for(i=0; i<n; i++) {
            file >> *(h_A + i);
        }
    }

	//Copy host vector to device
	cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
	
	//Define grid dimensions
	dim3 blockSize(500,1,1);
	int grid = (int)ceil((float)(n*m) / blockSize.x);
	dim3 gridSize(grid,1,1);
	
	//Execute the kernel
	avg<<<gridSize,blockSize>>>(d_A, d_B, n, m);
	
	//Copy device vector to host
	cudaMemcpy(h_B, d_B, bytes_vec, cudaMemcpyDeviceToHost);
	
	//Write array to txt file
	ofstream myfile ("avg_vector.txt");
	if (myfile.is_open())
	{
		for(int i = 0; i < n; i ++){
			myfile << *(h_B + i) << " " ;
		}
		myfile.close();
	} else cout << "Unable to open file";
	
	//Release device and host memory
	cudaFree(d_A);
	cudaFree(d_B);
	free(h_A);
	free(h_B);
	
	return 0;
	}