library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999 to 2008?

# Find coal combustion-related sources
iscoal2 <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coalsources <- SCC[iscoal2,]

# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% coalsources$SCC), ]

# group by year
emiyear <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

# plot
library(ggplot2)
png("plot4.png")
qpl = qplot(year, Emissions, data=emiyear, geom="line",
            ylab="Total Emissions", 
            main="Total PM 2.5 Emissions from coal-combustion sources")
print(qpl)
dev.off()