# read our data into the data tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create a new columns with year as factor, since we're going
# plot them based on sum of total emissions for year
NEI$yearFactor <- as.factor(NEI$year)

# get the subset of the sources from motor vehicles
VehicleSource <- SCC[grepl("Vehicle", SCC$SCC.Level.Two), ]

# now subset NEI data for vehicle sources in Baltimore City and Los Angeles only
dataFrame <- NEI[NEI$SCC %in% VehicleSource$SCC & (NEI$fips == "24510" | NEI$fips == "06037"),]

# set fipsFactor so that the city can be group as factor in ggplot for facets
dataFrame$fipsFactor <- factor(dataFrame$fips)

# create a list of labels for Baltimore City and Los Angeles County
fipsMap <- list("24510"="Baltimore City", "06037"="Los Angeles County")

# and a labeller function to label our facets
fipsLabeller <- function(varaible, value) {
  # value passed in is a number 1 or 2 of the factor
  # so we'll need to first map the value to the level of the factor
  # which will give us "06037" or "24510"
  # only then, we can lookup fipsMap to get the name
  # "Baltimore City" or "Los Angeles County"
  return (fipsMap[levels(dataFrame$fipsFactor)[value]])
}

# setup our ggplot for total emission from vehicles combustion vs year
g <- ggplot(dataFrame, aes(yearFactor, Emissions))

# draw the graph out, with y scale in kilo tons, with a facet labeller function
g + geom_bar(stat="identity") + facet_grid(. ~ fipsFactor, labeller=fipsLabeller) + xlab("Year") + ylab("Emissions (kilo tons)") + ggtitle("Comparing PM 2.5 Emissions from Motor Vehicles") + scale_y_continuous(labels = function(x) { x / 1000 })

# copy graph out to png file
dev.copy(png, "plot6.png", width=800, height=600)

# turn off the device
dev.off()
