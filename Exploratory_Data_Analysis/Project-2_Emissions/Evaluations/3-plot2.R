NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

neibal <- NEI[NEI$fips=="24510",]
neibs <- tapply(neibal$Emissions, neibal$year, FUN = sum)
barplot(neibs,  
        xlab="year", 
        ylab="  PM2.5   (tons)",
        main="Total PM2.5 emissions in Baltimore (all sources)"
)