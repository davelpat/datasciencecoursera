vhcl <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
neivhcl <- NEI[NEI$SCC %in% SCC[vhcl,]$SCC,]
neivhclbalt  <- neivhcl[neivhcl$fips==24510,]

library(ggplot2)
ggp <- ggplot(neivhclbalt,aes(factor(year),Emissions)) +
  guides(fill=FALSE) +
  geom_bar(stat="identity") +
  theme_bw() +  
  labs(x="year", y=expression("PM2.5 emissions (Tons)")) + 
  labs(title=expression("PM2.5 vehicles emissions in Baltimore"))
print(ggp)