setwd("./GitHub/Figure_Exp2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
sum(is.na(NEI$Emission))
Baldata <- NEI[(NEI$fips == "24510"),]
head(Baldata)
df <- aggregate(Baldata$Emission, by=list(Baldata$year, Baldata$type), FUN=sum)
head(df)
colnames(df) <- c("Year","Type", "Emission")
df$Type <- as.factor(df$Type)
png("plot3.png", width = 480, height = 480)
library(ggplot2)
p <- ggplot(df, aes(x=Year, y=Emission, color=Type))+ geom_line() + geom_point(size=2)
p + ggtitle("Total PM2.5 Emission for Each Type of Source (Baltimore City)")
p + xlab("Year") + ylab("PM2.5 Emission (Tons)")
dev.off()
