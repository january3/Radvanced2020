# Session 4/1

 1. Using the WIID data set, reproduce the example from lecture for another
    selection of years / regions (maybe not for countries, but for regions
    or subregions?) Can you think of another representation?
 2. Using the mtcars data set and any graphics system, create a box plot 
    showing mpg depending on the number of cylinders (cyl). The latter
    should be treated as a category, not a continuous variable! (in ggplot:
    use the `geom_boxplot()` geom).
 3. Load the [transcriptomics_results.csv](https://raw.githubusercontent.com/january3/Radvanced2020/master/Data/transcriptomics_results.csv) data set. 
    This is a data set derived from
    [this](https://www.nature.com/articles/s41598-019-56994-8) paper,
    showing transcriptomic responses to the vaccination at different
    timepoints. Using whatever tools (base R, `ggplot() + geom_point()`)
    plot the log fold changes on day 1 vs log fold changes on day 2. 
 4. Create an additional column to the transcriptomic data set. Fill it with
    either "TRUE" (a gene is significant on day 1) or "FALSE" (a gene is not
    significant). Define significance in terms of log fold change *and*
    p-value (i.e., a gene is significant if the absolute lfc is above a
    threshold *and* p-value is below a threshold).
 5. Create a volcano plot (i.e., log fold change on x axis, -log10(p-value)
    on y axis) showing in red genes which are significant on day 1. (for
    example, with ggplot2, use the color esthetics with the "sign" column
    you created in the previous step)
 6. Using a similar approach, color (or symbol) code genes which are:
     * not significant on Day 1 *and* Day 2
     * significant only on Day 1
     * significant only on Day 2
     * significant on both days

# Session 4/2

 1. Repeat first two exercises from 4/1 using different color schemes.
 2. Use a gradient color scale to represent fold changes on the
    transcriptomic data plot.
 3. A "disco score" has been defined (Domaszewska et al.) to combine
    information from two log fold changes and two p-values:

    <img
    src="https://render.githubusercontent.com/render/math?math=D_{\textrm{score}}=LFC_1\cdot LFC_2\cdot(|\log_10(q_1)| + |\log_10(q_2)|)">

    Calculate the disco score for Day 1 / Day 2 in the transcriptomic
    results table.
 4. Plot the log fold changes on day 1 vs log fold changes on day 2 and
    color them by the disco score

# Session 4/3 (optional, send me the e-mail with the results)

 1. Create an alternative "summary" function for a data frame, such that if
    I type "summary(mtcars)" I will see the result of that function.
 2. Create a new class: sets. Define print and summary functions for this
    class.
 3. Use `+.sets` and `-.sets` etc. to define set operations on the set
    class.

# Session 4/4

 1. The data set [expression_data_vaccination_example.xlsx](https://raw.githubusercontent.com/january3/Radvanced2020/master/Data/expression_data_vaccination_example.xlsx) 
    (large file!) contains raw data (microarray log signals) of gene expression in human
    subjects who were vaccinated with an influenza vaccine on day 0. The
    excel file contains numerous sheets; figure out what they are (one of
    them is the expression matrix containing the actual data). Use
    padjust to correct the p-values for multiple testing.
 2. Using t.test and lapply (or map), find the genes with the largest
    significant differences on day 1. Hint: for a gene in row 1 of the
    expression matrix, you need to figure out which samples are from day 0,
    which are from day 1, and then run `t.test(expr[1, day0], expr[1, day1])`.
    Another hint: t.test returns a list. One of the elements of that list
    is a p.value.
 3. Use a beeswarm (beeswarm package for base R, ggbeeswarm with the
    `geom_beeswarm` for the ggplot2) representation to show the differences
    between day 0 and day 1 for the genes with the lowest p-value.
