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

 * Write a function which

    1. Adds two numbers, but checks that the arguments are numeric 
    2. returns a random number. It takes two parameters: number of random
       values to generate and the type of distribution (which should be:
       normal, uniform, binomial: take a look at `rnorm`, `runif`, `rbinom`).
    3. takes a vector of p-values and returns the smallest p-value (but
       keep in mind that some values might be NA's!)

```r
## expected: 22
add_two(5, 17)

## expected: 15 random numbers
get_a_random(15, "uniform")

## expected: 1e-4
min_pval(c(0.05, 0.0001, NA, 1e-3))
```
 
# Session 2: R as functional language

 * Define your own operators for all set operations. When do you use the
    back ticks (`` ` ``)? Set operations: `setdiff`, `union`, `intersect`,
    `setequal`

# Session 3: floating number operators

 * Create operators which can serve as replacement for `==`, `>` etc. for
    floating numbers. (e.g. %==% should be a function taking two arguments
    to compare)

