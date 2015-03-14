## The "rankhospital" function reads the outcome-of-care-measures.csv file
## and returns the name of the hospital that has the specified ranking for
## the specified state.
## The function takes three arguments: 
##    the 2-character abbreviated name of a state (state)
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
rankhospital <- function(state, outcome, rank=1) {
  ## Read the needed outcome data
  outcome_data <- cacheOutcomes(data_cache)
  
  if(valid_args(state, outcome)) {
    ## Get the list of hospitals ordered by morbidity rate
    ## for that outcome for the state
    ranked_hospitals <- sort_by_morbidity(outcome_data[[state]], outcome)
    
    ## map "best" and "worst" ranks to the ratings
    if(rank == "best") {
      rank = 1
    } else if(rank == "worst") {
      rank = length(ranked_hospitals)
    }
    
    ## validate rank is within range
    if(rank %in% seq_along(ranked_hospitals)) {
      ## Get the hospital name in that state with the requested mortaility rate rank
      hospital <- ranked_hospitals[rank]
    } else {
      hospital <- NA
    }
    hospital
  }
}
