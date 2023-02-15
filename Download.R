# Sequencing and Alignments

## Part 1

#create vector of 3 IDs
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") 

#load rentrez package
library(rentrez)

#Download data from ncbi website. 
  ##nuccore is the name of the database. 
  ##ID is the name of our vector. 
  ##Rettype alters the format of our database into FASTA format.
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") 

#Use the strsplit() function on the Bburg object to create a new object called Sequences that contains 3 elements: one for each sequence 
Sequences <- strsplit(Bburg, ">")
Sequences <- Sequences[[1]][-1]

print(Sequences)

#Convert to data.frame
Sequences<-unlist(Sequences)

#Use regular expressions to separate the sequences from the headers
header<-gsub("(^.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

#Remove the newline characters from the Sequences data frame using regular expressions
Sequences$Sequence <- gsub("\n", "", Sequences$Sequence) 
print(Sequences)


#Output this data frame to a file called Sequences.csv.
write.csv(Sequences, "Sequences.csv", row.names = F)