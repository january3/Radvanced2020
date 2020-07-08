# Session 3/1

 1. Use `lapply` to find out what is the type of each column in `starwars`
    (use the function `class` for that).

 2. Create a list where elements are vectors with 2, ... 100 random
    normally distributed numbers.  Then, for each element of the list,
    calculate the mean, median, interquartile range and standard deviation.
    What do you observe? (interquartile range: function IQR).

 3. Using the mtcars data set, `lapply` and `tapply`, calculate the mean
    and sd of all the parameters. How can you do it with summarise?

# Session 3/2

 1. Use the map family of functions to repeat exercises 3/1.1-3

 2. Using a map2 variant, for each person in the starwars tibble create a
    string "Name comes from Planet", where Name corresponds to the name
    column and Planet corresponds to the homeworld. Can you think of a
    (much) simpler way of doing the same?

 3. Using a map variant, find out the average height of starwars characters
    with different eye color.

# Session 3/3

 1. What strings will the following regexps match, what will they not
     match (examples)

       * `^Arz*b?$`
       * `Und[Dd]ead`
       * `Wa?rni?ng`
       * `BF[^A:H][0-9]*`

 2. Same as before (but harder)

       * `G[:alnum:]*d O[:lower:]*n`
       * `Janie's got a (pony|gun)`

 3. What regular expression can you use to match all of the following:

       * "Fickle", "Tickle", "Prickle"
       * "Tick", "Trick" und "Track"
       * a telephone number in Germany
       * a URL
       * human ENSEMBL identifiers

# Session 3/4

 4. Load and sanitize the data from "samples.xlsx". Convert them to a
    long format. Use common sense.

 5. The data in "samples.xlsx" contain microarray identifiers which correspond to file
    names with primary microarray readouts. The file "targets.tsv"
    contains the primary readout file names you have received from the
    core transcriptomic facility, but unfortunately it is not entirely
    clear to which samples they correspond. Also, they are not in the
    same order. Also, there are more files than samples. Find a reasonable matching.
    Hint: use the `match` function from base R.

 6. From the starwars data, create a list in which each element is a
    character vector with starships and the names of the list are the
    names of the characters (so for example `mylist[["Darth Vader"]]`
    is a character vector of length 1 containing "TIE Advanced x1").
    Remove all elements with no starships.

 7. In starwars data frame, change each two part name into a "last name,
    first name" format (for example "Skywalker, Luke")
