# load the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find out which sources are motor vehicles

motor_vehicles <- (SCC[SCC$Data.Category=="Onroad",])$SCC

# calculate their emissions in Baltimore City for each year

NEI_mv_bc <- subset(NEI, NEI$SCC %in% motor_vehicles & NEI$fips=="24510")
yearly_emissions_mv_bc <- tapply(NEI_mv_bc$Emissions,NEI_mv_bc$year,sum)
years <- as.numeric(rownames(yearly_emissions_mv_bc))

# generate the plot

png(filename="plot5.png",width=480,height=480)

plot(years,yearly_emissions_mv_bc,
     main="Motor vehicle PM2.5 emissions in Baltimore City",
     xlab="Year",ylab="Emissions (tons)", 
     col="red",xaxt="n",
     ylim=c(0,max(yearly_emissions_mv_bc)*1.05))
axis(1, at=years)

# fit a linear model and show the trend
model <- lm(yearly_emissions_mv_bc ~ years)
abline(model,col="red")

dev.off()