'''
Code for cleaning and plotting the Star Wars Survey Data from Fivethirtyeight. 
Authors: Devyn Escalanti
University of Central Florida 
Email: dtescalanti@gmail.com
'''

df<-read.csv("iouzipcodes2011.csv", header = TRUE, comment.char = '#', sep = ",")

# Produce a new dataset with the five energy companies from Florida -------
fl <- df[which(df$state=='FL'),]

# Summarize the average residential, commercial, and industry  --------
library(dplyr)

#industry rates 
ind.ave <-
  fl %>% group_by(utility_name) %>% #grouping dataset by electric company
  summarize(amount = sum(ind_rate)) #summarizing based on relevant variable

#residential rate 
res.ave<- fl  %>% group_by(utility_name) %>%
  summarize(amount=sum(res_rate))

#commercial average 
comm.ave<- fl  %>% group_by(utility_name) %>%
  summarize(amount=sum(comm_rate))
  
# Merging dataset (prep for trellis bar plots) -----------------------------
res.ave$type <- c("Residential") #creating a label 
comm.ave$type <- c("Commercial")
ind.ave$type <- c("Industry")

ave <- rbind(res.ave , comm.ave) #merging dataset by rows
ave <- rbind(ave , ind.ave)

# Produce a trellis bar plot ------------------------------------------
  
barchart(amount ~ utility_name | type, data = ave,
         groups = utility_name, main = "Florida Energy Supply, by Power Company and Sector",
         xlab = "Electric Company", ylab = "Energy Supply Rate", stack = TRUE,
         auto.key = list(space = "right"),
         scales = list(x = list(rot = 70)))

