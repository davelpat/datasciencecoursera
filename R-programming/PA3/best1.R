## The "best" function reads the outcome-of-care-measures.csv file
## and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## utility function to generate colClasses pattern

## Load supporting functions, if needed
if(!exists("makeDataCache")) {
  source('~/GitHub/datasciencecoursera/R-programming/PA1/PA3/pa3_utils.R')
  data_cache <- makeDataCache()
  data_file <- 'outcome-of-care-measures.csv'
}

## This is the main function
best <- function(state, outcome) {
  ## just call rankhospital
  rankhospital(state, outcome)
}
