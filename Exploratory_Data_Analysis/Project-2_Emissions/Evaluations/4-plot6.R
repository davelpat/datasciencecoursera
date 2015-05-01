# load the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find out which sources are motor vehicles

# (DLP) motor_vehicles <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),"SCC"]
motor_vehicles <- (SCC[SCC$Data.Category=="Onroad",])$SCC

# calculate their emissions for each year in Baltimore City and
# Los Angeles

NEI_mv_bc <- subset(NEI, NEI$SCC %in% motor_vehicles & NEI$fips=="24510")
NEI_mv_la <- subset(NEI, NEI$SCC %in% motor_vehicles & NEI$fips=="06037")
yearly_emissions_mv_bc <- tapply(NEI_mv_bc$Emissions,NEI_mv_bc$year,sum)
yearly_emissions_mv_la <- tapply(NEI_mv_la$Emissions,NEI_mv_la$year,sum)

# instead of absolute changes in tons it's more illuminating here to consider the changes
# in relation to each city's initial (year 1999) motor vehicle emissions, expressing
# them as percentages of the initial emissions

yearly_emissions_mv_bc_p  <- 
  (yearly_emissions_mv_bc/yearly_emissions_mv_bc["1999"])*100
yearly_emissions_mv_la_p  <- 
  (yearly_emissions_mv_la/yearly_emissions_mv_la["1999"])*100

years <- as.numeric(rownames(yearly_emissions_mv_bc))

# generate the plot comparing BC and LA

png(filename="plot6.png",width=480,height=480)

plot(years,yearly_emissions_mv_bc,type="n",
     main="Motor vehicle PM2.5 emissions in BC vs LA",
     xlab="Year",ylab="Emissions (percents of the year 1999 emissions)", 
     xaxt="n",yaxt="n",
     ylim=c(0,140))

abline(h=100)
abline(h=0,lty=3)
abline(h=25,lty=3)
abline(h=50,lty=3)
abline(h=75,lty=3)
abline(h=125,lty=3)

points(years,yearly_emissions_mv_bc_p,col="red")
points(years,yearly_emissions_mv_la_p,col="blue",pch=4)

axis(1, at=years)
axis(2, at=c(0,25,50,75,100,125))

legend("topright",pch=c(1,4), bg="white",col=c("red","blue"),
       legend=c("Baltimore City","Los Angeles"))

# fit the linear models and show the trends
model_bc <- lm(yearly_emissions_mv_bc_p ~ years)
abline(model_bc,col="red")
model_la <- lm(yearly_emissions_mv_la_p ~ years)
abline(model_la,col="blue")

dev.off()