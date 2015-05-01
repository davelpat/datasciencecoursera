library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# should select rows, not columns, but it is not used for this plot
baltimoreCity <- NEI[, NEI$fips == "24510"]

totalSum <- aggregate(NEI$Emissions, by=list(Year=NEI$year), FUN=sum)

png("plot1-1.png", width=480, height=480)

plot(totalSum$Year, totalSum$x, type="l", col = "red", main = "Total PM2.5 Emissions", xlab = "Year", ylab = "Emissions")

dev.off()