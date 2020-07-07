# Session 2/1: reading in tidyverse

 1. Which package from tidyverse allows you to read Excel files? 

 3. The function `readxl_example("deaths.xls")` returns a file name. Read
    this file. How can you omit the lines at the top and at the bottom of
    the file?  (hint: `?read_xls`). How can you force the date columns to
    be interpreted as dates and not numbers?
 
 2. Read the World Inequality Database file
    ([WIID_19Dec2018.xlsx](../../Data/WIID_19Dec2018.xlsx)). This is a
    spreadsheet containing worlid income inequality data.

 2. Read the Excel sheet into R. How can you find out how many sheets are
    in the file (without opening it in Excel, of course!).

 2. Examine the tibble produced by the `read_...` function. `q1..q5` are the
    quantiles and `d1..d10` are the deciles. I.e., `q1` equal to 9 means
    that the lower income 20% of the population owns 9% of the overall
    wealth. The Gini coefficient ranges from 0 (perfect equality) to 100%
    (perfect inequality).



# Session 2/2: pipes

 3. Which countries have the highest / lowest Gini coefficient? Which
    countries had the highest / lowest Gini coefficient in 2016? Where is
    Germany on that scale?

 2. With the world inequality data base, try the following:

     * select only rows corresponding to the XXIst century
     * select only rows corresponding to the XXIst century *and* Europe
     * select only columns corresponding to quantiles and countries. Rename
       the quantiles to use uppercase
     * *reasonably* remove all incomplete rows (use `drop_na`)
     * summarize data by continent and by country

# Session 2/3: advanced tidyverse

 2. Using tidyverse, read, inspect and correct (if reasonable) the following files:

    * [cars.xlsx](../../Data/cars.xlsx)
    * [iris.csv](../../Data/iris.csv)

 2. Construct a tidyverse pipe with the following steps:

     1. Select only entries from 2016
     2. Remove duplicate entries for each country (you can use the
        `duplicated` function for that)
     3. Select the columns id, country and the quantile columns
     4. Use the `gather` function to create a long version of the table 
     5. Remove rows containing NA's using the `drop_na` function
     6. Send me your code by e-mail.

 3. Using `group_by`, `summary` and `arrange` find out for which year there
    are the most data? For which year the overall average gini coefficient
    is highest / lowest? (mind the NA's!). Plot the average Gini
    coefficient over time.

# Session 2/4: wide vs long

 1. Convert the following files to long format:

    * `iris.csv`
    * `mtcars_wide.csv`
    * `labresults_wide.csv`
    * `cars.xlsx` (tricky!)

 3. Load the world energy use data (`world_energy.tsv`). Change it from
    wide to long format.

 4. Using built-in data sets from `tidyr`, `table{1,2,3,4a,4b,5}` convert
    them from wide to long and viceversa. Use `separate` on `table5` to
    change `rate` into `cases` and `population`.
