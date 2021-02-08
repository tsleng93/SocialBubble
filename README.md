# SocialBubble

This repository contains the underlying code and functions used in the paper ["The effectiveness of social bubbles as part of a Covid-19 lockdown exit strategy, a modelling study"](https://www.medrxiv.org/content/10.1101/2020.06.05.20123448v1), by Trystan Leng*, Connor White, Joe Hilton, Adam J Kucharski, 
Lorenzo Pellis, Helena Stage, Nicholas Davies, CMMID nCov working group, Matt Keeling & Stefan Flasche.



<a href="https://zenodo.org/badge/latestdoi/264142766"><img src="https://zenodo.org/badge/264142766.svg" alt="DOI"></a>

Corresponding author: Trystan Leng, email: t.leng@warwick.ac.uk

Underlying code and functions are written in matlab, and visualisations are written in matlab or R.

# Regenerating results

To generate the underlying data for the plots in Figures 3, 8, and the Extended Data, users should run the code 'MainCode.m'. After running this, users should then run 'DataMaker.m' to produce the underlying .csv files. 

To generate the underlying data for the plots in Figure 7, users should run the code 'figure7Code.m', which runs the code
and produces the underlying .csv files.

The R code 'plots.r' can be run as it is in order to generate the exact plots of Figures 1, 3, 6, 8 and the Extended Data. To generate analogous plots from regenerated data, the .csv files should be replaced with those generated from 'MainCode.m' and 'figure7Code.m'

To generate the data and plots for Figure 2, Figure 4, Figure 5, and Figure 6 users should run the code 'figure2Code.m', 'figure4Code.m', etc.

# Using GNU Octave

The analysis performed using MATLAB can be replicated using the open MATLAB compatible software GNU Octave, with minimal adjustments. To run the analyses using Octave, only one function needs amended - 'PruneMatrixFull.m'. To do so, uncomment the lines saying %for GNU Octave%, and comment out the lines saying %for Matlab%. 


# Generating new results

In this study we use a stochastic network simulation model to assess the impact of social bubbles. While in this study, we consider households and the effect of introducing bubbles to an epidemic, and consider three age classes (children, adults, and older adults), our simulation methods are general, and could be used for an arbitrary probability matrix with an arbitrary number of risk classes. 

For a description of the underlying functions of the model, see the pdf file 'UnderlyingFunctions.pdf'.

For a brief vignette on how to use the functions described in this repository, see the pdf file 'Vignette.pdf'.

To create age stratified household distributions from publicly available data, which can be used to build syntetic populations for this model, see:

Hilton J (2020). JBHilton/processing-household-composition-data. [Data Collection]. Github. [https://doi.org/10.5281/zenodo.4048649](https://doi.org/10.5281/zenodo.4048649)

