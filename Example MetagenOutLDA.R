##################################################################################
# Example of use of MetagenOutLDA
##################################################################################

#Clara Rodriguez-Casado, Toni Monle�n-Getino. Departament of Statistics (University of Barcelona, Spain)-7.2016


#MetagenOutlineLDa, a new R package designed to performs statistical analysis of metagenomic matrix with three functions /easy-to-use functions.
#It performs three basic tasks: estimation of the metagenomic profile of abundance and richness distribution of each patient using a nonlinear regression, 
#estimating different biodiversity index, and perform different discriminants analysis of the data, offering a percentage of correct classification


# 1-install previosly the following packages:
install.packages("rtiff") # conversión de archivo .ods a data frame
install.packages("proto") # paquete para el manejo y manipulación de data frames 
install.packages("MBESS") # visualización de datos multivariantes
install.packages("simpleboot") # manejo de colores para gráficos
install.packages("caret") # diversos análisis estad�?sticos
install.packages("rrlda") # análisis de distribuciones multinomiales
install.packages("mda") # análisis de distribuciones multinomiales
install.packages("kernlab") # análisis de distribuciones Dirichlet

#2-install MetagenOutLDA

#Example of use
library(MetagenOutLDA)
data("metAb") #Example of Chron disease on 19 subjects (12 health and 7 Chronh). The measures are log2(OTU). OTU (Operational taxonomic unit ).
head(metAb)
grupos<-rep(c(1,0),times=c(12,7))
# zzz1<-dmcmetagen(Mat=x,regres_type = 1,group=grupos,label_group=c("healthy","Crohn" ))
# x11()

#3-dmcmetagen: calculate the metagenomic distribution of abundance for each sample 
zzz1<-dmcmetagen(Mat=metAb,regres_type = 2,group=grupos,label_group=c("healthy","Crohn" ))
zzz1round<-round(zzz1,4)
zzz1Sal<-data.frame(B0=paste(zzz1round[,1],"(",zzz1round[,6],",",zzz1round[,7],")",sep=""),
           B1=paste(zzz1round[,2],"(",zzz1round[,8],",",zzz1round[,9],")",sep=""),
           B2=paste(zzz1round[,3],"(",zzz1round[,10],",",zzz1round[,11],")",sep=""),
           B3=paste(zzz1round[,4],"(",zzz1round[,12],",",zzz1round[,13],")",sep=""),
           Group=zzz1round[,14])

#4-dmcbiodiv: Calculate the biodiversity index for each sample
zzz2<-dmcbiodiv(Mat=metAb)

#5-Aggregate in a data-frame and add labels for each group
zzz3<-dmcTable(zzz1,zzz2,label_group=c("healthy","Crohn" ))
zzz3

#6-Generates a classification table, with the percentages of classification of different methods: LDA, QDA, RRLDA, MDA, SVM, etc. CV = Cross validation
zzz4<-dmcDA(zzz1,zzz2,label_group=c("healthy","Crohn" ))

#7-Save the results in a file .csv
write.table(zzz1,"salidaDmcMetagen.csv",sep=";",dec=",",row.names=F)
write.table(zzz2,"salidaDmcbiodiv.csv",sep=";",dec=",",row.names=F)
write.table(zzz3,"salidaDmcTable.csv",sep=";",dec=",",row.names=F)
write.table(zzz1Sal,"salidaDmcMetagen2.csv",sep=";",dec=",",row.names=F)



