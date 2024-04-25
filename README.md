## Introduction

What if you'd like to analyze flow cytometry data using **non** commercial softwares?

This repo is aimed at providing some examples of tools and routines you can use to do so.

## Install necessary packages

### Flow cytometry packages

Raphael Gottardo research lab is maintaining R packages to analyse flow cytometry data (https://github.com/RGLab). I recommend installing these from the lab's repo:

```
devtools::install_github("RGLab/flowCore",force=TRUE)
devtools::install_github("RGLab/ggcyto",force=TRUE)
devtools::install_github("RGLab/flowWorkspace",force=TRUE)
devtools::install_github("RGLab/cytolib",force=TRUE)
devtools::install_github("RGLab/CytoML",force=TRUE)
devtools::install_github("RGLab/openCyto",force=TRUE)
```

Dillon Hammill has published a very nice piece of software, CytoExploreR, to perform exploratory flow cytometry data analysis.

```
devtools::install_github("DillonHammill/CytoExploreR")
```

### Visualization packages

Rebecca Barter has published 'superheat' to produce nice heatmaps.

```
devtools::install_github("rlbarter/superheat")
```

### Other useful tools

In order to reduce the number of dimensions in "high dimensional data", here are a few ressources.
NB: high dimensional data refers to datasets where the number of features or dimensions p, is larger than the number of observations n. We are **not** in this case in flow cytometry. But dealing with dozens of dimensions is complicated enough to wish for dimension reduction tools.

### Phenograph algorithm

#BiocManager::install("sararselitsky/FastPG")

## Running the analysis

### Exploring data using cytoexploreR

Run `load_libraries.R`, `import_data_CytoexploreR.R`. Then in `manual_gating_using_cytoexploreR.R` run three different chunks separately to gate T and B cells.

Use `data_analysis.Rmd` to plot 1D/2D distributions, and graphs recapitulating gating schemes as well as frequencies/counts of each cell types in each samples.

### Exploring data using flowworkspace

Run `load_libraries.R`, `import_data_flowWorkSpace.R`. Then, run `plotting_and_clustering.R` to cluster according to Phenograph algorithm, perform enrichment analysis and plot phenographs.

One thing I am not satisfied with now, is the fact that the phenograph gives slightly different results, each time I am running it. Also, not clear to me which parameters I should use. Which are the ones that are making sense?

### To do

- [] Make the phenograph construction more reproducible
- [] Set up a metric to compare two phenograph output

