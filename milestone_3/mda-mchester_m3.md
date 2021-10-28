Mini Data-Analysis Deliverable 3
================

# Welcome to your last milestone in your mini data analysis project!

In Milestone 1, you explored your data and came up with research
questions. In Milestone 2, you obtained some results by making summary
tables and graphs.

In this (3rd) milestone, you’ll be sharpening some of the results you
obtained from your previous milestone by:

-   Manipulating special data types in R: factors and/or dates and
    times.
-   Fitting a model object to your data, and extract a result.
-   Reading and writing data as separate files.

**NOTE**: The main purpose of the mini data analysis is to integrate
what you learn in class in an analysis. Although each milestone provides
a framework for you to conduct your analysis, it’s possible that you
might find the instructions too rigid for your data set. If this is the
case, you may deviate from the instructions – just make sure you’re
demonstrating a wide range of tools and techniques taught in this class.

## Instructions

**To complete this milestone**, edit [this very `.Rmd`
file](https://raw.githubusercontent.com/UBC-STAT/stat545.stat.ubc.ca/master/content/mini-project/mini-project-3.Rmd)
directly. Fill in the sections that are tagged with
`<!--- start your work here--->`.

**To submit this milestone**, make sure to knit this `.Rmd` file to an
`.md` file by changing the YAML output settings from
`output: html_document` to `output: github_document`. Commit and push
all of your work to your mini-analysis GitHub repository, and tag a
release on GitHub. Then, submit a link to your tagged release on canvas.

**Points**: This milestone is worth 40 points (compared to the usual 30
points): 30 for your analysis, and 10 for your entire mini-analysis
GitHub repository. Details follow.

**Research Questions**: In Milestone 2, you chose two research questions
to focus on. Wherever realistic, your work in this milestone should
relate to these research questions whenever we ask for justification
behind your work. In the case that some tasks in this milestone don’t
align well with one of your research questions, feel free to discuss
your results in the context of a different research question.

# Setup

Begin by loading your data and the tidyverse package below:

``` r
library(datateachr) # <- might contain the data you picked!
library(tidyverse)
library(broom)
```

From Milestone 2, you chose two research questions. What were they? Put
them here.

<!-------------------------- Start your work below ---------------------------->

1.  Are `area_mean` and `symmetry_mean` both significant predictors of a
    malignant diagnosis?
2.  In benign tumours, are the differences of means between categories
    of `symmetry_mean` (low, medium, high) and `perimeter_mean`
    statistically significant?
    <!----------------------------------------------------------------------------->

# Exercise 1: Special Data Types (10)

For this exercise, you’ll be choosing two of the three tasks below –
both tasks that you choose are worth 5 points each.

But first, tasks 1 and 2 below ask you to modify a plot you made in a
previous milestone. The plot you choose should involve plotting across
at least three groups (whether by facetting, or using an aesthetic like
colour). Place this plot below (you’re allowed to modify the plot if
you’d like). If you don’t have such a plot, you’ll need to make one.
Place the code for your plot below.

<!-------------------------- Start your work below ---------------------------->

``` r
cancer_sample %>% #create categorical variable
  filter(diagnosis == "B") %>%
  mutate(category_symmetry = cut(symmetry_mean, 
                        breaks = 3,
                      labels = c("low","medium","high"))) %>%
  ggplot(aes(x = category_symmetry,
           y = perimeter_mean)) +
  geom_boxplot(aes(),
               alpha = 0.4) +
  geom_point(aes(colour = factor(diagnosis)),
             alpha = 0.2) +
  labs(x = "Symmetry Category", #add labels
       y = "Perimeter (Mean)", 
       caption = "Source: UCI, 1995") +
    scale_x_discrete(breaks = c("very low", "low","medium", "high", "very high"), #change x tick
                   labels = c("Very Low", "Low", "Medium", "High", "Very High")) + 
    scale_colour_discrete(limits = c("B"),
                          labels = c("Benign"),
                          name = "Diagnosis")
```

<img src="mda-mchester_m3_files/figure-gfm/symmetry plot-1.png" style="display: block; margin: auto;" />

Now, choose two of the following tasks.

1.  Produce a new plot that reorders a factor in your original plot,
    using the `forcats` package (3 points). Then, in a sentence or two,
    briefly explain why you chose this ordering (1 point here for
    demonstrating understanding of the reordering, and 1 point for
    demonstrating some justification for the reordering, which could be
    subtle or speculative.)

2.  Produce a new plot that groups some factor levels together into an
    “other” category (or something similar), using the `forcats` package
    (3 points). Then, in a sentence or two, briefly explain why you
    chose this grouping (1 point here for demonstrating understanding of
    the grouping, and 1 point for demonstrating some justification for
    the grouping, which could be subtle or speculative.)

3.  If your data has some sort of time-based column like a date (but
    something more granular than just a year):

    1.  Make a new column that uses a function from the `lubridate` or
        `tsibble` package to modify your original time-based column. (3
        points)
        -   Note that you might first have to *make* a time-based column
            using a function like `ymd()`, but this doesn’t count.
        -   Examples of something you might do here: extract the day of
            the year from a date, or extract the weekday, or let 24
            hours elapse on your dates.
    2.  Then, in a sentence or two, explain how your new column might be
        useful in exploring a research question. (1 point for
        demonstrating understanding of the function you used, and 1
        point for your justification, which could be subtle or
        speculative).
        -   For example, you could say something like “Investigating the
            day of the week might be insightful because penguins don’t
            work on weekends, and so may respond differently”.

<!-------------------------- Start your work below ---------------------------->

**Task Number**: 1

<!----------------------------------------------------------------------------->

``` r
cancer_sample %>% #create categorical variable
  filter(diagnosis == "B") %>%
  mutate(category_symmetry = cut(symmetry_mean, 
                        breaks = 3,
                      labels = c("low","medium","high"))) %>%
  mutate(category_symmetry = fct_relevel(category_symmetry, "high","medium", "low")) %>%
  ggplot(aes(x = category_symmetry,
           y = perimeter_mean)) +
  geom_boxplot(aes()) +
  geom_point(aes(colour = factor(diagnosis)),
             alpha = 0.2) +
  labs(x = "Symmetry Category", #add labels
       y = "Perimeter (Mean)", 
       caption = "Source: UCI, 1995") +
    scale_x_discrete(breaks = c("low","medium", "high"), #change x tick
                   labels = c("Low", "Medium", "High")) + 
    scale_colour_discrete(limits = c("B"),
                          labels = c("Benign"),
                          name = "Diagnosis")
```

<img src="mda-mchester_m3_files/figure-gfm/symmetry reordered-1.png" style="display: block; margin: auto;" />

The `symmetry_mean` categories were reordered to improve visualiztion
and are now based on highest `perimeter_mean`. Interestingly, the
boxplot now displays that “low” symmetry values produce the highest
`perimeter_mean` values in benign tumours, on average. With greater
sample size, an interesting follow up question here would be whether
highly symmetrical tumours with lower perimeter means are more likely to
be malignant.

<!-------------------------- Start your work below ---------------------------->

**Task Number**: 2

``` r
cancer_sample %>% #create categorical variable
  filter(diagnosis == "B") %>%
  mutate(category_symmetry = cut(symmetry_mean, 
                        breaks = 3,
                      labels = c("low","medium","high"))) %>%
  mutate(category_symmetry = fct_relevel(category_symmetry, "high","low", "medium")) %>%
  mutate(category_symmetry = fct_collapse(category_symmetry, other = c("high", "medium"))) %>%
  ggplot(aes(x = category_symmetry,
           y = perimeter_mean)) +
  geom_boxplot(aes()) +
  geom_point(aes(colour = factor(diagnosis)),
             alpha = 0.2) +
  labs(x = "Symmetry Category", #add labels
       y = "Perimeter (Mean)", 
       caption = "Source: UCI, 1995") +
    scale_x_discrete(breaks = c("low","medium", "high", "other"), #change x tick
                   labels = c("Low", "Medium", "High", "Other")) + 
    scale_colour_discrete(limits = c("B"),
                          labels = c("Benign"),
                          name = "Diagnosis")
```

<img src="mda-mchester_m3_files/figure-gfm/symmetry other-1.png" style="display: block; margin: auto;" />
The “high” and “medium” `symmetry_mean` categories have now been grouped
together to compare to the “low” category. With these combined, the
difference between group means appears insignificant. Again, an
interesting follow up question here would be whether or not this pattern
holds true for malignant diagnoses.

<!----------------------------------------------------------------------------->

# Exercise 2: Modelling

## 2.0 (no points)

Pick a research question, and pick a variable of interest (we’ll call it
“Y”) that’s relevant to the research question. Indicate these.

<!-------------------------- Start your work below ---------------------------->

**Research Question**: Is `area_mean` a significant predictor of a
malignant diagnosis?

**Variable of interest**: `area_mean`

<!----------------------------------------------------------------------------->

## 2.1 (5 points)

Fit a model or run a hypothesis test that provides insight on this
variable with respect to the research question. Store the model object
as a variable, and print its output to screen. We’ll omit having to
justify your choice, because we don’t expect you to know about model
specifics in STAT 545.

-   **Note**: It’s OK if you don’t know how these models/tests work.
    Here are some examples of things you can do here, but the sky’s the
    limit.
    -   You could fit a model that makes predictions on Y using another
        variable, by using the `lm()` function.
    -   You could test whether the mean of Y equals 0 using `t.test()`,
        or maybe the mean across two groups are different using
        `t.test()`, or maybe the mean across multiple groups are
        different using `anova()` (you may have to pivot your data for
        the latter two).
    -   You could use `lm()` to test for significance of regression.

<!-------------------------- Start your work below ---------------------------->

``` r
cancer_sample %>%
  ggplot(aes(diagnosis, area_mean)) +
  geom_boxplot() #quickly visualize relationship
```

<img src="mda-mchester_m3_files/figure-gfm/correlation area_mean and diagnosis-1.png" style="display: block; margin: auto;" />

``` r
summary(lm(area_mean ~ diagnosis, data = cancer_sample)) #test area mean
```

    ## 
    ## Call:
    ## lm(formula = area_mean ~ diagnosis, data = cancer_sample)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -616.78 -141.99  -12.89  113.62 1522.62 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   462.79      13.15   35.20   <2e-16 ***
    ## diagnosisM    515.59      21.54   23.94   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 248.4 on 567 degrees of freedom
    ## Multiple R-squared:  0.5027, Adjusted R-squared:  0.5018 
    ## F-statistic: 573.1 on 1 and 567 DF,  p-value: < 2.2e-16

``` r
t.test(area_mean ~ diagnosis, data = cancer_sample)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  area_mean by diagnosis
    ## t = -19.641, df = 244.79, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -567.2919 -463.8805
    ## sample estimates:
    ## mean in group B mean in group M 
    ##        462.7902        978.3764

Therefore, with a t-value greater than 2 and a p-value less than 0.05,
the difference in `area_mean` by diagnosis is significant

<!----------------------------------------------------------------------------->

## 2.2 (5 points)

Produce something relevant from your fitted model: either predictions on
Y, or a single value like a regression coefficient or a p-value.

-   Be sure to indicate in writing what you chose to produce.
-   Your code should either output a tibble (in which case you should
    indicate the column that contains the thing you’re looking for), or
    the thing you’re looking for itself.
-   Obtain your results using the `broom` package if possible. If your
    model is not compatible with the broom function you’re needing, then
    you can obtain your results by some other means, but first indicate
    which broom function is not compatible.

<!-------------------------- Start your work below ---------------------------->

I have decided to use the `broom` package to eloquently display t-values
for the differences of means. These values can be found in the
“statistic” column. The corresponding p-values are displayed in the
“p.value” column.

``` r
broom::tidy(lm(area_mean ~ diagnosis, data = cancer_sample))
```

    ## # A tibble: 2 × 5
    ##   term        estimate std.error statistic   p.value
    ##   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
    ## 1 (Intercept)     463.      13.1      35.2 8.99e-145
    ## 2 diagnosisM      516.      21.5      23.9 4.73e- 88

I have also decided to use the `broom` package to make predictions on
`area_mean` based on diagnosis. An interesting future question could
look at prediction models based on a greater number of variables.

``` r
augment(lm(area_mean ~ diagnosis, data = cancer_sample))
```

    ## # A tibble: 569 × 8
    ##    area_mean diagnosis .fitted .resid    .hat .sigma   .cooksd .std.resid
    ##        <dbl> <chr>       <dbl>  <dbl>   <dbl>  <dbl>     <dbl>      <dbl>
    ##  1     1001  M            978.   22.6 0.00472   249. 0.0000198     0.0913
    ##  2     1326  M            978.  348.  0.00472   248. 0.00466       1.40  
    ##  3     1203  M            978.  225.  0.00472   248. 0.00195       0.906 
    ##  4      386. M            978. -592.  0.00472   247. 0.0135       -2.39  
    ##  5     1297  M            978.  319.  0.00472   248. 0.00392       1.29  
    ##  6      477. M            978. -501.  0.00472   248. 0.00970      -2.02  
    ##  7     1040  M            978.   61.6 0.00472   249. 0.000147      0.249 
    ##  8      578. M            978. -400.  0.00472   248. 0.00619      -1.62  
    ##  9      520. M            978. -459.  0.00472   248. 0.00811      -1.85  
    ## 10      476. M            978. -502.  0.00472   248. 0.00974      -2.03  
    ## # … with 559 more rows

<!----------------------------------------------------------------------------->

# Exercise 3: Reading and writing data

Get set up for this exercise by making a folder called `output` in the
top level of your project folder / repository. You’ll be saving things
there.

## 3.1 (5 points)

Take a summary table that you made from Milestone 2 (Exercise 1.2), and
write it as a csv file in your `output` folder. Use the `here::here()`
function.

-   **Robustness criteria**: You should be able to move your Mini
    Project repository / project folder to some other location on your
    computer, or move this very Rmd file to another location within your
    project repository / folder, and your code should still work.
-   **Reproducibility criteria**: You should be able to delete the csv
    file, and remake it simply by knitting this Rmd file.

<!-------------------------- Start your work below ---------------------------->

``` r
area_table <- tibble(cancer_sample) %>% #make new tibble to find mean by category
  select(diagnosis, area_mean) %>% #select area mean
  group_by(diagnosis) %>% #group by diagnoses
  summarise(across(where(is.numeric), mean)) #find mean
```

``` r
here::here()
```

    ## [1] "/Users/claytonchester/Desktop/UBC/STAT 545A/Mini Data Analysis/mda-mchester"

``` r
dir.create(here::here("output"))
```

    ## Warning in dir.create(here::here("output")): '/Users/claytonchester/Desktop/UBC/
    ## STAT 545A/Mini Data Analysis/mda-mchester/output' already exists

``` r
write_csv(area_table, here::here("output", "area_table.csv"))
```

<!----------------------------------------------------------------------------->

## 3.2 (5 points)

Write your model object from Exercise 2 to an R binary file (an RDS),
and load it again. Be sure to save the binary file in your `output`
folder. Use the functions `saveRDS()` and `readRDS()`.

-   The same robustness and reproducibility criteria as in 3.1 apply
    here.

<!-------------------------- Start your work below ---------------------------->

``` r
fit <- lm(area_mean ~ diagnosis, data = cancer_sample)
saveRDS(fit, here::here("output", "model.rds"))
```

``` r
readRDS(here::here("output", "model.rds"))
```

    ## 
    ## Call:
    ## lm(formula = area_mean ~ diagnosis, data = cancer_sample)
    ## 
    ## Coefficients:
    ## (Intercept)   diagnosisM  
    ##       462.8        515.6

<!----------------------------------------------------------------------------->

# Tidy Repository

Now that this is your last milestone, your entire project repository
should be organized. Here are the criteria we’re looking for.

## Main README (3 points)

There should be a file named `README.md` at the top level of your
repository. Its contents should automatically appear when you visit the
repository on GitHub.

Minimum contents of the README file:

-   In a sentence or two, explains what this repository is, so that
    future-you or someone else stumbling on your repository can be
    oriented to the repository.
-   In a sentence or two (or more??), briefly explains how to engage
    with the repository. You can assume the person reading knows the
    material from STAT 545A. Basically, if a visitor to your repository
    wants to explore your project, what should they know?

Once you get in the habit of making README files, and seeing more README
files in other projects, you’ll wonder how you ever got by without them!
They are tremendously helpful.

## File and Folder structure (3 points)

You should have at least four folders in the top level of your
repository: one for each milestone, and one output folder. If there are
any other folders, these are explained in the main README.

Each milestone document is contained in its respective folder, and
nowhere else.

Every level-1 folder (that is, the ones stored in the top level, like
“Milestone1” and “output”) has a `README` file, explaining in a sentence
or two what is in the folder, in plain language (it’s enough to say
something like “This folder contains the source for Milestone 1”).

## Output (2 points)

All output is recent and relevant:

-   All Rmd files have been `knit`ted to their output, and all data
    files saved from Exercise 3 above appear in the `output` folder.
-   All of these output files are up-to-date – that is, they haven’t
    fallen behind after the source (Rmd) files have been updated.
-   There should be no relic output files. For example, if you were
    knitting an Rmd to html, but then changed the output to be only a
    markdown file, then the html file is a relic and should be deleted.

Our recommendation: delete all output files, and re-knit each
milestone’s Rmd file, so that everything is up to date and relevant.

PS: there’s a way where you can run all project code using a single
command, instead of clicking “knit” three times. More on this in STAT
545B!

## Error-free code (1 point)

This Milestone 3 document knits error-free. (We’ve already graded this
aspect for Milestone 1 and 2)

## Tagged release (1 point)

You’ve tagged a release for Milestone 3. (We’ve already graded this
aspect for Milestone 1 and 2)
