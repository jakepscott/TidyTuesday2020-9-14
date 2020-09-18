# Loading Libs ------------------------------------------------------------
library(shiny)
library(urbnmapr)
library(tidyverse)
#library(tidytuesdayR)
library(readr)
library(plotly)
library(shinycssloaders)
library(shinydashboard)
library(shinyWidgets)


#grDevices::windowsFonts(`Roboto Condensed` = windowsFont("Roboto Condensed"))
# Loading Data ------------------------------------------------------------
#tuesdata <- tidytuesdayR::tt_load('2020-09-15')
source("Plot_Function.R")


# App ---------------------------------------------------------------------

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Spending on Children By State"),
                    dashboardSidebar(selectInput('program', 'Program', 
                                                 choices = list(
                                                   Education=c("K-12 Education"="PK12ed",
                                                               "Higher Education"="highered",
                                                               "Education Subsidies"="edsubs",
                                                               "Education Special Services"="edservs",
                                                               "Pell Grants"="pell",
                                                               "Head Start" = "HeadStartPriv"),
                                                   Health=c("Children's Health Insurance Program (CHIP)"="Medicaid_CHIP",
                                                            "Public Health"="pubhealth",
                                                            "Other Health Spending"="other_health"),
                                                   `Social Programs`=c("TANF"="TANFbasic",
                                                                       "SNAP"="SNAP",
                                                                       "Social Security"="socsec",
                                                                       "Federal SSI"="fedSSI",
                                                                       "Federal EITC"="fedEITC",
                                                                       "State EITC"="stateEITC",
                                                                       "Child Tax Credit"="CTC",
                                                                       "Additional Child Tax Credit"="addCC",
                                                                       "Unemployment Compensation"="unemp",
                                                                       "Workers Compensation"="wcomp",
                                                                       "Other Cash Payments"="othercashserv"),
                                                   Other=c("Housing and Community Development"="HCD",
                                                           "Libraries"="lib",
                                                           "Parks and Recreation"="parkrec"
                                                   ))),
                                     selectInput('measure', 'Measure', c("Inflation Adjusted Dollars Per Child"="inf_adj_perchild",
                                                                         "Inflation Adjusted Total Dollars"="inf_adj",
                                                                         "Nominal Total Dollars"="raw"
                                                                         )),
                                     setSliderColor("#85bb65",sliderId = 1),
                                     tags$style(type = "text/css", ".irs-grid-pol {background: #85bb65;}"),
                                     sliderInput(inputId = "year", label = "Year",
                                                 min = 1997, max = 2016, value = 2016,
                                                 sep="")
                    ),
                    dashboardBody(fluidRow(column(12,align="center",
                      withSpinner(plotlyOutput('plot',width = "1200px", height = "700px"),type = 6,color = "#85bb65"))))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlotly({
    plot_function(program = input$program,
                  measure = input$measure,
                  year_choice = input$year)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

