library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the rows for Baltimore City, Maryland
bcNEI=NEI[ NEI$fips == "24510", ]
#subset the rows for Los Angeles fips == "06037"
laNEI=NEI[ NEI$fips == "06037", ]
# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC

#vehicles in BC
vehiclesbcNEI <- bcNEI[bcNEI$SCC %in% vehiclesSCC,]
vehiclesbcNEI$city ="Baltimore"
#vehicles in LA
vehicleslaNEI <- laNEI[laNEI$SCC %in% vehiclesSCC,]
vehicleslaNEI$city="Los Angeles"
# Combine the two subsets 
twocityNEI <- rbind(vehiclesbcNEI,vehicleslaNEI)

png("plot6.png")

ggpl <- ggplot(twocityNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", width=0.7) +
  labs(x="year", y="Total PM 2.5 Emissions" ) + 
  facet_grid(.~city) +
  labs(title="PM 2.5 Motor Vehicle Source Emissions Baltimore and LA 1999-2008")

print(ggpl)

dev.off()