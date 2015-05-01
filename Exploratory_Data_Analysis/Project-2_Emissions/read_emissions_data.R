# read_emisions_data reads the emissions data file
# then converts the following variables to factors:
#   SCC, type, and year
# Finally, it groups the data by year
# Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
read_emissions_data <- function() {
  
  # What is the expected data set file name
  NEI_file <- "summarySCC_PM25.rds"
  
  # Verify the file exists
  if(!(file.exists(NEI_file))) {
    stop('Cannot find data file ', NEI_file)
  }
  
  # Read in the data and convert it to a dplyr table
  # then convert SCC, year, and type variables to factors
  # and finally, group the table by year
  tbl_df(readRDS(NEI_file)) %>%
    mutate(SCC = as.factor(SCC)) %>%
    mutate(year = as.factor(year)) %>%
    mutate(type = as.factor(type)) %>%
    group_by(year)
}
