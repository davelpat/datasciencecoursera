# uses ggplot
library(ggplot2)

# Loads RDS
# PM25 <- readRDS("summarySCC_PM25.rds")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland == fips
# MD <- subset(PM25, fips == '24510')
MD <- subset(NEI, fips == '24510')
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))


diagram <- ggplot(data = MD, aes(x = year, y = log(Emissions))) + 
  facet_grid(. ~ type) + 
  guides(fill = F) + 
  geom_boxplot(aes(fill = type)) + 
  stat_boxplot(geom = 'errorbar') + 
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + 
  xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') + 
  geom_jitter(alpha = 0.10)  

ggsave(file="7-plot3.png")