library(ggplot2)
library(dplyr)

# load the data

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds") not needed in this plot

# calculate emissions for each year in Baltimore City grouped by type

NEI_bc <- subset(NEI, NEI$fips=="24510")
NEI_bc_t <- summarise(group_by(NEI_bc,year,type),Emissions=sum(Emissions))

# generate a panel plot showing the change for each emission type 

png(filename="plot3.png",width=800,height=480)

cust_labeller <- function(var,val)
{
  lab <- as.character(val)
  if (var=="type")
  {
    lab[val=="NON-ROAD"] <- "nonroad"
    lab[val=="NONPOINT"] <- "nonpoint"
    lab[val=="ON-ROAD"] <- "onroad"
    lab[val=="POINT"] <- "point"
  }
  lab   
}

g <- ggplot(NEI_bc_t, aes(year,Emissions))
p <- g+geom_point()+facet_grid(.~type,labeller=cust_labeller)+
  geom_smooth(method="lm",se=F)+
  ggtitle("PM2.5 Emissions in Baltimore City by Type")+
  labs(x="Year",y="Emissions (tons)") + 
  ylim(0, max(NEI_bc_t$Emissions))
print(p)

dev.off()