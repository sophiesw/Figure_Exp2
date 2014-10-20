setwd("./GitHub/Figure_Exp2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
sum(is.na(NEI$Emission))
Baldata <- NEI[(NEI$fips == "24510"),]
head(Baldata)
df <- aggregate(Baldata$Emission, by=list(Baldata$year), FUN=sum)
head(df)
colnames(df) <- c("Year","Emission")

png("plot2.png", width = 480, height = 480)
plot(df$Year, df$Emission, type="b", main ="Total PM2.5 Emission By Year (Baltimore City)",
     xlab="Year", ylab="PM2.5 Emission (Tons)", cex=0.5)
axis(side=1, at=seq(1999, 2008))
dev.off()

