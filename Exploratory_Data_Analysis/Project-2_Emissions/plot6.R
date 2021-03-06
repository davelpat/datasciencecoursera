# Set the working directory to where this script is
# setwd(dirname(sys.frame(1)$ofile))

# Load necessary libraries, if necessary
if(!require("dplyr")) {
  install.packages("dplyr")
  require("dplyr")
}
if(!require("ggplot2")) {
  install.packages("ggplot2")
  require("ggplot2")
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

# Summarize the emissions for Baltimore and LA County by vehicle type
Baltimore_City <- "24510"
LA_County <- "06037"

## unique(grep("highway vehicle", 
##             SCC$SCC.Level.Two, 
##             ignore.case = TRUE, 
##             value = TRUE))
## [1] "Highway Vehicles - Gasoline"            "Highway Vehicles - Diesel"             
## [3] "Off-highway Vehicle Gasoline, 2-Stroke" "Off-highway Vehicle Gasoline, 4-Stroke"
## [5] "Off-highway Vehicle Diesel"            

mv_scc <- unlist(SCC[grep("highway vehicle", 
                          SCC$SCC.Level.Two, 
                          ignore.case = TRUE), 
                     "SCC"])
LA_BC_emissions <- filter(NEI, 
                          fips == Baltimore_City | fips == LA_County, 
                          SCC %in% mv_scc) %>%
  rename(Location = fips) %>%
  group_by(year, Location) %>%
  summarize(Emissions = sum(Emissions))

# Open the png file
png(filename = "plot6.png")

# Create and write the plot
qplot(year,
      Emissions,
      data = LA_BC_emissions,
      group = Location,
      color = Location,
      geom = c("line", "point"),
      main = "Motor Vehicle Emissions",
      xlab = "", ylab = "Emissions (Tons)"
)

# Close the file
dev.off()