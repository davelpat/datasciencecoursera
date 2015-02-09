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

## This is the main function
best <- function(state, outcome) {
  ## Read only the needed outcome data
  ## Check that state and outcome are valid
  ## Split the data into states
  ## Return hospital name in that state with lowest 30-day death rate
}
