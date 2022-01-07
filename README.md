# Implementation of RANSAC (Random Sample Consensus) Algorithm

## Basics
RANSAC algorithm is an iterative and a non-deterministic algorithm that helps in eliminating outliers. This algorithm is commonly used to solve computer vision challenges. 

Distribution of a 2D point cloud           |  Linear regression in the presence of outliers gives confusing results
:-------------------------:|:-------------------------:
![](https://iili.io/Ygdj9e.png)  |  ![](https://iili.io/YgdRat.png)

As you can see the results are not accurate enough. Least-squares methods (such as the one used here) are sensitive to outliers, and there are a lot of outliers (as far as we’re only interested in the diagonal linear area of high density) in this cloud.

##RANSAC Algorithm

You may find the article [here](http://www.cs.ait.ac.th/~mdailey/cvreadings/Fischler-RANSAC.pdf). 

The Ransac algorithm has proposed the following algorithm to solve this problem. 

1. Select randomly the minimum number of points required to determine the model
parameters.
2. Solve for the parameters of the model.
3. Determine how many points from the set of all points fit with a predefined tolerance ε.
4. If the fraction of the number of inliers over the total number points in the set exceeds a predefined threshold τ, re-estimate the model parameters using all the identified inliers and terminate.
5. Otherwise, repeat steps 1 through 4 (maximum of N times).


The number of iterations, N, is chosen high enough to ensure that the probability p (usually set to 0.99) that at least one of the sets of random samples does not include an outlier.

 