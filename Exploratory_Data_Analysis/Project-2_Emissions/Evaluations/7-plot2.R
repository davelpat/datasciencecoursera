# Loads RDS
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Baltimore data. Zip code is 24510
BM <- subset(PM25, fips == '24510')

# create graph
png(filename = 'plot2.png')

barplot(tapply(X = BM$Emissions, INDEX = BM$year, FUN = sum), 
        main = 'Total Emission in Baltimore City, MD in Tons', 
        xlab = 'Year', 
        ylab = expression('PM'[2.5]))
dev.off()