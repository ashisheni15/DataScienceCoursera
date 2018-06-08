# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")

#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)

NEI$year <- as.factor(NEI$year)

#Store the sum of Emission data of each year
Baltimore.Emissions <- aggregate(NEI[which(NEI$fips=="24510"),]$Emissions,
                             by=list(NEI[which(NEI$fips=="24510"),]$year),sum)
names(Baltimore.Emissions) <- c("Year","Emissions")

#Saving the plot as png

png("Plot2.png")

#Plotting the Total emission for each year
x <- barplot(height=Baltimore.Emissions$Emissions, names.arg=Baltimore.Emissions$Year,
             xlab="Years",
             ylab=expression('Total PM'[2.5]*' emission'),
             ylim=c(0,4000),
             main=expression('Total PM'[2.5]*' emissions in Baltimore City'),
             col= c("green", "blue","purple","red"))
text(x = x, y = round(Baltimore.Emissions$Emissions,2),
     label = round(Baltimore.Emissions$Emissions,2), pos = 3, cex = 1, col = "black")

#Saving the plotted object as PNG
dev.off()
