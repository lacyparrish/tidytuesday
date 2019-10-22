####################################################################################
# Description: Homework - Tidy Tuesday Activity (from Module 8 in BAE 495)
# Author: Lacy Parrish
# Date created: October 20, 2019
# Last updated: October 22, 2019
####################################################################################

# Prepare workspace and load packages. ------------------------------------
rm(list = ls())
library(tidyverse)
library(ggthemes)

# Load and inspect the dataset. -----------------------------------
media_franchises <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-02/media_franchises.csv")

summary(media_franchises)
colnames(media_franchises)

# Tidy the data. ----------------------------------------------------------
media_franchises %>%  
  mutate(franchise = str_replace(franchise, "A Song of Ice and Fire /  Game of Thrones", "GameThrones"),
         franchise = str_replace(franchise, "Middle-earth / Lord of the Rings", "LordRings"),
         franchise = str_replace(franchise, "The Hunger Games", "HungerGames"),
         franchise = str_replace(franchise, "Wizarding World / Harry Potter", "HarryPotter")) -> media_franchises_1


# Relationship of when franchise was established to revenue sources.----------------

media_franchises_1 %>% 
  ggplot(aes(year_created, revenue)) +
  geom_smooth(aes(color = revenue_category),method = "lm", se = FALSE) +
  xlim(1920, 2019) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom", legend.text = element_text((size = 9))) +
  labs(title = "Revenue Trends Over Time",
       x = "Franchise Established",
       y = "Revenue (USD, in billions)",
       color = "Type of Revenue") 


# Diversifying franchises that began with a novel. --------------------------------

media_franchises_1 %>%
  filter(original_media == "Novel") %>%
  ggplot() +
  geom_col(aes(x = franchise, y = revenue, 
               fill = revenue_category)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = -90), 
        legend.key.height = unit(0.1, "cm"),
        legend.position = "bottom") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "'What a novel idea!'",
       x = "",
       y = "Revenue (USD, in billions)",
       fill = "How they earned it")






           