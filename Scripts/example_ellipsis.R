


stats <- function(x, what, remove_nas=TRUE) {

  if(what == "mean") {
    return(mean(x, na.rm=remove_nas))
  } else if(what == "sd") {
    return(sd(x)) 
  } else if(what == "median") {
    return(median(x)) 
  } else {
    warning(sprintf("I don't know how to calculate %s", what))
  }

}

## alternatively, use ellipsis:
stats <- function(x, what, ...) {

  if(what == "mean") {
    return(mean(x, ...))
  } else if(what == "sd") {
    return(sd(x)) 
  } else if(what == "median") {
    return(median(x)) 
  } else {
    warning(sprintf("I don't know how to calculate %s", what))
  }

}



add_a_b <- function(a, b) {
  return(invisible(a + b))
}
