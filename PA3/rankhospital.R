## The "rankhospital" function reads the outcome-of-care-measures.csv file
## and returns the name of the hospital that has the specified ranking for
## the specified state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The function takes three arguments: 
##    the 2-character abbreviated name of a state (state)
##    an outcome (outcome)
##    the ranking of a hospital in that state for that outcome (num)
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## Load supporting functions
if(!exists("makeDataCache")) {
  source('~/GitHub/datasciencecoursera/R-programming/PA1/PA3/pa3_utils.R')
  data_cache <- makeDataCache()
  data_file <- 'outcome-of-care-measures.csv'
}

## This is the main function
rankhospital <- function(state, outcome, rank=1) {
  ## Read the needed outcome data
  outcome_data <- cacheOutcomes(data_cache)
  
  if(valid_args(state, outcome)) {
    ## get the data for the state of interest
    state_data <- outcome_data[[state]]

    ## Get the list of ratings for that outcome for that state
    ratings <- get_ratings(state_data[outcome])
    
    ## map "best" and "worst" ranks to the ratings
    if(rank == "best") {
      rank = 1
    } else if(rank == "worst") {
      rank = length(ratings)
    }
    
    ## validate rank is within range
    if(rank %in% seq_along(ratings)) {
      ## Get the hospital name(s) in that state with the mortaility rate rank
      hospital <- state_data[which(state_data[outcome]==ratings[rank]),]$Hospital.Name
      ## Return the first (alphabetically) hospital name
      if(length(hospital) > 1) hospital <- sort(hospital)[1]
    } else {
      hospital <- NA
    }
    hospital
  }
}
