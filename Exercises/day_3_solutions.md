# Session 3/1

 1. Use `lapply` to find out what is the type of each column in `starwars`
    (use the function `class` for that).

```r
lapply(starwars, class)
```

 2. Create a list where elements are vectors with 2, 3, 4, ..., 100 random
    normally distributed numbers.  Then, for each element of the list,
    calculate the mean, median, interquartile range and standard deviation.
    What do you observe? (interquartile range: function IQR).

```r
rnum <- lapply(2:100, rnorm)
res  <- sapply(rnum, function(x) c(mean(x), median(x), IQR(x), sd(x)))
```

    The variability decreases with increasing sample size.

 3. Using the mtcars data set, `lapply` and `tapply`, calculate the mean
    and sd of all the parameters. How can you do it with summarise?

```r
cyl <- mtcars$cyl
means <- lapply(mtcars[, -2], function(x) tapply(x, cyl, mean))
sds <- lapply(mtcars[, -2], function(x) tapply(x, cyl, sd))
mtcars %>% group_by(cyl) %>% summarise_all(list(mean, sd))
```

# Session 3/2

 1. Use the map family of functions to repeat exercises 3/1.1-3

```r
map(starwars, class)
rnum <- map(2:100, rnorm)
res <- map_dfr(rnum, ~ data.frame(mean=mean(.), median=median(.), iqr=IQR(.), sd=sd(.)))
```

 2. Using a map2 variant, for each person in the starwars tibble create a
    string "Name comes from Planet", where Name corresponds to the name
    column and Planet corresponds to the homeworld. Can you think of a
    (much) simpler way of doing the same?

```r
map2_chr(starwars$name, starwars$homeworld, ~ sprintf("%s comes from %s", .x, .y))
paste(starwars$name, "comes from", starwars$homeworld)
```

 3. Using a map variant, find out the average height of starwars characters
    with different eye color.

```r
eye_cols <- starwars$eye_color
height <- starwars$height
cols <- unique(eye_cols) 
names(cols) <- cols
av_h <- map_dbl(cols, ~ {
  sel <- eye_cols == .
  mean(height[sel], na.rm=TRUE)
})

```

# Session 3/3

 1. What strings will the following regexps match, what will they not
     match (examples)

       * `^Arz*b?$`: matches `Arbbbb`, `Arzzzzz`, `Arzzbb`; does not match: `rzzb`, `bArzb`, `Arzzbb`
       * `Und[Dd]ead`: matches `UndDead`, `Unddead`; does not match: `Undead`
       * `Wa?rni?ng`: matches `Wrnng`, `Warning`, `Warnng`; does not match: `Waarniing`
       * `BF[^A:H][0-9]*`: matches `BFG9000`, `BFG`, `BFH123`; does not match `BF9000`, `BFZ9000`

 2. Same as before (but harder)

       * `G[[:alnum:]]*d O[[:lower:]]*n`: matches `Good Omen`, `G4ooo2d On`, `Gd On`; does not match: `G----d Omen`, `Good OMEN`

    Note: a mistake here! Not: `[:lower:]`, but `[[:lower:]]`

       * `Janie's got a (pony|gun)`: matches `Janie's got a pony`, `Janie's got a gun`; does not match: `Janie's got a ponygun`

 3. What regular expression can you use to match all of the following:

       * "Fickle", "Tickle", "Prickle": `[FTP]r?ickle`, `(F|T|Pr)ickle`, `[[:upper:]]r?ickle`
       * "Tick", "Trick" und "Track": `Tr?[ia]ck`
       * a telephone number in Germany: `(00 ?49|\\+49|)[ -]?[0-9 -]{6,}`
       * a URL: `(https?|ftp)://[a-zA-Z_-]+[a-zA-Z_-.]*[a-zA-Z]{2,4}(|/|[/a-zA-Z_.?+&]*)` (note: it is not possible to get a *perfect* URL regex...)
       * human ENSEMBL identifiers: `ENS[GT][0-9]{11}(.[0-9]+)`

# Session 3/4

 4. Load and sanitize the data from "samples.xlsx". Convert them to a
    long format. Use common sense.

```r
samps <- read_excel("Data/samples.xlsx")
hours <- c(0, 1, 12, 24, 24 * 7)
## %03d placeholder means "fill the number with zeroes such that it is 3
## characters wide"
colnames(samps) <- c("PersonID", "Sex", "Age", "Cells", sprintf("TP.%03d", hours))
samps <- samps %>% 
  mutate(Cells=gsub("monocytes", "Monocytes", Cells)) %>%
  mutate(PersonID=gsub(",,", NA, PersonID)) %>%
  mutate(PersonID=gsub("[^[:alnum:]]+", "", PersonID)) %>%
  mutate(PersonID=gsub("SPC", "SPC_", PersonID)) %>%
  mutate(Sex=toupper(gsub("^(.).*", "\\1", Sex))) %>%
  mutate(Age=gsub("^\\?.*", "-99", Age)) %>%
  mutate(Age=as.numeric(gsub("^([0-9]+).*", "\\1", Age))) %>%
  fill(PersonID:Age) %>%
  mutate(Age=ifelse(Age < 0, NA, Age)) %>%
  gather(key="TP", value="ID", TP.000:TP.168)
```

Notes: `fill()` is the function to fill missing values. We use `-99` to
denote the missing age, because otherwise `fill()` would fill it up with the
value above.

 5. The data in "samples.xlsx" contain microarray identifiers which correspond to file
    names with primary microarray readouts. The file "targets.tsv"
    contains the primary readout file names you have received from the
    core transcriptomic facility, but unfortunately it is not entirely
    clear to which samples they correspond. Also, they are not in the
    same order. Also, there are more files than samples. Find a reasonable matching.
    Hint: use the `match` function from base R.

```r
t <- read_csv("Data/targets.tsv", col_names=FALSE)
colnames(t) <- "FileName"
t$ID <- gsub("U[^_]*_([^_]*)_[A-Z0-9]+_([0-9]_[0-9])\\.txt", "\\1_\\2", t$FileName)
samps$FileName <- t$FileName[ match(samps$ID, t$ID) ]

## alternatively:
samps2 <- merge(samps, t, by="ID", all.x=TRUE, all.y=FALSE) %>% 
  arrange(PersonID, Cells, TP)
```

 6. From the starwars data, create a list in which each element is a
    character vector with starships and the names of the list are the
    names of the characters (so for example `mylist[["Darth Vader"]]`
    is a character vector of length 1 containing "TIE Advanced x1").
    Remove all elements with no starships.

```r
vehicles <- starwars %>% drop_na(vehicles) %>% pull(vehicles)
names(vehicles) <- starwars %>% drop_na(vehicles) %>% pull(names)
```

 7. In starwars data frame, change each two part name into a "last name,
    first name" format (for example "Skywalker, Luke")

```r
nn <- starwars %>% pull(name)
nn <- sub("(.*)[[:space:]]([^[:space:]]*)$", "\\2, \\1", nn)
```

