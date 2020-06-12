# SocialBubble

This repository contains the underlying code and functions used in the paper ["The effectiveness of social bubbles as part of a Covid-19 lockdown exit strategy, a modelling study"](https://www.medrxiv.org/content/10.1101/2020.06.05.20123448v1), by Trystan Leng*, Connor White, Joe Hilton, Adam J Kucharski, 
Lorenzo Pellis, Helena Stage, Nicholas Davies, CMMID nCov working group, Matt Keeling & Stefan Flasche.



Corresponding author: Trystan Leng, email: t.leng@warwick.ac.uk

Underlying code and functions are written in matlab, and visualisations are written in matlab or R.

# Regenerating results

To generate the underlying data for the plots in Figures 2, 4, and S3-7, users should run the code 'MainCode.m'. After running this, users should then run 'DataMaker.m' to produce the underlying .csv files. 

To generate the underlying data for the plots in Figure 3, users should run the code 'figure3Code.m', which runs the code
and produces the underlying .csv files.

The R code 'plots.r' can be run as it is in order to generate the exact plots of Figures 1-4 and S3-7. To generate analogous plots from regenerated data, the .csv files should be amended, with those generated from 'MainCode.m' and 'figure3Code.m'

To generate the data and plots for Supplementary Figure S1, users should run the code 'suppfigureS1.m'

To generate the data and plots for Supplementary Figure S2, users should run the code 'suppfigureS2.m'

# Generating new results

In this study we use a stochastic network simulation model to assess the impact of social bubbles. While in this study, we 
consider households and the effect of introducing bubbles to an epidemic, and consider three age classes (children, adults, 
and older adults), our simulation methods are general, and could be used for an arbitrary probability matrix with an arbitrary 
number of risk classes. 

For a description of the underlying functions of the model, see the pdf file 'UnderlyingFunctions.pdf' (coming soon).

For a brief vignette on how to use the functions described in this repository, see the pdf file 'Vignette.pdf' (coming soon).

