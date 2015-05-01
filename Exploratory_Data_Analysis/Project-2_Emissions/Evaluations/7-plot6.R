# Loads Library
library(ggplot2)

# Loads RDS
PM5 <- readRDS("summarySCC_PM25.rds")
PM5$year <- factor(PM5$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland
# Los Angeles County, California
MD.onroad <- subset(PM5, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(PM5, fips == '06037' & type == 'ON-ROAD')

# Aggregates
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by = list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

#pull the data together
DF <- as.data.frame(rbind(MD.DF, CA.DF))


# Create the plot
ggplot(data = DF, aes(x = year, y = Emissions)) + 
  geom_bar(aes(fill = year),stat = "identity") + 
  guides(fill = F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + 
  xlab('Year') + 
  theme(legend.position = 'none') + 
  facet_grid(. ~ City) + 
  geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

ggsave(file="plot6.png")