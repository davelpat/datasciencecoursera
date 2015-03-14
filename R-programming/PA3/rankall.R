## The "rankall" function reads the outcome-of-care-measures.csv file
## and returns a 2-column data frame containing the hospital in each
## state that has the ranking specied in rank.
## The function takes two arguments: 
##    an outcome (outcome)
##    the ranking of a hospital in that state for that outcome (rank)
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## Load supporting functions, if needed
if(!exists("makeDataCache")) {
  source('~/GitHub/datasciencecoursera/R-programming/PA1/PA3/pa3_utils.R')
  data_cache <- makeDataCache()
  data_file <- 'outcome-of-care-measures.csv'
}

## This is the main function
rankall <- function(outcome, rank=1) {
  hospitals <- vector("character")
  ## for each state, collect the hospital name
  for(state in states){
    hospitals <- c(hospitals, rankhospital(state, outcome, rank))
  }
  data.frame(states, "hospital"=hospitals, "state"=states, row.names=1)
}
