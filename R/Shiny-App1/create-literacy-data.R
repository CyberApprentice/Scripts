setwd("C:/")
#setwd("M:/School/Spring 2021 - Advanced R Programming/Literacy Project 2")

# Creating Shiny ----
a<-read.csv("API_SE.ADT.1524.LT.FE.ZS_DS2_en_csv_v2_2252509/API_SE.ADT.1524.LT.FE.ZS_DS2_en_csv_v2_2252509.csv", skip=4, stringsAsFactors = F)
b<-read.csv("API_SE.ADT.1524.LT.FM.ZS_DS2_en_csv_v2_2252511/API_SE.ADT.1524.LT.FM.ZS_DS2_en_csv_v2_2252511.csv", skip=4, stringsAsFactors = F)
c<-read.csv("API_SE.ADT.1524.LT.MA.ZS_DS2_en_csv_v2_2252512/API_SE.ADT.1524.LT.MA.ZS_DS2_en_csv_v2_2252512.csv", skip=4, stringsAsFactors = F)
d<-read.csv("API_SE.ADT.1524.LT.ZS_DS2_en_csv_v2_2252513/API_SE.ADT.1524.LT.ZS_DS2_en_csv_v2_2252513.csv", skip=4, stringsAsFactors = F)
e<-read.csv("API_SE.ADT.LITR.FE.ZS_DS2_en_csv_v2_2252514/API_SE.ADT.LITR.FE.ZS_DS2_en_csv_v2_2252514.csv", skip=4, stringsAsFactors = F)
f<-read.csv("API_SE.ADT.LITR.MA.ZS_DS2_en_csv_v2_2252517/API_SE.ADT.LITR.MA.ZS_DS2_en_csv_v2_2252517.csv", skip=4, stringsAsFactors = F)
g<-read.csv("API_SE.ADT.LITR.ZS_DS2_en_csv_v2_2252065/API_SE.ADT.LITR.ZS_DS2_en_csv_v2_2252065.csv", skip=4, stringsAsFactors = F)

#Remove 'X' from column names
colnames(a) <- gsub("X", "", colnames(a))
colnames(b) <- gsub("X", "", colnames(a))
colnames(c) <- gsub("X", "", colnames(a))
colnames(d) <- gsub("X", "", colnames(a))
colnames(e) <- gsub("X", "", colnames(a))
colnames(f) <- gsub("X", "", colnames(a))
colnames(g) <- gsub("X", "", colnames(a))

#Remove the last 2 empty columns because they're blank
a = a[-c(65:66)]
b = b[-c(65:66)]
c = c[-c(65:66)]
d = d[-c(65:66)]
e = e[-c(65:66)]
f = f[-c(65:66)]
g = g[-c(65:66)]

# Merge it
literacyData = rbind(a, b, c, d, e, f, g)

# Clean it
library(reshape2)
literacyData = melt(literacyData)
literacyData = literacyData[-c(5:14)]

#Save
save(literacyData, file="literacy-data.RData")
