#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers.
# Author: Ruiying Li
# Date: 24 September 2024 [...UPDATE THIS...]
# Contact: ruiying.li@mail.utoronto.ca
# License: MIT
# Pre-requisites:None
# Any other information needed?

#### Workspace setup ####

library(tidyverse)
library(dplyr)

raw_data <- read.csv("data/raw_data/raw_data.csv")


#transfer str into factor
location<- as.factor(data$location)
civic_centre<- as.factor(data$civic_centre)


#cleaning data
cleaned_data<-raw_data |>
   janitor::clean_names()

#sorting in dates order
sorted_data<-cleaned_data|>arrange(dates)

#cleaning data in season order
cleaned_data <- cleaned_data %>%
  mutate(year = year(dates), 
         season = case_when(
           month(dates) %in% c(12, 1, 2) ~ "Winter",  
           month(dates) %in% c(3, 4, 5) ~ "Spring", 
           month(dates) %in% c(6, 7, 8) ~ "Summer",  
           month(dates) %in% c(9, 10, 11) ~ "Fall"   
         ))

cleaned_data <- cleaned_data%>%select(-dates)

cleaned_data
 #### Save data ####
write.csv(cleaned_data, "data/analysis_data/analysis_data.csv")

