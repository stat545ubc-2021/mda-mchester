
#install packages and load libraries

install.packages("devtools")
devtools::install_github("UBC-MDS/datateachr")
library(datateachr)
library(tidyverse)

#explore selected datasets
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
print(vancouver_trees)

#apartment buildings
dim(apt_buildings)
class(apt_buildings)
print(apt_buildings)














```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
  
  ```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:
  
  ```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
