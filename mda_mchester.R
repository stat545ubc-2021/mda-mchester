### This code analyses and explores data sets for STAT 545A Milestone 1
### Code developed by Marshall Chester

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

###2 variables
ggplot(cancer_sample, #explore relationship between variables
       aes(x = area_mean,
           y = radius_mean, 
           group = diagnosis)) +
  geom_point(aes(color = diagnosis),
             size = 3, #add transparency and change size
             alpha = 0.4) +
  labs(x = "Area (Mean)", #add labels
       y = "Radius (Mean)", 
       caption = "Source: UCI, 1995") +
  scale_color_discrete(name = "Diagnosis", #change legend
                       labels=c("Benign", "Malignant")) +
  facet_wrap(~diagnosis) + #facet by row
  theme(strip.text.x = element_blank())
                                

###boxplot
ggplot(cancer_sample, #create boxplot between 2 variables
       aes(x = diagnosis,
           y = symmetry_mean)) +
  geom_boxplot(alpha = 0, #add transparency and change width
               width = 0.25) +
  geom_jitter(alpha = 0.3, #add transparency and change width
              width =0.25) + 
  labs(x = "Diagnosis", #add labels
       y = "Symmetry (Mean)", 
       caption = "Source: UCI, 1995") +
  scale_x_discrete(breaks = c("B","M"), #change x tick
                   labels = c("Benign", "Malignant"))

###tibble
tibble(cancer_sample) %>% #make new tibble of interesting variables
  select(diagnosis, radius_mean, perimeter_mean, area_mean, smoothness_mean, symmetry_mean)

###density plot
ggplot(cancer_sample, #check density plot of area_mean
       aes(area_mean, fill = diagnosis)) +
  geom_density(alpha = 0.6) +
  labs(x = "Area (Mean)", #add labels
       y = "Density",
       fill = "Diagnosis",
       caption = "Source: UCI, 1995") +
  scale_fill_discrete( #change legend titles
    limits = c("B", "M"),
    labels = c("Benign", "Malignant"))
    




