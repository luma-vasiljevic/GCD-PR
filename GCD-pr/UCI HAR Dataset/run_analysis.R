#read files

#common files
features=read.table("features.txt")
activity_labels=read.table("activity_labels.txt")

#train files
X_train=read.table("train/X_train.txt")
y_train=read.table("train/y_train.txt")
subject_train=read.table("train/subject_train.txt")

#test files
X_test=read.table("test/X_test.txt")
y_test=read.table("test/y_test.txt")
subject_test=read.table("test/subject_test.txt")

#create one data frame

X=rbind(X_train,X_test)
y=rbind(y_train,y_test)
subject=rbind(subject_train, subject_test)

data0=data.frame(cbind(subject,y,X))
names=c("subject","act_label",as.character(features[,2]))
colnames(data0) <- names

act_lab=data.frame(activity_labels)
colnames(act_lab)=c("label","activity")

data = merge(act_lab,data0, by.y="act_label",by.x="label") #creae descriptive activity names
write.table(data, "data.txt") # write to the txt file

tidy = aggregate(data[,4:564], by = c(data["activity"],data["subject"]),FUN="mean") # create teh tidy data set
write.table(tidy, "tidy.txt") # write to the txt file

# extract columns with mean & std

mean_std=grep("mean|std",colnames(data)) #find the mean/std columns

mean_std_data = data[,c(1:3,mean_std)]
write.table(mean_std_data, "mean_std.txt") # write to the txt file


