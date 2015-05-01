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

# Read the data file, if we haven't already
if(!"read_emissions_data" %in% ls()) {
  source("read_emissions_data.R")
}
if(!"NEI" %in% ls()) { NEI <- read_emissions_data() }

# Summarize the emissions for Baltimore by type
Baltimore_City <- "24510"
BC_emissions <- filter(NEI, fips == Baltimore_City) %>%
  group_by(year, type) %>%
  rename(Type = type) %>%
  summarize(Emissions = sum(Emissions))

# Open the png file
png(filename = "plot3.png")

# Create and write the plot
qplot(year,
      Emissions,
      data = BC_emissions,
      group = Type,
      color = Type,
      geom = c("line", "point"),
      main = "Baltimore City Emissions",
      xlab = "", ylab = "Emissions (Tons)"
)

# Close the file
dev.off()
