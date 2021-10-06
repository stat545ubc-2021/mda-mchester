### This code analyses and explores data sets for STAT 545A Milestone 1

#install packages
install.packages("devtools")
devtools::install_github("UBC-MDS/datateachr")

#load libraries
library(datateachr)
library(tidyverse)

#task 1: choose favourite dataset
#flow sample
dim(flow_sample)
class(flow_sample)
view(flow_sample)

#cancer sample
dim(cancer_sample)
class(cancer_sample)
view(cancer_sample)

#vancouver trees
dim(vancouver_trees)
class(vancouver_trees)
view(vancouver_trees)

#apartment buildings
dim(apt_buildings)
class(apt_buildings)
view(apt_buildings)

#task 2: explore favourite dataset

#explore relationship between 2 variables
  ggplot(cancer_sample, 
       aes(x = area_mean, 
           y = radius_mean, 
           group = diagnosis)) +
  geom_point(aes(color = diagnosis),
             size = 3, 
             alpha = 0.4) +
    labs(x = "Area (Mean)", #add labels
         y = "Radius (Mean)", 
         title = "Radius (Mean) vs. Area (Mean)",
         caption = "Source: UCI, 1995") +
    theme(plot.title = element_text(hjust = 0.5)) + 
    scale_color_discrete(name = "Diagnosis", #change legend
                         labels=c("Benign", "Malignant"))

#create boxplot between 2 variables
ggplot(cancer_sample, 
       aes(x = diagnosis,
           y = symmetry_mean)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, colour = "tomato") + 
  labs(x = "Diagnosis", #add labels
       y = "Symmetry (Mean)", 
       title = "Symmetry (Mean) vs Diagnosis",
       caption = "Source: UCI, 1995") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_discrete(breaks = c("B","M"), #change legend
                   labels = c("Benign", "Malignant"))

#make new tibble of interesting variables
tibble(cancer_sample) %>%
  select(diagnosis, radius_mean, area_mean, smoothness_mean, symmetry_mean)

#check density plot of area_mean
ggplot(cancer_sample,
       aes(x = area_mean)) +
  geom_density(aes(fill = diagnosis),
               alpha = 0.8) +
  labs(x = "Area (Mean)", #add labels
       y = "Density", 
       title = "Area (Mean) Density Plot",
       caption = "Source: UCI, 1995") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete(name = "Diagnosis",
                      labels = c("Benign", "Malignant"))
  




