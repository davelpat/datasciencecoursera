NEI <- readRDS("summarySCC_PM25.rds")
# not needed for plot1
# SCC <- readRDS("Source_Classification_Code.rds") 
sss = tapply(NEI$Emissions, NEI$year, sum)
plot(names(sss), sss, main="Total PM2.5 Emissions in US", 
     ylab="Total Emissions (tons)", xlab="Year", lab=c(7,7,9), pch=19)
lines(names(sss), sss)
# copy the result to png file, default sizes specified, just to be sure
dev.copy(png, file = "plot1.png", width=480, height=480 )
dev.off()