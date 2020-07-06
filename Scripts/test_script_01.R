



#' Read and check correctness of an input file
#'
#' The function attempts to read a comma separated value (CSV) file.
#' The file must contain at least two columns. First column is treated as
#' an ID column and must be numeric and may not contain duplicates. Numbers of missing values (NA's)
#' are reported.
#' 
#' @param file_name Name of a file
#' @return A dataframe with 2 columns
check_input <- function(file_name) {

  if(!file.exists(file_name)) {
    stop(sprintf("check_input: File %s does not exist", file_name))
  }

  error <- try(read.csv(file_name))

  if(inherits(error, "try-error")) {
    stop(sprintf("There was a problem reading the file %s", file_name))
  } else {
    message("Read successfully!")
  }

  data <- error

  n_cols <- ncol(data)

  message(sprintf("Data has %d columns", n_cols))

  if(n_cols < 2) {
    stop("Fewer than 2 columns")
  }

  if(n_cols > 2) {
    warning("Warning! More than 2 columns, remaining columns will be discarded")
    }

  id_nas  <- sum(is.na(data[,1]))
  val_nas <- sum(is.na(data[,2]))

  message(sprintf("ID NA's: %d Value NA's: %d", id_nas, val_nas))

  if(!is.numeric(data[,1])) {
    stop("ID's are not numeric")
  }

  if(any(duplicated(data[,1]))) {
    stop("ID's are not unique")
  }

  return(data[, 1:2])
}

