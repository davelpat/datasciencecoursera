library(dplyr)
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergeData <- merge(NEI, SCC, by = "SCC")

selectCoal <- grepl("Coal", mergeData$EI.Sector)

totalcoalData <- mergeData[selectCoal, ]

finalcoalData <- aggregate(totalcoalData$Emissions, by=list(Year=totalcoalData$year), FUN=sum)

png("plot4.png", width=500, height=480)

plot(finalcoalData$Year, finalcoalData$x, type="l", col = "green", main = "Total Emissions from coal combustion-related sources: 1999-2008", 
     xlab = "Year", ylab = "Emissions")

dev.off()