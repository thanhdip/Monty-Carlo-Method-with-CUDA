# Monty Carlo Method with CUDA, Finding area under the curve
## Thanh Dip

## Proposal

The Monte Carlo method is a very easy way to find the area under curves and even simulate or solve probabilistic problems. At it's simplest for solving an area under a curve, the Monte Carlo method basically fills an area with random generated points which checks whether the point is under or above the curve.

Let's say there are N random points on a graph with some limit C. There are X points that are under the graph and so it's easy to claculate the area C*(X/N).

![alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Pi_30K.gif/330px-Pi_30K.gif)

The method can be used to find the area under any curve given that it can be represented as some boolean function. So curves that are non-trivial can be just as easily calculated.

What makes this method good for parallelization is the fact that it just makes multiple similiar calculation which can be done in CUDA.

So this project is just a CUDA implmentation of the Monty Carlo method to find an area under a curve. To make it more simple the project is going to try and find as many digits of PI as possible.

There will be a comparison between a near flagship intel CPU and NVIDIA GPU and implementation and preformance increases in different CUDA implementation. Preformance is going to be measured with the time it takes for the method to finish and the accuracy of PI.
