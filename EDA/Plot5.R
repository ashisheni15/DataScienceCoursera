# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")

#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)
table(NEI$type)

NEI$year <- as.factor(NEI$year)

#Store the sum of Emission data of each year
Baltimore.motor.Emissions <- aggregate(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="24510")),]$Emissions,
                                       by=list(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="24510")),]$year),sum)

names(Baltimore.motor.Emissions) <- c("Year","Emissions")


#Import ggplot2 library for plotting
library(ggplot2)

#Plotting the Emission data of each year of each type
ggplot(Baltimore.motor.Emissions,aes(x=Year,y=Emissions, fill= Year, label= round(Emissions,2))) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" emission (in tons)")) +
  ggtitle(expression("PM"[2.5]*" emissions from motor vehicle sources in Baltimore City")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill = Year), colour = "white",cex= 5, fontface = "bold")

ggsave("Plot5.png",width = 10, height = 8)
