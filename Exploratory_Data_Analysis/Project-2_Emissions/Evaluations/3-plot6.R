neivhclblt <- neivhcl[neivhcl$fips == 24510,]
neivhclblt$city <- "Baltimore"
neivhclla <- neivhcl[neivhcl$fips=="06037",]
neivhclla$city <- "Los Angeles"
neicity <- rbind(neivhclblt,neivhclla)

library(ggplot2)
ggp <- ggplot(neicity, aes(x=factor(year), y=Emissions, fill=city)) +
  guides(fill=FALSE) + theme_bw() +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) + 
  labs(x="year", y=expression(" PM2.5 Emission (thousands of Tons)")) + 
  labs(title=expression("PM2.5  vehicles   emissions in Baltimore and Los Angeles "))
print(ggp)