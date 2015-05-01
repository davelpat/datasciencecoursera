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

# Summarize the total emissions for Baltimore
Baltimore_City <- "24510"
totals <- summarize(filter(NEI, fips == Baltimore_City), 
                    Emissions = sum(Emissions))

# Open the png file
png(filename = "plot2.png")

# Create and write the plot
plot(totals$year, 
     totals$Emissions, 
     type = "p", 
     main = "Baltimore City Emissions", 
     ylab = "Total Emissions (Tons)"
)

# Close the file
dev.off()