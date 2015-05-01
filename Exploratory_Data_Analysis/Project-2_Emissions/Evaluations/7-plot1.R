# Loads RDS
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregates and Kilo Ton Level
Emissions <- aggregate(PM25[, 'Emissions'], by = list(PM25$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

# Create the plot
png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, 
        main = expression('Total Emission of PM'[2.5]), 
        xlab = 'Year', 
        ylab = expression(paste('PM', ''[2.5], ' in Kilo Tons')))
dev.off()