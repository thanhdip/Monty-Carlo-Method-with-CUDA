# Benchmark

## Implementation
The benchmark is just pitting the CPU and GPU against each other to see who is faster running a simple Monte Carlo method generating digits of PI.
### CPU
The CPU function was quite simple. The following pseudo code explains the implementation.
~~~~
largeN
loop largeN
    x, y = rng(0,1)
    radius = x^2 + y^2
    if(radius <= 1)
        count++
    end
end
PI = 4*count/largeN
~~~~
Abstractly it generates random points (x,y) on a cartesian coordinate. It checks whether or not the random point is within the quarter circle or outside of it.
The area of the circle is then calculated through this since area of a circle is just the points inside it divided by the points outside.

### GPU

The GPU is implemeneted similiarly to the CPU implementation but instead of looping, multiple threads and blocks are created to calculate the area. One important distinction is that the GPU implementation does not generated random points on the fly but relies on pre-generated random points stored into memory which is then accessed by each thread.

The final count of points inside the circle is calculated by adding up a shared array which each thread has access to and sets it to 1 or 0 depending if the point the thread generated was within or without the circle.

## Result
The benchmark was done with 100,000,000 points generated where the CPU and GPU were measured against each other.

![alt text](https://raw.githubusercontent.com/sfsu-698-spring-2019/final-project-woop/master/results.PNG?token=AFAPOBF7GBTLGM6B3DRTJQ2457GIY)

As you can see, the gpu was indeed faster that the CPU and they were both as accurate reliably with 3.141. On average the GPU was 1.095 faster. However due note this is on only 100,000,000 points and both implementation of the Monte Carlo Method was trivial so a more optimized version of both would definitely result in a farther preformance gap.