# load the data

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds") not needed in this plot

# calculate the emissions for each year in Baltimore City

NEI_bc <- subset(NEI, NEI$fips=="24510")
yearly_emissions_bc <- tapply(NEI_bc$Emissions,NEI_bc$year,sum)
years <- as.numeric(rownames(yearly_emissions_bc))

# generate the plot

png(filename="plot2.png",width=480,height=480)

plot(years,yearly_emissions_bc,
     main="Total PM2.5 Emissions in Baltimore City",
     xlab="Year",ylab="Emissions (tons)", 
     col="red", xaxt="n",
     ylim=c(0,max(yearly_emissions_bc)*1.05))
axis(1, at=years)

# fit a linear model and show the trend
model <- lm(yearly_emissions_bc ~ years)
abline(model,col="red")

dev.off()