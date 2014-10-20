setwd("./GitHub/Figure_Exp2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
sum(is.na(NEI$Emission))

motor <- SCC[(grep("Vehicles", SCC$"SCC.Level.Three")),c("SCC", "SCC.Level.Three", "EI.Sector")]
motorlist <- motor[,1]

motordata <- NEI[NEI$SCC %in% motorlist, ]
head(motordata)
summary(motordata)
summary(NEI)

twocity <- motordata[(motordata$fips %in% c("24510", "06037")),]
head(twocity)


df <- aggregate(twocity$Emission, by=list(twocity$year, twocity$fips), FUN=sum)
head(df)
colnames(df) <- c("Year","City", "Emission")
df$City <- gsub("24510", "Baltimore City", df$City)
df$City <- gsub("06037", "Los Angeles County", df$City)

png("plot6.png", width = 480, height = 480)
library(ggplot2)
p <- ggplot(df, aes(x=Year, y=Emission, color=City))+ geom_line() + geom_point(size=2)
p + ggtitle("Total PM2.5 Emission By City)")
p + xlab("Year") + ylab("PM2.5 Emission (Tons)")
dev.off()
