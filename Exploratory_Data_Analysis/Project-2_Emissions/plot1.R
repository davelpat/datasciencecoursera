# Set the working directory to where this script is
# setwd(dirname(sys.frame(1)$ofile))

# Load necessary library, if necessary
if(!require("dplyr")) {
  install.packages("dplyr")
  require("dplyr")
}

# Read the data file, if we haven't already
if(!"read_emissions_data" %in% ls()) {
  source("read_emissions_data.R")
}
if(!"NEI" %in% ls()) { NEI <- read_emissions_data() }

# Summarize the total emissions
totals <- summarize(NEI, Emissions = sum(Emissions))

# Open the png file
png(filename = "plot1.png")

# Create and write the plot
plot(totals$year, 
     totals$Emissions, 
     type = "p", 
     main = "US Emissions", 
     ylab = "Total Emissions (Tons)"
)

# Close the file
dev.off()