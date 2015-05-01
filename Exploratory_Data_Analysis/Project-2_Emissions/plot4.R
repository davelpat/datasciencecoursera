# Set the working directory to where this script is
# setwd(dirname(sys.frame(1)$ofile))

# Load necessary libraries, if necessary
if(!require("dplyr")) {
  install.packages("dplyr")
  require("dplyr")
}
if(!require("lattice")) {
  install.packages("lattice")
  require("lattice")
}

# Read the data categories, if we haven't already
if(!"read_emissions_categories" %in% ls()) {
  source("read_emissions_categories.R")
}
if(!"SCC" %in% ls()) { SCC <- read_emissions_categories() }

# Read the data file, if we haven't already
if(!"read_emissions_data" %in% ls()) {
  source("read_emissions_data.R")
}
if(!"NEI" %in% ls()) { NEI <- read_emissions_data() }

# Summarize the emissions for coal combustion by industry sector
coal_combustion_pattern <- "Fuel Comb .* Coal"

## unique(grep(coal_combustion_pattern, SCC$EI.Sector, value = TRUE))
## [1] "Fuel Comb - Electric Generation - Coal"     
## [2] "Fuel Comb - Industrial Boilers, ICEs - Coal"
## [3] "Fuel Comb - Comm/Institutional - Coal"      

# Get a list of catalog entries for coal combustion
coal_scc <- unlist(SCC[grep(coal_combustion_pattern, SCC$EI.Sector), "SCC"])
coal_emissions <- filter(NEI, SCC %in% coal_scc) %>%
  group_by(year, SCC) %>%
  summarize(Emissions = sum(Emissions, na.rm = TRUE))

# Open the png file
png(filename = "plot4.png", height = 1920, width = 960)

# Create and write the plot
xyplot(Emissions ~ year | SCC, 
       data = coal_emissions,
       xlab = "", ylab = "Emissions (tons)",
       main = "Emissions From Coal Combustion By Category")

# Close the file
dev.off()