# read_emisions_categories reads the emissions data category catalog
# then converts the EI.Sector variable to type character so it can
# be searched with regular expressions using grep
# Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
read_emissions_categories <- function() {
  
  # What is the expected data category file name
  SCC_file <- "Source_Classification_Code.rds"
  
  # Verify the file exists
  if(!(file.exists(SCC_file))) {
    stop('Cannot find data catalog ', SCC_file)
  }
  
  # Read in the catalog, converting the EI.Sector to type character so regular
  # expression pattern matching can be used to find the desired SCC factors
  tbl_df(readRDS(SCC_file)) %>%
    mutate(EI.Sector = as.character(EI.Sector))
  
}
