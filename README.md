# honeydukes
A collection of 'sweet' 🍭 'magical' 🪄 tools

<img src="man/figures/honeydukes.png" width="200"/>

A growing collection of 'sweet' 🍭 'magical' 🪄 tools. Many of the tools have been developed to assisint in development environment situations. 

## Functions

At the moment this package contains the following functions:

* `envobj` which prints a ANSI coloured table listing all objcets in the current environment and their details, such as object type and dimensions. Useful for when working outside RStudion on a remote server via a terminal
* `corner` prints the top left corner of a user define matrix or data frame. This is very hand in bioinformatics when you are back and forth checking the general contents of a genotype matrix.

## Installation 
Installing is simple, you will just need to make sure you have the [remotes](https://github.com/r-lib/remotes) package from [cran](https://cran.r-project.org/web/packages/remotes/index.html) installed first.
```r
install.packages("remotes") # if not already installed
remotes::install_github("lpembleton/honeydukes")
```

## Dependencies
This package currently imports functions from [emphatic](https://github.com/coolbutuseless/emphatic) package by [coolbutuseless](https://github.com/coolbutuseless) for the ANSI colour highlighting.
If installed following the installation instructions {emphatic} should be automatically installed at the same time. 
