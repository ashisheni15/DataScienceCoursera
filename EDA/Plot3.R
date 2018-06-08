# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")

#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)

NEI$year <- as.factor(NEI$year)

#Store the sum of Emission data of each year
Baltimore.Emissions.type <- aggregate(NEI[which(NEI$fips=="24510"),]$Emissions,
                                 by=list(NEI[which(NEI$fips=="24510"),]$year,
                                         NEI[which(NEI$fips=="24510"),]$type),sum)
names(Baltimore.Emissions.type) <- c("Year","type","Emissions")

#Import ggplot2 library for plotting
library(ggplot2)

#Plotting the Emission data of each year of each type
ggplot(Baltimore.Emissions.type,aes(x=Year,y=Emissions, fill= type, label= round(Emissions,2))) +
  geom_bar(stat="identity") +
  facet_grid(.~ type) +
  xlab("Year") +
  ylab(expression("total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("PM"[2.5]*" emission in Baltimore City by various source types")) +
  geom_label(aes(fill = type), colour = "white",cex= 2.5, fontface = "bold")

ggsave("Plot3.png",width = 15, height = 12)
