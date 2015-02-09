## The "best" function reads the outcome-of-care-measures.csv file
## and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

best <- function(state, outcome) {
  ## Read only the needed outcome data
  ## Check that state and outcome are valid
  ## Split the data into states
  ## Return hospital name in that state with lowest 30-day death rate
}
