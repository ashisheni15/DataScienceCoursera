# Read data files
# read national emissions data

NEI <- readRDS("summarySCC_PM25.rds")

#explore the NEI data
str(NEI)
dim(NEI)
head(NEI)

NEI$year <- as.factor(NEI$year)

#Store the sum of Emission data of each year
total.Emissions <- aggregate(NEI$Emissions,by=list(NEI$year),sum)
names(total.Emissions) <- c("Year","Emissions")

#Saving the plot as png

png("Plot1.png")

#Plotting the Total emission for each year
x <- barplot(height=total.Emissions$Emissions/1000, names.arg=total.Emissions$Year,
        xlab="Years",
        ylab=expression('Total PM'[2.5]*' emission (in kilotons)'),
        ylim=c(0,8000),
        main=expression('Total PM'[2.5]*' emissions at various years'),
        col= c("purple","red", "green", "blue"))
text(x = x, y = round(total.Emissions$Emissions/1000,2),
     label = round(total.Emissions$Emissions/1000,2), pos = 3, cex = 1, col = "black")

#Saving the plotted object as PNG
dev.off()
