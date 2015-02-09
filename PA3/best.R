## The "best" function reads the outcome-of-care-measures.csv file
## and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome
## in that state. In the event of a tie for best, the first alphabetically
## named hospital will be returned.
## The outcomes can be one of "heart attack", "heart failure",
## or "pneumonia".

## utility function to generate colClasses pattern
## Required parameter is a list of vectors, each named for the
## desired class, of indices where that class is desired.
## The rest of the vector is filled with "NULL".
## Optional "len" parameter sets the length of the vector.
## Default len = 46
## returns a colClasses character vector
gen_outcome_classes <- function(non_null, len=46) {
  # generate the list of nulls as wide as the outcomes table
  classes <- rep("NULL", len)
  
  # go through the list of non-null colmun indices,
  # setting the colClasses vector to the desired class
  for(klas in names(non_null)) {
    for(idx in non_null[klas]) classes[idx] <- klas
  }
  classes
}

## Generates the error message for the "best" function
## takes a string indicating which parameter is invalid
## and best function's parameters
best_error_invalid <- function(param, state, outcome) {
  message('Error in best("', state, '", "', outcome, '") : invalid ', param)
}

## This is the main function
best <- function(state, outcome) {
  ## Read only the needed outcome data
  # well, bummer. the data is all quoted strings,
  # so read.csv chokes on coercing to numeric
  #lst  <- list('character'=c(2,7), 'numeric'=c(11,17,23))
  # can still limit data read in, but it will all be chars
  lst  <- list('character'=c(2,7,11,17,23))
  colc <- gen_outcome_classes(lst)
  #print(str(colc))
  data <- read.csv('outcome-of-care-measures.csv', colClasses=colc, nrows=4706)
  names(data) <- c('Hospital.Name','State',"heart attack", "heart failure","pneumonia")

  ## Check that state and outcome are valid
  # Note: data includes District of Columbia (DC), Guam (GU),
  #  Puerto Rico (PR), and the Virgin Islands (VI)
  states <- unique(data$State)
  conds <- names(data)[3:5]
  
  if(!(state %in% states)) {
    best_error_invalid('state', state, outcome)
  } else if(!(outcome %in% conds)) {
    best_error_invalid('outcome', state, outcome)
  } else {
    ## Split the data into states, keeping only the state of interest
    ## as a simple data frame
    state_data <- split(data, data$State)[[state]]
    ## Coerce outcome data to be numeric and suppress NA warning
    state_data[outcome] <- 
      suppressWarnings(sapply(state_data[outcome], as.numeric))
    ## Get the hospital name(s) in that state with lowest 30-day death rate
    best_hospital <- 
      subset(state_data, 
             state_data[outcome]==min(state_data[outcome],
                                      na.rm=T))$Hospital.Name
    ## Return the first (alphabetically) hospital name
    if(length(best_hospital) > 1) best_hospital <- sort(best_hospital)[1]
    best_hospital
  }
}
