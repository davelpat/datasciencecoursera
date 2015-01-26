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
  
  ## Get a column of data for each station
  ## assumes all or nothing for pollutant observations
  ### !!NOTE !! the following sappy returns different structures for single vs multiple files
  dat <- sapply(files, read.csv, colClasses=c("NULL", "numeric", "NULL", "NULL"), nrows=4019) #nrows=10) #
  
  ## remove non-observations
  cdat <- sapply(dat, na.omit)
  
  ## and count what's left
  counts <- vector("integer")
  if(length(id) ==  1) {
    counts[1] <- length(cdat)
  } else {
    for(i in 1:length(id)){counts[i] <- length(cdat[[i]])}
  }

  ## return the correctly labeled data structure
  data.frame(id=id, nobs=counts)
}