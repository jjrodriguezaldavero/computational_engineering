#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <cuda.h>

//CUDA kernels
__global__ void vecAdd(float *a,float *b,float *c,int n)
	{
	//Get our global thread ID
	int id = blockIdx.x * blockDim.x + threadIdx.x;
	
	//Vector addition
	if (id < n) {
		c[id]=a[id]+b[id];
		}
	}
	
__global__ void smooth(float *in, float *out, int n)
	{
	//Get our global and block thread ID
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	
	float tmpAvg = 0.0f;
	for (int i = 0; i < 9; i++) {
		if (col - i >= 0) {
			tmpAvg += in[col-i][row] / 9.0;
		} else {
			tmpAvg += 0;
		}
	}
	
	out[col][row] = tmpAvg;
	
/* 	//Ignore the first and last threads
	if (id != 0 && id < (n-1))
		{
		//Compute one element of out array
		floatmovAvg = (in[id-1] + in[id] + in[id+1]) / 3.0;
		
		//Write to result back to global memory
		out[id-1]=movAvg;
		}
	}	 */

//Main function	
int main(int argc, char *argv[])
	{
	//Length of array
	int n = 1000;
	
	//Device input array
	float *d_A;
	
	//Device output array
	float *d_B;
	
	//Host input array
	float *h_A;
	
	//Host output arra
	float *h_B;
	
	//Size, in bytes, of each array
	size_t bytes = n*n*sizeof(float);
	
	//Allocate host arrays
	h_A = (float)*malloc(bytes);
	h_B = (float)*malloc(bytes);
	
	//Allocate device arrays
	cudaMalloc(&d_A, bytes);
	cudaMalloc(&d_B, bytes);
	
	//Initialize content of input array
	int i;
	for(i=0; i<n; i++) {
		for(j=0; j<n; j++) {
			
		h_A[i][j] = i;
		
		}
	}

	//Copy host vector to device
	cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
	
	//Number of threads in each thread block
	dim3 blockSize(32,32,1);
	
	//Number of thread blocks in grid
	int grid = (int)ceil((float)n / blockSize.x);
	dim3 gridSize(grid,grid,1);
	
	//Execute the kernel
	smooth<<<gridSize,blockSize>>>(d_A, d_B, n);
	
	//Copy device vector to host
	cudaMemcpy(h_B, d_B, bytes, cudaMemcpyDeviceToHost);
	
	FILE *f = fopen("file.txt", "w");
	const char *text = "Write this to the file";
	fprintf(f, "Some text: %s\n", text);
	fclose(f);
	
	//Release device memory
	cudaFree(d_A);
	cudaFree(d_B);

	//Release host memory
	free(h_A);
	free(h_B);
	
	return 0;
	}