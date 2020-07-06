# Session 1: Writing and documenting functions

 * Write a function for reading and checking an input file. Here is what
   the function is supposed to do:

    * take as argument the name of the file;
    * test whether the file exists, throw an error if it does not (you can
      use `try`, you can use `stop`...)
    * test whether the columns contain NA's (and how many), warn if there
      are any NAs in the ID column
    * test whether the file really has two columns
    * test whether IDs are unique and values numeric
    * return a data frame containing two columns (ID's and numbers)
    
 * Document your function as best as you can. You can use
   [roxygen2](https://kbroman.org/pkg_primer/pages/docs.html) to make the
   documentation consistent.
 
# Session 2: R as functional language

 * Define your own operators for all set operations. When do you use the
    back ticks (`` ` ``)? Set operations: `setdiff`, `union`, `intersect`,
    `setequal`

# Session 3: floating number operators

 * Create operators which can serve as replacement for `==`, `>` etc. for
    floating numbers. (e.g. %==% should be a function taking two arguments
    to compare)

# Session 4: tidyverse

 1. Which package from tidyverse allows you to read Excel files? Read the
    World Inequality Database file. 

 2. With the world inequality data base, try the following:

     * what columns are there? Which are "interesting"? (look up the PDF
       document)
     * select only rows corresponding to the XXIst century
     * select only rows corresponding to the XXIst century *and* Europe
     * select only columns corresponding to quantiles and countries. Rename
       the quantiles to use uppercase
     * *reasonably* remove all incomplete rows (use `drop_na`)
     * summarize data by continent and by country

  3. Load the world energy use data (`world_energy.tsv`). Change it from
     wide to long format.

  4. Using built-in data sets from `tidyr`, `table{1,2,3,4a,4b,5}` convert
     them from wide to long and viceversa. Use `separate` on `table5` to
     change `rate` into `cases` and `population`.

  5. Create a new markdown document in RStudio. The template contains
     already a few examples. Generate PDF and docx; create a header, a list,
     insert your own code fragment.
