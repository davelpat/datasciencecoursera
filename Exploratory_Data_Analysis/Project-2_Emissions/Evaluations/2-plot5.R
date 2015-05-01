library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the rows for Baltimore City, Maryland
bcNEI=NEI[ NEI$fips == "24510", ]
# Gather the subset of the bcNEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesbcNEI <- bcNEI[bcNEI$SCC %in% vehiclesSCC,]

png("plot5.png")

ggpl <- ggplot(vehiclesbcNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", width=0.7) +
  labs(x="year", y="Total PM 2.5 Emissions" ) + 
  labs(title="PM 2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008")

print(ggpl)

dev.off()