
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
       aes(area_mean, radius_mean)) +
  geom_point(aes(color = diagnosis),
             size = 3, 
             alpha = 0.4)

#create boxplot between 2 variables
ggplot(cancer_sample, 
       aes(x = diagnosis, y = symmetry_mean)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, colour = "tomato")

#make new tibble of interesting variables
tibble(cancer_sample) %>%
  select(diagnosis, radius_mean, area_mean, smoothness_mean, symmetry_mean)

#check distribution of area_mean
ggplot(cancer_sample,
       aes(area_mean)) +
  geom_histogram(bins = 20)




