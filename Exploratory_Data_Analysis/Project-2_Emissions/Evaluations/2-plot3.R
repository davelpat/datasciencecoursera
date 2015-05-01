library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
#subset the rows for Baltimore City, Maryland
bcNEI=NEI[ NEI$fips == "24510", ]

png("plot3.png")

ggpl <- ggplot(bcNEI,aes(x=factor(year),y=Emissions)) +
  geom_bar(stat="identity", width=0.7) +
  facet_grid(.~type) +
  labs(x="year", y="Total PM 2.5 Emission (Tons)") +
  labs(title="PM 2.5 Emissions, Baltimore City 1999-2008 by Source Type")

print(ggpl)
dev.off()