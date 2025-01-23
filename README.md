# Z-Splinets

The Z-Splinets package offers a comprehensive framework for building Z-splines, their orthogonalization, and evaluating or projecting data onto a Z-splines basis. It supports users in visualizing Z-splines by providing intuitive plotting functions. This package is designed to facilitate advanced functional data analysis tasks by combining robust mathematical tools and user-friendly functionality, ensuring seamless integration into your analysis workflow.

## Mathematical formulation 
The $Z\!B$-spline of degree $k\in \mathbb{N}_0$ is defined as a first derivative of $B$-spline
\begin{equation}\label{defZB}
Z_{i}^{k+1}(x):=\frac{\mbox{d}}{\mbox{d}x} B_{i}^{k+2}(x).
\end{equation}
From this definition of $Z\!B$-splines and the formula for derivation of $B$-splines \cite{dierckx}, the relation% for $k\geq 0$ %, for $k\geq 1$ $Z\!B$-splines can be obtained as
\begin{equation*}
\label{defZ}
Z_i^{k+1}(x)=(k+1)\left(\frac{B_i^{k+1}(x)}{\lambda_{i+k+1}-\lambda_i}-\frac{B_{i+1}^{k+1}(x)}{\lambda_{i+k+2}-\lambda_{i+1}}\right), \quad k\geq 0
\end{equation*}
with the local support
$$\mbox{supp}\;Z_i^{k+1}(x) \; = \; \mbox{supp}\;B_i^{k+2}(x)=[\lambda_i,\lambda_{i+k+2}).$$
For more details see [the
arxiv link](https://arxiv.org/pdf/2405.02231.pdf) for the paper, Efficient spline orthogonal basis for representation of density functions

## Installation

You can install the development version of Z-Splinets from GitHub using the `devtools` package:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install Z-Splinets package from GitHub
devtools::install_github("HibaNassarDTU/Z-Splinets")

