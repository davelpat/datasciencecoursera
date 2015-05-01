# Load Library GG Plot
library(ggplot2)

# Read RDS files.
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Coal-related SCC
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merges two data sets
merge <- merge(x = PM25, y = SCC.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')


#Plot the graph using GGPLOT
ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000)) + 
  geom_line(aes(group = 1, col = Emissions)) + 
  geom_point(aes(size = 2, col = Emissions)) + 
  ggtitle(expression('Total Emissions of PM'[2.5])) + 
  ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
  geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
  theme(legend.position = 'none') + 
  scale_colour_gradient(low = 'black', high = 'red')

ggsave(file="plot4.png")