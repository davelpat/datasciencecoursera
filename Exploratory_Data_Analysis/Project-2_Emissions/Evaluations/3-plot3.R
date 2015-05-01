NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
plotbaltsrc <- ggplot(neibal,aes(factor(year),Emissions,fill=type)) +
  facet_grid(.~type,scales = "free",space="free")+
  theme_bw()+
  guides(fill=FALSE)+
  geom_bar(stat="identity")+
  labs(x="year", y=expression("PM2.5 emissions (Tons)"))  +
  labs(title=expression(" Baltimore total PM2.5 emissions "))
print(plotbaltsrc)