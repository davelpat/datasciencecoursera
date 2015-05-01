library(ggplot2)

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

png("plot6.png")

index <- grep("vehicle", SCC$EI.Sector, ignore.case=T)
sc <- SCC[index, ]$SCC
subdata <- subset(NEI, fips=="24510" | fips=="06037")
sub <- subset(subdata, SCC %in% as.character(sc))
s <- split(sub, sub$year)
emissionBA <- sapply(s, function(x) sum(subset(x, fips=="24510")[, "Emissions"], 
                                        na.rm=T))
emissionLA <- sapply(s, function(x) sum(subset(x, fips=="06037")[, "Emissions"], 
                                        na.rm=T))
emission <- data.frame(year=rep(seq(1999, 2008, length=4), 2), city=gl(2, 4, 
                                                                       labels=c("Baltimore City", "Los Angeles County")), 
                       Emissions=c(emissionBA, emissionLA))

qplot(year, log(Emissions), data=emission, color=city, 
      ylab="log PM2.5 of motor vehicle sources")

dev.off()