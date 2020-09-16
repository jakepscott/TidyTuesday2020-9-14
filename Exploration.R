# Loading Libraries -------------------------------------------------------
library(tidyverse)
library(tidytuesdayR)
library(readr)

# Loading Data ------------------------------------------------------------
tuesdata <- tidytuesdayR::tt_load('2020-09-15')


# Exploring Data ----------------------------------------------------------
kids_data <- tuesdata$kids


kids_data %>% distinct(variable)


kids_data %>% filter(variable=="TANFbasic") %>% group_by(year) %>% summarise(spending=sum(inf_adj)) %>% 
  ggplot(aes(x=year,y=spending)) +
  geom_line(lwd=2)


kids_data %>% filter(variable=="TANFbasic") %>% group_by(year) %>% 
  summarise(spending=mean(inf_adj_perchild,na.rm = T)) %>% 
  ggplot(aes(x=year,y=spending)) +
  geom_line(lwd=2)

kids_data %>% group_by(year,variable) %>% 
  summarise(spending=mean(inf_adj_perchild,na.rm = T)) %>% 
  ggplot(aes(x=year,y=spending)) +
  geom_line(aes(col=variable),lwd=2) +
  facet_wrap(~variable)
