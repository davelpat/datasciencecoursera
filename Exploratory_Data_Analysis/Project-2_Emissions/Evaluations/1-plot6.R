library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergeData <- merge(NEI, SCC, by = "SCC")

selectVehicle <- grepl("Vehicle", mergeData$SCC.Level.Two, ignore.case = TRUE)
totalvehicleData <- mergeData[selectVehicle, ]

# select all data from Baltimore and LA
totalvehicleBaltimore <- totalvehicleData[totalvehicleData$fips == "24510", ]
totalvehicleBaltimore$City <- "Baltimore City"
totalvehicleLA <- totalvehicleData[totalvehicleData$fips == "06037", ]
totalvehicleLA$City <- "Los Angeles County"

totalvehicleCity <- rbind(totalvehicleBaltimore, totalvehicleLA)

# sum the Emissions value
totalData <- ddply(totalvehicleCity, .(year, City), function(x) sum(x$Emissions))

# produce plot

png("plot6.png", width=600, height=480)

qplot(year, V1, data=totalData, geom="line", color=City,
      main = " Emissions from motor vehicle sources in Baltimore City and Los Angeles County",
      xlab = "Year", ylab = "Emissions")

dev.off()