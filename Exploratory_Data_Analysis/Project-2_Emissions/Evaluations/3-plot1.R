NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

neiSum <- tapply(NEI$Emissions, NEI$year, FUN = sum)
neiSum <- neiSum/1000000
barplot(neiSum,  
        xlab="year", 
        ylab="  PM2.5   (Millions of tons)",
        main="Total PM2.5 emissions in U.S. (all sources)"
)