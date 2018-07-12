library(RTextTools)

train_input_file<-"v20-july5-2018-0835AM.csv"
test_input_file<-"v20-july4-2018-1449PM.csv"
output_file<-"demo-results.csv"

df<-read.csv(train_input_file,header=TRUE,sep=",",col.names=list("Feedback","Category"))
test_data<-read.csv(test_input_file,header=TRUE,sep=",",col.names=list("Feedback","Category"))

m<-create_matrix(df$Feedback,language="english",removeNumbers=TRUE,stemWords=TRUE,removeSparseTerms=.998,weighting=tm::weightTfIdf)
c<-create_container(m,df$Category,trainSize=1:307,virgin=FALSE)
t<-train_model(c,"SVM")
nm<-create_matrix(test_data$Feedback,language="english",removeNumbers=TRUE,stemWords=TRUE,removeSparseTerms=.998,weighting=tm::weightTfIdf,originalMatrix=m)
nc<-create_container(nm,test_data$Category,testSize=1:29,virgin=TRUE)

#results
results<-classify_model(nc,t)
write.csv(results,output_file)

#algorithms:
#
#"SVM"
#"MAXENT"
#"SLDA"
#"BOOSTING"
#"BAGGING"
