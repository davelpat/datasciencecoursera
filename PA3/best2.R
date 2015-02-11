## The "best" function reads the outcome-of-care-measures.csv file
## and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## Load supporting functions
source('~/GitHub/datasciencecoursera/R-programming/PA1/PA3/pa3_utils.R')

## This is the main function
best <- function(state, outcome) {
  ## Read only the needed outcome data
  # well, bummer. the data is all quoted strings,
  # so read.csv chokes on coercing to numeric
  #lst  <- list('character'=c(2,7), 'numeric'=c(11,17,23))
  # can still limit data read in, but it will all be chars
  lst  <- list('character'=c(2,7,11,17,23))
  colc <- gen_outcome_classes(lst)
  outcome_data <- read.csv('outcome-of-care-measures.csv', colClasses=colc, nrows=4706)
  names(outcome_data) <- c('Hospital.Name','State',"heart attack", "heart failure","pneumonia")

  ## Check that state and outcome are valid
  # Note: outcome_data includes District of Columbia (DC), Guam (GU),
  #  Puerto Rico (PR), and the Virgin Islands (VI)
  states <- unique(outcome_data$State)
  conds <- names(outcome_data)[3:5]
  
  if(!(state %in% states)) {
    stop('invalid state')
  } else if(!(outcome %in% conds)) {
    stop('invalid outcome')
  } else {
    ## Split the outcome_data into states, keeping only the state of interest
    ## as a simple data frame
    state_data <- split(outcome_data, outcome_data$State)[[state]]
    ## Coerce outcome_data to be numeric and suppress NA warning
    state_data[outcome] <- 
      suppressWarnings(sapply(state_data[outcome], as.numeric))
    ## Get the hospital name(s) in that state with lowest 30-day death rate
    lowest_rate <- min(state_data[outcome], na.rm=T)
    best_hospital <- subset(state_data, 
                            state_data[outcome]==lowest_rate)$Hospital.Name
    ## Return the first (alphabetically) hospital name
    if(length(best_hospital) > 1) best_hospital <- sort(best_hospital)[1]
    best_hospital
  }
}
