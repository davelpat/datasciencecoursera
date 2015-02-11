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
