# Tidy Tuesday August 14th, 2020:
This repo contains code for a [Shiny app](https://jake-scott.shinyapps.io/Public_Spending_On_Children/) that I built for the August 14th, 2020 TidyTuesday. The app allows users to explore public spending on children by state over time (data provided by the Urban Institute). Users can adjust which program they look at, the measure of spending, and the year they focus on. The map is interactive, allowing users to see both the overall trends and the exact spending by a given state. 

![image](https://user-images.githubusercontent.com/56490913/93687846-2b2f2a00-fa8f-11ea-8b8d-4230fc81a41a.png)


## Getting Started

The easiest way to use the web application is to go to the webpage itself, which can be found [Shiny app](https://jake-scott.shinyapps.io/Public_Spending_On_Children/). 

If you want to run or edit the code on your own computer, simply download the code and data from this repo, enter the Public_Spending_On_Children folder, and run the app.R file. The Plot_Function.R file defines the function that actually generates the plot, and is sourced by the app.R file.

Outside of the Public_Spending_On_Children folder there are 3 files of interest, though none of them are actually used by the webapp. The first is Exploration.R, which, as the name suggests, was simple me exploring the data. The Inital_Plot.R file is basically what became the plotting function. The code within it is essentially put into a function. The non_plotly_plot_function.R was an attempt to make a non-interactive (but faster loading) version of the map. 

This project represents my standard process for designing a Shiny app. I first write an R file where I manually define the parameters of interest (here that includes year, program, and measure) and make sure it generates the outcome of interest (plot, table, etc.). I then put this code into a function, making sure that the changes in the parameters are reflected in the output. Finally, I put this function into a shiny app, plugging in input$* for the parameters (where \*, in this case, would be year or measure).  

### Prerequisites

To run the code on your computer you just need R and the following packages installed and loaded:

```
# Loading Libs ------------------------------------------------------------
library(shiny)
library(urbnmapr)
library(tidyverse)
library(readr)
library(plotly)
library(shinycssloaders)
library(shinydashboard)
library(shinyWidgets)

```

## Author

* **Jake Scott** - [Twitter](https://twitter.com/jakepscott2020), [Medium](https://medium.com/@jakepscott16)


