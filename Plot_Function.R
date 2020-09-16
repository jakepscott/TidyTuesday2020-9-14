# Loading Libraries -------------------------------------------------------
library(tidyverse)
library(tidytuesdayR)
library(readr)
library(albersusa)
library(plotly)
windowsFonts(`Roboto Condensed` = windowsFont("Roboto Condensed"))
# Loading Data ------------------------------------------------------------
tuesdata <- tidytuesdayR::tt_load('2020-09-15')
kids_data <- tuesdata$kids

# Defining Function -------------------------------------------------------
plot_function <- function(program,year_choice,measure){

# Setting Up Labels -------------------------------------------------------
  if (measure=="raw") {
    kids_data <- kids_data %>% mutate(label=paste0(state, " spent $", prettyNum(round(raw,1),big.mark = ","), " in ", year_choice))
  }
  
  
  if (measure=="inf_adj") {
    kids_data <- kids_data %>% mutate(label=paste0(state, " spent $", prettyNum(round(inf_adj,1),big.mark = ","), " (inflation adj.) in ", year_choice))
  }
  
  if (measure=="inf_adj_perchild") {
    kids_data <- kids_data %>% mutate(label=paste0(state, " spent $", round(inf_adj_perchild,1), " per child (inflation adj.) in ", year_choice))
  }


# Prepping Data -----------------------------------------------------------
  
  clean <- kids_data %>% 
    filter(variable==program) %>% 
    filter(year==year_choice) 
  
  map <- usa_sf() %>% rename("state"=name)
  data <- map %>% left_join(clean,by="state")
  

# Plot --------------------------------------------------------------------
  plot <- ggplot(data = data, aes(text=label)) +
    geom_sf(aes_string(fill=measure)) +
    scale_fill_continuous( low = "white", high = "darkgreen", 
                           name = "Spending", label = scales::dollar) +
    labs(caption = "Plot: @jakepscott2020 | Data: Urban Institute") +
    theme_minimal(base_size = 12,base_family = "Roboto Condensed") +
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          panel.grid = element_blank(),
          plot.caption = element_text(face = "italic", size = rel(.8), 
                                      color = "grey70"))
  
  
  ggplotly(plot,tooltip = "text") %>% 
    style(hoveron="fill") 
}

# plot_function(program = "PK12ed", 
#               year_choice = 2016,
#               measure = "inf_adj")
