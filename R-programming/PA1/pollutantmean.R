pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is the location of the CSV files
  ## 'pollutant' is the name of the pollutant
  ##    valid values: "sulfate" or "nitrate"
  ## 'id' is the range of monitor ID numbers
  ## Returns the mean of the pollutant across all monitors in 'id'

  ## Create pollutant filters
  filt <- list (
    "sulfate" = c("NULL", "numeric", "NULL", "NULL"),
    "nitrate" = c("NULL", "NULL", "numeric", "NULL")
  )
  
  ## Generate the file list
  ## TODO: verify the files exist
  files <- sprintf("%s/%03d.csv", directory, id)
  
  ## Get the data of just the requested pollutant
  dat <- sapply(files, read.csv, colClasses=filt[[pollutant]], nrows=4019)

  ## Aggregate the readings
  aggr <- vector("numeric", 0)
  for(i in 1:length(dat)){aggr <- c(aggr,dat[[i]])}

  ## and return the mean across all requested monitors
  round(mean(aggr, na.rm=T), digits=3)

}