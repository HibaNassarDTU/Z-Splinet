# Z-Splinets

The $ZB$-Splinets package offers a comprehensive framework for building $ZB$-splines, their orthogonalization, and evaluating or projecting data onto a $ZB$-splines basis. It supports users in visualizing $ZB$-splines by providing intuitive plotting functions. This package is designed to facilitate advanced functional data analysis tasks by combining robust mathematical tools and user-friendly functionality, ensuring seamless integration into your analysis workflow.

## Mathematical Formulation

The $ZB$-spline of degree $k \in \mathbb{N}_0$ is defined as the first derivative of a $B$-spline:

$$
Z_{i}^{k+1}(x) := \frac{\mathrm{d}}{\mathrm{d}x} B_{i}^{k+2}(x).
$$

From this definition and the differentiation formula for $B$-splines, the relation for $k \geq 0$ is:

$$
Z_i^{k+1}(x) = (k+1) \left( \frac{B_i^{k+1}(x)}{\lambda_{i+k+1} - \lambda_i} - \frac{B_{i+1}^{k+1}(x)}{\lambda_{i+k+2} - \lambda_{i+1}} \right),
$$

with the local support:

$$
\text{supp}\;Z_i^{k+1}(x) = \text{supp}\;B_i^{k+2}(x) = [\lambda_i, \lambda_{i+k+2}).
$$

For more details see [the
arxiv link](https://arxiv.org/pdf/2405.02231.pdf) for the paper, Efficient spline orthogonal basis for representation of density functions

## Installation

You can install the development version of Z-Splinets from GitHub using the `devtools` package:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install Z-Splinets package from GitHub
devtools::install_github("HibaNassarDTU/Z-Splinets")

