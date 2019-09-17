### Description: R code accompanying Tidy Tuesday activity from Module 4 in BAE 495
### Author: Lacy Parrish
### Date created: September 16, 2019
### Last updated: September 17, 2019

### As a part of this week's course module, I wanted to take a look at the visitation trends at the nationally-recognized sites in my home state. I have used their cleaned version of the NPS data on annual park visitations from 1904 - 2016, the file named "national_parks.csv", as a jumping off point. The FiveThirtyEight article that accompanies the September 17, 2019 #TidyTuesday entry notes that the Great Smoky Mountains National Park is the most visited National Park, but North Carolina has nine sites managed by the National Park Service. Does Great Smoky hold up against the rest?


# Clear the workspace.
rm(list = ls())


# Load packages
library(tidyverse)
library(ggthemes)


# Import Tidy Tuesday data on National Parks
parks <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/national_parks.csv")


# Create a specific file for the North Carolina national "locations;" we have several different designations in our state. 
NC <- parks$state == "NC"

NC_parks <- parks[NC, ]

View(NC_parks)

write_csv(NC_parks, "output/NC_Parks.csv")


# Pull the 'total' lines out of the data (they skew the annual totals on a graph) to create a 'clean' vectored data set.
NC_parks_clean <- (NC_parks[ -c(10, 11, 12, 13, 14, 15, 16, 17, 18), ])


# Run plot of annual visitors over time, by location.
ggplot(NC_parks_clean)+
  geom_point(mapping = aes(x = year, y = (visitors/1000000), color = unit_name))+
  geom_line(mapping = aes(x = year, y = (visitors/1000000), group = unit_name, color = unit_name))+
  scale_y_log10()+
  theme_few()+
  theme(axis.text.x = element_text(angle = 90))+
  xlab("Year")+
  ylab("Number of Visitors (in millions)")+
  labs(color = "National Parks/Sites", title = "Annual Park Visitation for North Carolina Sites", 
       caption = "Source: National Park Service")


# Save at appropriate dimensions for PDF.
ggsave("National_Parks_Visitation_NC.pdf", width = 17, height = 8, units = "in")



