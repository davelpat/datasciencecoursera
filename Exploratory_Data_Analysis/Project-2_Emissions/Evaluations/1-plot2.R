library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreCity <- NEI[NEI$fips == "24510",]

totalSum <- aggregate(baltimoreCity$Emissions, by=list(Year=baltimoreCity$year), FUN=sum)

png("plot2.png", width=480, height=480)

plot(totalSum$Year, totalSum$x, type="l", col = "blue", main = "Total PM2.5 Emissions in Baltimore City", 
     xlab = "Year", ylab = "Emissions")

dev.off()