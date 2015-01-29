complete <- function(directory, id = 1:332) {
  ## 'directory' is the location of the CSV files
  
  ## 'id' is the set of monitor ID numbers
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  ## get the set of files
  files <- sprintf("%s/%03d.csv", directory, id)
  
  ## Get a data frame of pollutant observations for each monitor
  dat <- lapply(files, read.csv, colClasses=c("NULL", "numeric", "numeric", "NULL"), nrows=4019)
  
  ## For each monitor, count the number of complete observations
  counts <- vector("integer")
  for(i in seq_along(id)){
    counts[i] <- sum(as.integer(complete.cases(dat[[i]][1:2])))
  }

  ## return the correctly labeled data structure
  data.frame(id=id, nobs=counts)
}