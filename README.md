# Monty Carlo Method with CUDA, Finding area under the curve
## Thanh Dip

## Overview

The Monte Carlo method is a very easy way to find the area under curves and even simulate or solve probabilistic problems. At it's simplest for solving an area under a curve, the Monte Carlo method basically fills an area with random generated points which checks whether the point is under or above the curve.

Let's say there are N random points on a graph with some limit C. There are X points that are under the graph and so it's easy to claculate the area C*(X/N).

![alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Pi_30K.gif/330px-Pi_30K.gif)

This project was just a CUDA implmentation of the Monty Carlo method to find an area under a curve of a quarter circle to find as many digits of PI as possible.

You can find the implementation details in the benchmark.md file and the intial proposal which is similiar to this in the proposal.md.

## Results
The comparison was between a near flagship intel CPU and NVIDIA GPU and implementation and preformance increases in different CUDA implementation.

![alt text](https://github.com/thanhdip/Monty-Carlo-Method-with-CUDA/blob/master/results.PNG)

The gpu was indeed faster that the CPU and they were both as accurate reliably with 3.141. On average the GPU was 1.095 faster. However due note this is on only 100,000,000 points and both implementation of the Monte Carlo Method was trivial so a more optimized version of both would definitely result in a farther preformance gap.

Some issues were the generation of random numbers and how the CUDA implementation was to count the different results between all thread and blocks. This could have been handled better by using CUDA array reducing methods and pre-generated RNGs so that both the CPU and GPU implementation was as fast as possible.

Overall, it went as expected and while parrelization can give you a very high preformance increase in certain tasks the implementation is always more complex than a serial implementation.
