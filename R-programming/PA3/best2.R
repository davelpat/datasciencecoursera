## The "best" function reads the outcome-of-care-measures.csv file
## and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## Load supporting functions
if(!exists("makeDataCache")) {
  source('~/GitHub/datasciencecoursera/R-programming/PA1/PA3/pa3_utils.R')
  data_cache <- makeDataCache()
  data_file <- 'outcome-of-care-measures.csv'
}

## This is the main function
best <- function(state, outcome, lowest=TRUE) {
  ## Read only the needed outcome data
  outcome_data <- cacheOutcomes(data_cache)
  
  ## Check that state and outcome are valid
  # Note: outcome_data includes District of Columbia (DC), Guam (GU),
  #  Puerto Rico (PR), and the Virgin Islands (VI)
  # Note: states, the master list of valid states, is cached by casheOutcomeData
  
  if(!(state %in% states)) {
    stop('invalid state')
  } else if(!(outcome %in% conditons)) {
    stop('invalid outcome')
  } else {
    ## get the data for the state of interest
    state_data <- outcome_data[[state]]

    ## Get the hospital name(s) in that state with lowest 30-day death rate
    if(lowest == TRUE) {
      lowest_rate <- min(state_data[outcome], na.rm=T)
    } else {
      lowest_rate <- max(state_data[outcome], na.rm=T)
    }
    
    best_hospital <- state_data[which(state_data[outcome]==lowest_rate),]$Hospital.Name
    ## Return the first (alphabetically) hospital name
    if(length(best_hospital) > 1) best_hospital <- sort(best_hospital)[1]
    best_hospital
  }
}
