corr <- function(directory, threshold = 0) {
  ## 'directory' is the location of the CSV files
  
  ## 'threshold' is the number of completely observed observations
  ## required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Returns a numeric vector of correlations
  ## set options(digits=4) before submitting to print the correct numbers
  
  ## get the set of files
  files <- list.files(directory, full.names = T)
  ## mask to get only the data columns of interest
  mask <- c("NULL", "numeric", "numeric", "NULL")
  
  correlations <- vector("numeric")
  ## Process files one at a time to reduce memory requirements
  for(fn in files){
    # read in the pollutant data
    dat <- read.csv(fn, colClasses=mask, nrows=4019)
    # Find the complete cases
    cases <- complete.cases(dat$nitrate, dat$sulfate)
    # Does it meet the threshold?
    if(sum(cases) > threshold){
      # Run the correlation between complete cases of the pollutants and collect the result
      correlations <- c(correlations, cor(dat$nitrate[cases], dat$sulfate[cases]))#, use="pairwise.complete.obs"))
    }
  }
  
  ## return the correlation vector
  correlations
}