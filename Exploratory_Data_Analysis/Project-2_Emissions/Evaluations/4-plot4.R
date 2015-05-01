# load the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find out which sources are coal combustion related

coal_based <- (SCC[grepl("Coal",SCC$EI.Sector),])$SCC

# calculate their emissions for each year

NEI_cb <- subset(NEI, NEI$SCC %in% coal_based)
yearly_emissions_cb <- tapply(NEI_cb$Emissions,NEI_cb$year,sum)
years <- as.numeric(rownames(yearly_emissions_cb))

# generate the plot

png(filename="plot4.png",width=480,height=480)

plot(years,yearly_emissions_cb,
     main="Coal combustion related PM2.5 emissions in US",
     xlab="Year",ylab="Emissions (tons)",
     col="red",xaxt="n",
     ylim=c(0,max(yearly_emissions_cb)*1.05))
axis(1, at=years)

# fit a linear model and show the trend
model <- lm(yearly_emissions_cb ~ years)
abline(model,col="red")

dev.off()