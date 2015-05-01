library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergeData <- merge(NEI, SCC, by = "SCC")

selectVehicle <- grepl("Vehicle", mergeData$SCC.Level.Two, ignore.case = TRUE)

totalvehicleData <- mergeData[selectVehicle, ]

totalvehicleBaltimore <- totalvehicleData[totalvehicleData$fips == "24510", ]

totalemissionBaltimore <- aggregate(totalvehicleBaltimore$Emissions, by=list(Year=totalvehicleBaltimore$year), FUN=sum)

png("plot5.png", width=600, height=480)

plot(totalemissionBaltimore$Year, totalemissionBaltimore$x, type="l", col = "blue", main = "Emissions from motor vehicle sources from 1999-2008 in Baltimore City", 
     xlab = "Year", ylab = "Emissions")

dev.off()