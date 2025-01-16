# Z-Splinets

The Z-Splinets package offers a comprehensive framework for building Z-splines, their orthogonalization, and evaluating or projecting data onto a Z-splines basis. It supports users in visualizing Z-splines by providing intuitive plotting functions. This package is designed to facilitate advanced functional data analysis tasks by combining robust mathematical tools and user-friendly functionality, ensuring seamless integration into your analysis workflow.

## Installation

You can install the development version of Z-Splinets from GitHub using the `devtools` package:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install Z-Splinets package from GitHub
devtools::install_github("HibaNassarDTU/Z-Splinets")

## Usage

# Load the Z-Splinets package
library(Z-Splinets)

# Example: Constructing a Z-spline basis
z_basis <- construct_z_spline_basis(data)

# Orthogonalizing the Z-spline basis
orthogonal_basis <- orthogonalize_z_splines(z_basis)

# Projecting data onto the Z-spline basis
projection <- project_onto_z_spline(data, orthogonal_basis)

# Visualizing the Z-splines
plot_z_splines(orthogonal_basis)

