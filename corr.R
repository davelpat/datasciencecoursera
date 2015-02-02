corr <- function(directory, threshold = 0) {
  ## 'directory' is the location of the CSV files
  
  ## 'threshold' is the number of completely observed observations
  ## required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Returns a numeric vector of correlations
  
  ## get the set of files
  files <- list.files(directory, full.names = T)
  
  ## Get a data frame of pollutant observations for each monitor
  dat <- lapply(files, read.csv, colClasses=c("NULL", "numeric", "numeric", "NULL"), nrows=4019)
  
  ## For each monitor, count the number of complete observations
  corrs <- vector("numeric")
  for(i in 1:length(files)){
    cnt <- sum(complete.cases(dat[[i]][1:2]))
    if(cnt > threshold){
      corrs <- c(corrs, cor(dat[[i]]$nitrate, dat[[i]]$sulfate, use="pairwise.complete.obs"))
    }
  }
  
  ## return the correlation vector
  return(corrs)
}