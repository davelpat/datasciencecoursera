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

## Check that state and outcome are valid
# Note: outcome_data includes District of Columbia (DC), Guam (GU),
#  Puerto Rico (PR), and the Virgin Islands (VI)
# Note: states, the master list of valid states, is cached by casheOutcomes

valid_args <- function (state, outcome) {
  if(!(state %in% states)) {
    stop('invalid state')
  } else if(!(outcome %in% conditons)) {
    stop('invalid outcome')
  }
  TRUE
}

## takes a data frame, split by state, of hospital name,state, and 3 conditions
## returns a character vector of hospital names, ranked by morbidity rate for that condition
sort_by_morbidity <- function (outcome_data, outcome) {
  # remove NAs
  rated_hospitals <- na.omit(outcome_data[,c("Hospital.Name",outcome)])
  
  # rank by 2 level sort: outcome first, then hospital name
  ranks <- order(rated_hospitals[,outcome],rated_hospitals[,"Hospital.Name"])

  # return a char vector of sorted hospital names, ranked by morbidity rates
  rated_hospitals[ranks,"Hospital.Name"]
}

## this function creates a DataCache and the functions that store and
## retrieve the DataCache from the parent environment

makeDataCache <- function(dframe = data.frame()) {
  # clear out the local data frame so the parent environment is searched for it
  outcome_data <- NULL
  
  # cache a new outcomes data and clean any local copy
  set <- function(dframe) {
    outcome_data <<- dframe
    outcome_data <- NULL
  }
  
  # retrieve the current outcomes data from the cache (parent) environment
  get <- function() outcome_data
  
  # create the list for calling the local methods
  list(set = set, get = get)
}

## this function returns the cached outcomes data frame if it exists
## or, if it does not exist, reads the hospital data, coerces the outcome
## variables to numeric, splits the data by state and caches the data frame

cacheOutcomes <- function(data_cache, 
                          data_file="outcome-of-care-measures.csv", 
                          var_list=list('character'=c(2,7,11,17,23)), 
                          name_list=c("Hospital.Name", "State", "heart attack", "heart failure", "pneumonia")
                          ) {
  # get the cached outcome_data, assuming it exists
  cached_data <- data_cache$get()
  # test the assumption
  if(is.null(cached_data)) {
    # no cached outcome_data, so read it, process it and cache it
    
    # generate the variable (column) mask
    mask <- gen_outcome_classes(var_list)
    cached_data <- read.csv(data_file, colClasses=mask, nrows=4706)
    
    # rename columns to match search conditions and cache the condition names
    names(cached_data) <- name_list
    conditons <<- name_list[3:5]
    
    ## Coerce outcome data to be numeric and suppress NA warning
    for(col in conditons) {
      cached_data[col] <- suppressWarnings(sapply(cached_data[col], as.numeric))
    }
    
    # Cache the list of states while we're here
    states <<- sort(unique(cached_data$State))
    
    # split the data by state
    cached_data <- split(cached_data, cached_data$State)
    
    # and cache it
    data_cache$set(cached_data)
#  } else {
#    message("getting cached data")
  }
  ## Return the outcome_data for the data_file
  cached_data
}
