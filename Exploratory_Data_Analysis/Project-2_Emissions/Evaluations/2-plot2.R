NEI <- readRDS("summarySCC_PM25.rds")

#subset the rows for Baltimore City, Maryland
bcNEI=NEI[ NEI$fips == "24510", ]
sss = tapply(bcNEI$Emissions, bcNEI$year, sum)
plot(names(sss), sss, main="Total PM2.5 Emissions in Baltimore City, MD", 
     ylab="Total Emissions (tons)", xlab="Year", lab=c(7,7,9), pch=19)
lines(names(sss), sss)
# copy the result to png file, default sizes specified, just to be sure
dev.copy(png, file = "plot2.png", width=480, height=480 )
dev.off()