# Session 2/1: reading in tidyverse

 1. Which package from tidyverse allows you to read Excel files? 

    **readxl**

 3. The function `readxl_example("deaths.xls")` returns a file name. Read
    this file. How can you omit the lines at the top and at the bottom of
    the file?  (hint: `?read_xls`). How can you force the date columns to
    be interpreted as dates and not numbers?

```r
library(readxl)
deaths <- read_excel(readxl_example("deaths.xls"), skip=4, n_max=10)
```
 
 2. Read the World Inequality Database file
    ([WIID_19Dec2018.xlsx](../Data/WIID_19Dec2018.xlsx)). This is a
    spreadsheet containing worlid income inequality data.

```r
wiid <- read_excel("WIID_19Dec2018.xlsx")
```

 2. Read the Excel sheet into R. How can you find out how many sheets are
    in the file (without opening it in Excel, of course!).

```r
excel_sheets("WIID_19Dec2018.xlsx")
```

 2. Examine the tibble produced by the `read_...` function. `q1..q5` are the
    quantiles and `d1..d10` are the deciles. I.e., `q1` equal to 9 means
    that the lower income 20% of the population owns 9% of the overall
    wealth. The Gini coefficient ranges from 0 (perfect equality) to 100%
    (perfect inequality).



# Session 2/2: pipes

 3. Which countries have the highest / lowest Gini coefficient? Which
    countries had the highest / lowest Gini coefficient in 2016? Where is
    Germany on that scale?

```r
wiid %>% arrange(gini_reported)
wiid %>% arrange(desc(gini_reported)) 
## or, shorter
wiid %>% arrange(-gini_reported)
wiid %>% arrange(desc(gini_reported)) %>% mutate(pos=1:n()) %>%
  filter(country == "Germany") %>% select(country, gini_reported, pos)
```

 2. With the world inequality data base, try the following:

     * select only rows corresponding to the XXIst century

```r
wiid %>% filter(year > 2000) # 2000 is still in the XX century!
```

     * select only rows corresponding to the XXIst century *and* Europe

```r
wiid %>% filter(year > 2000, region_un == "Europe")
## or
wiid %>% filter(year > 2000 & region_un == "Europe")
```

     * select only columns corresponding to quantiles and countries. Rename
       the quantiles to use uppercase
```r
## note: since we have selected only these 6 columns, we don't need to
## worry about anything else containing a "q"...
wiid %>% select(country, q1:q5) %>% rename_all(~ gsub("q", "Q", .))
## or, easier
colnames(wiid) <- gsub("q", "Q", colnames(wiid))

## but if we didn't, here is what we can do
wiid %>% rename_at(vars(q1:q5), toupper)
```

     * *reasonably* remove all incomplete rows (use `drop_na`)

```r
## What is "reasonably"? Well, a lot of data is missing from several
## columns:
wiid %>% summarise_all(~ sum(is.na(.))) %>% print(width=Inf)

## so, what information is important to us? I would say gini_reported,
## quantiles and deciles
wiid %>% drop_na(gini_reported, q1:d10)
```

     * summarize data by continent and by country
```r
wiid %>% group_by(country) %>% summarise(mean_GI=mean(gini_reported, na.rm=TRUE))

## who said it was supposed to be the mean?
wiid %>% group_by(region_un) %>% summarise(mean_GI=median(gini_reported, na.rm=TRUE))

## we can, of course, summarise all the "important" stats
wiid %>% group_by(region_un) %>% 
  summarise_at(vars(gini_reported, q1:q5), ~ median(., na.rm=TRUE))
```


# Session 2/3: advanced tidyverse

 2. Using tidyverse, read, inspect and correct (if reasonable) the following files:

    * [cars.xlsx](../Data/cars.xlsx)
    * [iris.csv](../Data/iris.csv)


```r
iris <- read_csv("iris.csv")
colnames(iris)[1] <- "ID"

## this is the problem here:
unique(iris$Species)
iris$Species <- tolower(iris$Species)
colnames(iris) <- gsub("al.", "al_", colnames(iris))
```

 2. Construct a tidyverse pipe with the following steps:

     1. Select only entries from 2016
     2. Remove duplicate entries for each country (you can use the
        `duplicated` function for that)
     3. Select the columns id, country and the quantile columns
     4. Use the `gather` function to create a long version of the table 
     5. Remove rows containing NA's using the `drop_na` function
     6. Send me your code by e-mail.

```r
wiid <- read_excel("WIID_19Dec2018.xlsx")
wiid %>% filter(year == 2016) %>% filter(!duplicated(country)) %>%
  select(id, country, q1:q5) %>% 
  gather(key="quantile", value="value", q1:q5) %>%
  drop_na() %>% arrange(country)
```

 3. Using `group_by`, `summary` and `arrange` find out for which year there
    are the most data? For which year the overall average gini coefficient
    is highest / lowest? (mind the NA's!). Plot the average Gini
    coefficient over time.

```r
wiid_byyear <- wiid %>% group_by(year) %>% 
  summarize(n=n(), mean_GI=mean(gini_reported, na.rm=TRUE))
wiid_byyear %>% arrange(-n)
## the following is easier in base R:
wiid_byyear[ which.max(wiid_byyear$mean_GI), ]
wiid_byyear[ which.min(wiid_byyear$mean_GI), ]

## otherwise:
wiid_byyear %>% filter(1:n() == which.max(mean_GI))
wiid_byyear %>% filter(1:n() == which.min(mean_GI))
```

# Session 2/4: wide vs long

 1. Convert the following files to long format:

    * `iris.csv`

```r
iris_long <- iris %>% 
  gather(key="parameter", value="measurement", Sepal_Length:Petal_Width)
```

    * `mtcars_wide.csv`

```r
mtcars_w <- read_csv("mtcars_wide.csv")
mtcars_l <- mtcars_w %>% gather(key="parameter", value="value", mpg:carb)
```

    * `labresults_wide.csv`

```r
lab_w <- read_csv("labresults_wide.csv")
lab_w %>% gather(key="parameter", value="value", LBORRES.ACA:LBORRES.WBC)
```

    * `cars.xlsx` (tricky!)

```r
## the tricky part is that we need to create an ID column
cars <- read_excel("cars.xlsx")
cars %>% mutate(ID=1:n()) %>% 
  gather(key="key", value="val", c(speed, dist)) %>%
  arrange(ID)
```

 3. Load the world energy use data (`world_energy.tsv`). Change it from
    wide to long format.

```r
world <- read_tsv("world_energy.tsv")
world %>% gather(key="Energy source", value="Percentage", Oil:Nuclear)
```

 4. Using built-in data sets from `tidyr`, `table{1,2,3,4a,4b,5}` convert
    them from wide to long and viceversa. Use `separate` on `table5` to
    change `rate` into `cases` and `population`.

```r
table5 %>% separate(rate, sep="/", into=c("infected", "population"))
```
