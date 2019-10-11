#include <iostream>
#include <random>
#include <cstdlib>
#include <math.h>
#include <chrono>
#include <curand.h>
#include <curand_kernel.h>
#include <assert.h>

#define gNPOINTS 100000000
#define cNPOINTS 100000000

__global__
void gpuMontyCarlo(int *gpuInCricle, double *randomNums)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    double xPoint = randomNums[idx];
    double yPoint = randomNums[idx+gNPOINTS];

    double radius = (xPoint*xPoint) + (yPoint*yPoint);
    if(radius <= 1)
    {
        gpuInCricle[idx] = 1;
    }
    else
    {
        gpuInCricle[idx] = 0;
    }
};

void cpuMontyCarlo(double &cpuPI)
{
    std::mt19937 rng(time(NULL));
    std::uniform_real_distribution<double> randomPoint(0.0,1.0);

    int inCircle = 0;
    double radius;
    double xPoint;
    double yPoint;
    
    for(int x = 0; x < cNPOINTS; x++)
    {
        xPoint = randomPoint(rng);
        yPoint = randomPoint(rng);
        //radius of unit circle is x^2+y^2 = 1
        radius = (xPoint*xPoint) + (yPoint*yPoint);

        if(radius <= 1)
        {
            inCircle++;
        }
    }
    cpuPI = 4.0*((double)inCircle/cNPOINTS);
};

int main()
{
    // CPU ---------------------------------------------------------------------------------------------------------------
    double cpuPI;
    auto cpuStart = std::chrono::system_clock::now();

    cpuMontyCarlo(cpuPI);

    auto cpuEnd = std::chrono::system_clock::now();

    // GPU ---------------------------------------------------------------------------------------------------------------
    
    //Setup gpu random number states
    double gpuPI;
    int *gpuInCricle;
    double *randomNums;
    cudaMallocManaged(&gpuInCricle, gNPOINTS*sizeof(int));
    cudaMallocManaged(&randomNums, gNPOINTS*2*sizeof(double));

    std::mt19937 rng(time(NULL));
    std::uniform_real_distribution<double> randomPoint(0.0,1.0);
    for(int x = 0; x < gNPOINTS*2; x++)
    {
        randomNums[x] = randomPoint(rng);
    }

    auto gpuStart = std::chrono::system_clock::now();

    gpuMontyCarlo<<<gNPOINTS/1000, 1000>>>(gpuInCricle, randomNums);
    cudaDeviceSynchronize();

    auto gpuEnd = std::chrono::system_clock::now();

    int gInCricle = 0;
    for(int x = 0; x < gNPOINTS; x++)
    {
        if(gpuInCricle[x] == 1)
        {
            gInCricle++;
        }
    }
    gpuPI = 4.0*((double)gInCricle/gNPOINTS);

    std::chrono::duration<double> cpuTime = cpuEnd - cpuStart;
    std::chrono::duration<double> gpuTime = gpuEnd - gpuStart;
    std::cout << "CPU PI: " << cpuPI << " : TIME " << cpuTime.count() << std::endl;
    std::cout << "GPU PI: " << gpuPI << " : TIME " << gpuTime.count() << std::endl;

    cudaFree(gpuInCricle);
    cudaFree(randomNums);
    return 0;
}