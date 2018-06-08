# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")

#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)
table(NEI$type)

NEI$year <- as.factor(NEI$year)

#Store the sum of Emission data of each year of Baltimore City
Baltimore.motor.Emissions <- aggregate(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="24510")),]$Emissions,
                                       by=list(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="24510")),]$year),sum)

names(Baltimore.motor.Emissions) <- c("Year","Emissions")

#Store the sum of Emission data of each year of Los Angeles
Losangeles.motor.Emissions <- aggregate(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="06037")),]$Emissions,
                                       by=list(NEI[which((NEI$type=="ON-ROAD") & (NEI$fips=="06037")),]$year),sum)

names(Losangeles.motor.Emissions) <- c("Year","Emissions")

#Creating a data with year to calculate the percentage change from previous year

percnt.Chng.Baltimore <-as.data.frame(x= Baltimore.motor.Emissions$Year[2:4])
names(percnt.Chng.Baltimore) <- "Year"
percnt.Chng.Baltimore$County <- "Baltimore City"
percnt.Chng.Baltimore$Change <- NA

percnt.Chng.Losangeles <-as.data.frame(Losangeles.motor.Emissions$Year[2:4])
names(percnt.Chng.Losangeles) <- "Year"
percnt.Chng.Losangeles$County <- "Los Angeles"
percnt.Chng.Losangeles$Change <- NA


#Calculate the Percentage change from previous year

for(i in seq_along(percnt.Chng.Baltimore$Year)){
  percnt.Chng.Baltimore[i,]$Change <-
    ((Baltimore.motor.Emissions[i+1,]$Emissions - 
        Baltimore.motor.Emissions[i,]$Emissions)/
       Baltimore.motor.Emissions[i,]$Emissions)*100
  
  percnt.Chng.Losangeles[i,]$Change <-
    ((Losangeles.motor.Emissions[i+1,]$Emissions - 
        Losangeles.motor.Emissions[i,]$Emissions)/
       Losangeles.motor.Emissions[i,]$Emissions)*100
}

#Merging the both percentage data
Percnt.Change <- rbind(percnt.Chng.Baltimore,percnt.Chng.Losangeles)
#Import ggplot2 library for plotting
library(ggplot2)

#Plotting the Emission data of each year of each type
ggplot(Percnt.Change,aes(x=Year,y=Change, fill= Year, label= round(Change,2))) +
  geom_bar(stat="identity") +
  facet_grid(County~., scales="free") +
  xlab("Year") +
  ylab("Percentage change from Previous year") +
  ggtitle(expression("Percentage changes over time in motor vehicle emissions")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill = Year), colour = "white",cex= 5, fontface = "bold")

ggsave("Plot6.png",width = 10, height = 8)
