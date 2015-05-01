library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergeData <- merge(NEI, SCC, by = "SCC")

# select all data from Baltimore
totalBaltimore <- mergeData[mergeData$fips == "24510", ]

# sum the Emissions value
totalData<- ddply(totalBaltimore, .(year, type), function(x) sum(x$Emissions))

# produce plot
png("plot3.png", width=600, height=480)

qplot(year, V1, data=totalData, geom="line", color=type,
      main = "Total Emissions in Baltimore City by type from 1999 to 2008",
      xlab = "Year", ylab = "Emissions")

dev.off()