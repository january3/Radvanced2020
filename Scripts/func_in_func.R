
primitive_apply <- function(some_list, func) { 
  n <- length(some_list)
  ret <- rep(NA, n)

  for(i in 1:n) {
      ret[i] <- func(some_list[[i]])
  }

  return(ret)
}
