Mini Data Analysis (Milestone 1)
================
Marshall Chester
2021-10-09

-   [**Introduction**](#introduction)
-   [**Task 1: Choose dataset**](#task-1-choose-dataset)
-   [**Task 2: Explore dataset**](#task-2-explore-dataset)
-   [**Task 3: Research Questions**](#task-3-research-questions)

# **Introduction**

### **Purpose**

The purpose of this markdown is to complete STAT 545A Mini-Data Analysis
(Milestone 1).

The author will:

1.  Become familiar with one dataset
2.  Create four questions from selected dataset
3.  Write a reproducible and clear report with R Markdown

Several open-sourced datasets will be explored, and one final dataset
will be visualized for research purposes.

### **Author**

The author of this code is Marshall Chester, with open sourced data from
the `datateachr` library.

### **Packages**

The following packages must be installed:

``` r
# install.packages("devtools")
# devtools::install_github("UBC-MDS/datateachr")
```

The following libraries must be loaded:

``` r
library(datateachr)
library(tidyverse)
```

# **Task 1: Choose dataset**

### **Initial ranking**

1.  flow_sample
2.  cancer_sample
3.  vancouver_trees
4.  apt_buildings

### **Dataset exploration**

``` r
dim(flow_sample)
```

    ## [1] 218   7

``` r
class(flow_sample)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
dim(cancer_sample)
```

    ## [1] 569  32

``` r
class(cancer_sample)
```

    ## [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"

``` r
dim(vancouver_trees)
```

    ## [1] 146611     20

``` r
class(vancouver_trees)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
dim(apt_buildings)
```

    ## [1] 3455   37

``` r
class(apt_buildings)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

### **Dataset attributes**

|     Dataset     |  Rows   | Columns |   Class    | Potential Research Question                                            |
|:---------------:|:-------:|:-------:|:----------:|:-----------------------------------------------------------------------|
|   flow_sample   |   218   |    7    | data.frame | Is maximum flow always within June and July?                           |
|  cancer_sample  |   569   |   32    | data.frame | What is the average area of malignant diagnoses?                       |
| vancouver_trees | 146,611 |   20    | data.frame | Which Vancouver neighbourhood has the greatest number of tree species? |
|  apt_buildings  |  3,455  |   37    | data.frame | What percentage of buildings built before 2000 have air conditioning?  |

### **Pair down**

After viewing the data, I decided to proceed with cancer_sample and
apt_buildings. These datasets are rich and include greater than 30
variables and 500 points for exploration and visualization.

### **Final decision**

I have decided to proceed with the cancer_sample dataset due to personal
interest in healthcare. The dataset is robust with a significant number
of variables and points for further evaluation. With subsetting, I
believe this dataset is well suited for analysis of strength of
association and predictive modeling.

# **Task 2: Explore dataset**

In the cancer_sample dataset, area_mean and radius_mean are continuous
variables and can be explored by plotting each variable on the x and y
axis, respectively. A positive, linear relationship is expected. By
grouping data points with diagnosis (dichotomous variable), an
interesting relationship could be seen.

### **New tibble**

The cancer_sample includes 32 unique variables. A new tibble can be
created to include the variables most interesting to the author. For the
purpose of model building, this parsed tibble will help to create an
efficient workflow.

``` r
tibble(cancer_sample) %>% #make new tibble of interested variables
  select(diagnosis, radius_mean, perimeter_mean, area_mean, smoothness_mean, symmetry_mean)
```

    ## # A tibble: 569 × 6
    ##    diagnosis radius_mean perimeter_mean area_mean smoothness_mean symmetry_mean
    ##    <chr>           <dbl>          <dbl>     <dbl>           <dbl>         <dbl>
    ##  1 M                18.0          123.      1001           0.118          0.242
    ##  2 M                20.6          133.      1326           0.0847         0.181
    ##  3 M                19.7          130       1203           0.110          0.207
    ##  4 M                11.4           77.6      386.          0.142          0.260
    ##  5 M                20.3          135.      1297           0.100          0.181
    ##  6 M                12.4           82.6      477.          0.128          0.209
    ##  7 M                18.2          120.      1040           0.0946         0.179
    ##  8 M                13.7           90.2      578.          0.119          0.220
    ##  9 M                13             87.5      520.          0.127          0.235
    ## 10 M                12.5           84.0      476.          0.119          0.203
    ## # … with 559 more rows

### **Density plot**

Peaks within a density help to understand where the data are
concentrated. In the cancer_sample dataset, the area_mean variable
provides continuous data on the average area of diagnoses. A density
plot can be created to visualize the concentration of values for both
malignant and benign diagnoses. With this visualization, a greater
understanding is available.

``` r
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
```

<img src="mda_mchester_files/figure-gfm/density plot-1.png" style="display: block; margin: auto;" />

### **Create boxplot**

A boxplot can provide detailed information between dichotomous and
continuous variables. In the cancer_sample dataset, diagnosis is
dichotomous (malignant or benign) and symmetry_mean is continuous. A
boxplot will help visualize the relationship between malignant and
benign diagnoses. There may be an interesting outcome for further
consideration.

``` r
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
```

<img src="mda_mchester_files/figure-gfm/boxplot-1.png" style="display: block; margin: auto;" />

### **Explore relationship**

``` r
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
    facet_wrap(~diagnosis) + #facet
  theme(strip.text.x = element_blank())
```

<img src="mda_mchester_files/figure-gfm/scatterplot-1.png" style="display: block; margin: auto;" />

# **Task 3: Research Questions**

With the dataset selected and explored, four potential research
questions are postulated.

1.  Which subsetted variables are most predictive of a malignant
    diagnosis?

2.  Which subsetted variables are least predictive of a benign
    diagnosis?

3.  Is the relationship between symmetry and diagnoses statistically
    significant?

4.  What is the strength of association between mean radius and area?
