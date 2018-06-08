# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)

NEI$year <- as.factor(NEI$year)

#
#Exploring the SCC data
str(SCC)
head(SCC)

levels(SCC$EI.Sector)

#creating the logical vector based on coal combustion
combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)

#Subsetting the SCC data having only those row with coal combustion
scc.data <- SCC[combustion.coal,c("SCC","EI.Sector")]

#Merging the NEI data and scc.data based on  SCC

Emission.coal <- merge(NEI,scc.data,by.x = "SCC")
head(Emission.coal)

#Store the sum of Emission data of each year
total.Emissions.coal <- aggregate(Emission.coal$Emissions,by=list(Emission.coal$year),sum)

names(total.Emissions.coal) <- c("Year","Emissions")


#Import ggplot2 library for plotting
library(ggplot2)

#Plotting the Emission data of each year of each type
ggplot(total.Emissions.coal,aes(x=Year,y=Emissions/1000, fill= Year, label= round(Emissions/1000,2))) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" emission (in kilotons)")) +
  ggtitle(expression("PM"[2.5]*" emissions from coal combustion-related sources")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill = Year), colour = "white",cex= 5, fontface = "bold")

ggsave("Plot4.png",width = 10, height = 8)
