# load the data

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds") not needed in this plot

# calculate the emissions for each year

yearly_emissions <- tapply(NEI$Emissions,NEI$year,sum)
years <- as.numeric(rownames(yearly_emissions))

# generate the plot

png(filename="plot1.png",width=480,height=480)

plot(years,yearly_emissions,
     main="Total PM2.5 Emissions in US",
     xlab="Year",ylab="Emissions (tons)",
     col="red", xaxt="n",
     ylim=c(0,max(yearly_emissions)*1.05))
axis(1, at=years)

# fit a linear model and show the trend
model <- lm(yearly_emissions ~ years)
abline(model,col="red")

dev.off()