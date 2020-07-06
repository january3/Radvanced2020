---
title: "Advanced R:\nTidyverse"
author: "January Weiner"
date: "`r Sys.Date()`"
output:
  ioslides_presentation:
    widescreen: true
    smaller: true
    css: "../files/style.css"
---


# My god, it's full of packages

## Tidyverse overview

![](01_tidyverse_data_science.png){width=380px}

## Simple demonstration

(Demo)

## How to use tidyverse

 * load with `library(tidyverse)`
 * some packages (e.g. `magrittr`) need to be loaded separately
 * never load `plyr` after `dplyr`

## Importantest packages

 * dplyr: data frame manipulation
 * magrittr: pipes (`%>%`)
 * purrr: vectorization (map et co.)
 * tibble: replacement for data.frame
 * readr: reading and writing data
 * tidyr: cleaning and managing data

## Other concepts and packages

 * ggplot2: the tidyverse way of plotting
 * (r)markdown / knitr: clean documentation

# tibble

## So many ways to skin a cat

data.frame has so many problems. Luckily, there are also so many solutions.

 * data.table / DT
 * DataFrame
 * tibble (tidyverse, formerly known as data\_frame)
 * special objects (ExpressionSet etc.)

## What is special about tibble

 * Hadley Wickham hates row names
 * tbl[,3] returns a tbl rather than a vector
 * nicer printing
 * extra properties (`group_by` etc.)

(Demo)

## Fine, but...

If you want to view more than the default portion of the tibble, do

    print(starwars, n=Inf, width=Inf)

Row names: convert them to a column, use filter() instead of `[`

## Reading data with readr

 * read\_{tsv,csv,...}, write…
 * better, cleaner, faster
 * explicit
 * will never turn a string into a factor


# Magrittr

## Ceci n'est pas une pipe

Magrittr defines a number of aliases – and of course the pipe operator,
`%>%`.
However, there is more to this package.

 * aliases (extract, set\_names etc.)
 * `%$%` operator (pipe version of `attach`)

![](figures/pipe.jpeg)

(Demo)

# dplyr

## dplyr: managing data

 * select, mutate, filter, rename, pull, arrange
 * distinct, sample\_{n,frac}, add\_count, add\_tally
 * summarise, \_at, \_if
 * group\_by

(Demo)

## select

Select columns from data:

    mtcars %>% select(mpg)
    mtcars %>% select(mpg, Cylinder=cyl)
    mtcars %>% select(starts_with("d"))

## mutate

Create new columns

    mtcars %>% mutate(lp100km=282.5/mpg)

## filter

Select rows from the data

    mtcars %>% filter(hp > 100)
    mtcars %>% filter(hp > 100 & cyl < 8)

## pull

Get a single column as a vector

    mtcars %>% pull(mpg)

## arrange

Sort the rows of the data 

    mtcars %>% arrange(mpg)

# tidyr

## Long vs wide data

 `gather()`, `spread()`

(Demo)

## group\_by

Essentially, add information to the tibble that the data is grouped by a
variable. This does not change the actual data!

    identical(table2, table2 %>% group_by(country))
    identical(as.data.frame(table2), 
              as.data.frame(table2 %>% group_by(country)))

You can then use several other functions.

(Demo)


## Use with caution!

While tidyverse is great for interactive work, you should use it with
caution in your packages:

    foo <- function(df) {
      cols <- c("sex", "age")
      df %<>% select(cols)

      # ... do something

      return(df)
    } 

What happens when df contains `cols`?

(Demo)

## Solution

Be wary of tidyverse shortcuts. Always assume the worst case scenario and
be explicit in your code:

    # make sure you select columns from variable 
    # and not by name
    df %<>% select(!!cols)



