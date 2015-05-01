ssccomb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
ssccoal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
scccombcoal <- (ssccomb & ssccoal)
neicomb <- NEI[NEI$SCC %in% SCC[scccombcoal,]$SCC,]

library(ggplot2)

ccplot <- ggplot(neicomb,aes(factor(year),Emissions/1000)) +
  guides(fill=FALSE) + geom_bar(stat="identity") +
  theme_bw() +  
  labs(x="year", y=expression("PM2.5 Emissions (thousands of tons)")) + 
  labs(title=expression("PM2.5 Combustion and coal emissions in U.S."))
print(ccplot)