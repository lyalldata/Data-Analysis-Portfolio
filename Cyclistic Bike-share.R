#install packages and library
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(lubridate)
library(readr)

#check the working directory
getwd()
#setting new path to access files
setwd("/Users/gurilyall/Downloads/green/Cyclic_data/divvy_tripdata_2022/csv_files")

# read files for the project
jan_01<- read.csv("202201_divvy_tripdata.csv")
feb_02<- read.csv("202202-divvy-tripdata.csv")
mar_03<- read.csv("202203-divvy-tripdata.csv")
apr_04<- read.csv("202204-divvy-tripdata.csv") 
may_05<- read.csv("202205-divvy-tripdata.csv")
jun_06<- read.csv("202206-divvy-tripdata.csv")
jul_07<- read.csv("202207-divvy-tripdata.csv")
aug_08<- read.csv("202208-divvy-tripdata.csv")
sep_09<- read.csv("202209-divvy-tripdata.csv")
oct_10<- read.csv("202210-divvy-tripdata.csv")
nov_11<- read.csv("202211-divvy-tripdata.csv")
dec_12<- read.csv("202212-divvy-tripdata.csv")

#checking head
colnames(jan_01)
colnames(feb_02)
colnames(mar_03)
colnames(apr_04)
colnames(may_05)
colnames(jun_06)
colnames(jul_07)
colnames(aug_08)
colnames(sep_09)
colnames(oct_10)
colnames(nov_11)
colnames(dec_12)

# Checking data type
str(jan_01)
str(feb_02)
str(mar_03)
str(apr_04)
str(may_05)
str(jun_06)
str(jul_07)
str(aug_08)
str(sep_09)
str(oct_10)
str(nov_11)
str(dec_12)


# check if the col names in each df are same. 
# Where applicable change names of the col names. 
# It would help when all df bind together for further analysis

#binding all df under all_trips
all_trips<- bind_rows(jan_01,feb_02,mar_03,apr_04,may_05,jun_06,jul_07
                      ,aug_08,sep_09,oct_10,nov_11,dec_12)

#checking colnames
colnames(all_trips)

#to check the number of rows
nrow(all_trips)

# checking dimensions of the df
dim(all_trips)

# checking data type
str(all_trips)

# to check all contents of member_casual
table(all_trips$member_casual)

# to create seprate rows for days, months
all_trips$date<- as.Date(all_trips$started_at)
all_trips$month<- format(as.Date(all_trips$started_at),"%m")
all_trips$day<- format(as.Date(all_trips$started_at),"%d")
all_trips$year<- format(as.Date(all_trips$started_at),"%Y")
all_trips$day_of_the_week <- format(as.Date(all_trips$date),"%A")

# to calculate the duration of the rent period.

all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

#inspect the structure of the colunms.
str(all_trips)

# to change the "ride_length" from factor to numeric
all_trips$ride_length<- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# calculating bike usage b/w casual and annual members
# Removing bad data from the "ride length" data frame.
# removing negative time calculated data.
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]

# to check stats on ride length in seconds
summary(all_trips_v2$ride_length_secs)

#to dig deeper with max seconds
all_trips_v2 %>% filter(ride_length_secs == 2483235)


# To conduct a Descriptive Analysis
# Calculation mean, median, max, min and comparison b/w membersV/s Casual users
mean(all_trips_v2$ride_length) #straight average
median(all_trips_v2$ride_length) # mid point number in the ascending array
min(all_trips_v2$ride_length) # shortest ride
max(all_trips_v2$ride_length)# longest ride

# to condense the four calculation in one line
summary(all_trips_v2$ride_length)

#Comparing Casual V/s members
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN= mean)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN= median)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN= min)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual,FUN= max)

# To see the rider time by each day of the week
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual+all_trips_v2$day
          ,FUN = mean)

# to adjust the order of the weeks.
all_trips_v2$day_of_the_week<- ordered(all_trips_v2$day_of_the_week,levels = c("Sunday"
                              ,"Monday","Tuesday","Wednesday","Thursday", "Friday","Saturday"))

# run average time by eachday
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual+all_trips_v2$day_of_the_week,FUN = mean)

# analyzing ridership data by type and weekday
all_trips_v2 %>% 
  mutate(weekday =wday(started_at, label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides = n()
  #calculates  the number of riders and average duration
  ,average_duration = mean(ride_length)) %>% 
   arrange(member_casual,weekday)

# export data for further analysis
write.table(all_trips_v2,file = "AnalysisReady_cyclistic.csv",sep=",")
# check the empty cells/elements in the columns
data.frame(colSums(is.na(all_trips_v2)))
#-------------------------------------------------------------------------------------------------------
# VISUALIZE AVERAGE DURATION BY WEEKDAY
all_trips_v2 %>% 
  mutate(weekday = wday(started_at,label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides = n()
            ,average_ride_duration = mean(ride_length)) %>% 
  arrange(member_casual,weekday) %>% 
  ggplot(aes(x=weekday,y=average_ride_duration,fill = member_casual))+geom_col(position = "dodge")+
  labs(title = "Casual Vs. Members: Average Ride Duration", subtitle = "frequency by weekday")

# VISUALIZE MEMBER_CASUAL TREND MONTHLY
all_trips_v2 %>% 
  group_by(member_casual,month) %>% 
  summarise(number_of_rides = n(),options("scipen"=10, "digits"=5)
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual,month) %>% 
  ggplot(aes(x=month,y=number_of_rides, fill= member_casual))+
  geom_col(position = "dodge")+ labs(title= "Members Vs Casual: Rides by month")

# VISUALIZE TYPE OF BIKES (RIDEABLE TYPE) USED BY MEMBER_CASUAL
casual<- all_trips_v2$member_casual=="casual"
all_trips_v2 %>% 
  group_by(member_casual,year) %>% 
  reframe(type_of_bikes = n()
            ,type_of_users = str_length(all_trips_v2$rideable_type)) %>% 
  arrange(rideable_type, member_casual) %>% 
  ggplot(mapping=aes(x = year,y=type_of_users, fill=member_casual))+
  geom_col(position = "dodge")+labs(title = "Member Vs. Casual: Ride type")

# VISUALIZE RIDE_LENGTH DURATION BY MEMBER_CASUAL
# VISUALIZE COUNT OF BIKES USED BY MONTH & WEEK (HEATMAP)
# VISUALIZE COUNT OF BIKES BY EACH TYPE(PIE CHART)
# VISUALIZE TRENDS IN MONTHS BY MAX WEEK


#counts<- aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual+all_trips_v2$day_of_the_week,FUN = mean)
#write.csv(counts,file = "~/Users/gurilyall/Downloads/green/Cyclic_data/divvy_tripdata_2022/avg_ride_length.csv")