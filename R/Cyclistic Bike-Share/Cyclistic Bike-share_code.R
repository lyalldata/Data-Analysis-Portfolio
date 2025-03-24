#checking working directory
getwd()
#setting path to a new "input" directory to read files
setwd("/Users/gurilyall/Downloads/data/Cyclic_data_raw_data/divvy_tripdata_2022/csv_files")

#checking directory before moving to next step
getwd()

# Start the timer
start_time <- Sys.time()

# Task (for example, a sleep of 5 seconds)
Sys.sleep(5)

# installing the required packages and libraries
install.packages("tidyverse")
install.packages("ggmap")
library(ggplot2)# visualize data
library(tidyverse) # transform the data
library(lubridate) # to work with the dates
library(readr) # to read files
library(scales) # process % 
library(tidytext)
library(formattable)
library(dplyr)
library(forcats)  # Load the forcats package
library(gridExtra)

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

# running colnames to check the column names in each dataset
# make sure all the colnames match with each and every table. 
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

# Checking str() for each month to check the data structure. 
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

#binding all datasets under "all_trips"
all_trips<- bind_rows(jan_01,feb_02,mar_03,apr_04,may_05,jun_06,jul_07,aug_08,sep_09,oct_10,nov_11,dec_12)

# to call the top 5 top rows
head(all_trips)

# calling all the columns 
colnames(all_trips)

# checking the number of rows
nrow(all_trips)

# checking dimensions of the dataframe
dim(all_trips)

# checking  data types/ structure
str(all_trips)

# checking the summary of the data
summary(all_trips)

# checking count of members and casusal riders
table(all_trips$member_casual)

# creating independent columns from started_at
all_trips$date<- as.Date(all_trips$started_at)
all_trips$month<- format(as.Date(all_trips$started_at),"%m")
all_trips$day<- format(as.Date(all_trips$started_at),"%d")
all_trips$year<- format(as.Date(all_trips$started_at),"%Y")
all_trips$day_of_the_week<- format(as.Date(all_trips$started_at),"%A")

# calculating the ride_lenght of each trip
all_trips$ride_length<- difftime(all_trips$ended_at,all_trips$started_at)

#inspecting the structure of the columns
str(all_trips$ride_length)

# to change the "ride_length" from factor to numeric
all_trips$ride_length<- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

#calculating bike usage between casual & annual members.
# Removin bad data from the "ride_lenght" data frame.
# to be specific removing data with negative time.
all_trips_v2<- all_trips[!(all_trips$start_station_name == "HR QR"| all_trips$ride_length < 0),]

# Summary of the dataset
summary(all_trips_v2)

# comparing casual v/s members
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual, FUN = min)
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual, FUN = max)

# to see the rider time by eah day of the week
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual+all_trips_v2$day,FUN= mean)

# to calculate descriptive analysis
mean(all_trips_v2$ride_length) # straight mean
median(all_trips_v2$ride_length) # mid point number in the assending array
min(all_trips_v2$ride_length) # Shortest ride
max(all_trips_v2$ride_length) # longest ride


#Summary of the data
summary(all_trips_v2$ride_length)

# max ride_length case
all_trips_v2%>% filter (ride_length == 2483235)

# getting stats and comparing casual and member's data
cas_vs_mem<- all_trips_v2%>%
  group_by(member_casual)%>%
  summarise(number_of_rides = n(),
            "Comparison_by_rides(%)"= percent(n()/nrow(all_trips_v2))# new col for comparison by number of rides by each group. 
            ,total_duration = sum(ride_length)
            , "trip_by_durtion" = percent(sum(ride_length)/sum(all_trips_v2$ride_length))# new col for sum of ride duration by each group.
            ,average_duration = mean(ride_length) #mean ride_length
            ,min_duration = min(ride_length) #min ride_length
            ,max_duration = max(ride_length) #max ride_length
            ,std_duration = sd(ride_length)) # sd ride_length
cas_vs_mem


# checking the member_casual data by month
member<- all_trips_v2 %>% 
  filter(member_casual == "member")
member_monthly<- member%>%        
  group_by(month) %>% 
  summarise(number_of_rides = n(),average_duration = mean(ride_length),total_duration = sum(ride_length),ride_percent = n()/nrow(member) ,duration_percent = sum(ride_length)/sum(member$ride_length))
member_monthly

casual<- all_trips_v2%>%
  filter(member_casual == "casual")
casual_monthly<- casual%>%
  group_by(month)%>%
  summarise(number_of_riders = n(),average_duration = mean(ride_length),total_duration = sum(ride_length),ride_percentage = n()/nrow(casual) ,duration_percent = sum(ride_length)/sum(casual$ride_length))
casual_monthly

# organising the data by name of the days of the week
all_trips_v2$day_of_the_week<- ordered(all_trips_v2$day_of_the_week, levels= c("Sunday","Monday","Tuesday","Wednesday","Thurday","Friday","Saturday"))

#checking mean of each day for the entire year
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual +all_trips_v2$day_of_the_week,FUN=mean)

# checking the bije preferance for the members and causal riders
bike_preferance <- all_trips_v2%>% 
  group_by(member_casual,rideable_type)%>%
  summarise(number_of_rides = n(),
            .groups = "drop")
bike_preferance[nrow(bike_preferance)+1,]=list("member","docked_bike",0)
bike_preferance


# checking the working directory
getwd()

#Visualization for Casual Vs Members by Month
all_trips_v2 %>%
  group_by(member_casual, month) %>%
  summarise(
    number_of_rides = n(),options("scipen"=10, "digits"=5),
    average_duration = mean(ride_length),
    .groups = "drop"  # Add this line to ungroup the data
  ) %>%
  arrange(member_casual, month) %>%
  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Members Vs Casual: Rides by month")

# saving the visualization
ggsave = (file="MembervsCasual_by_month.PNG")

# weekdays comparison for the whole year
all_trips_v2 %>% 
  mutate(weekday = wday(started_at,label = TRUE)) %>% 
  group_by(member_casual,weekday) %>% 
  summarise(number_of_rides = n()
            ,average_ride_duration = mean(ride_length),
            .groups = "drop"
  ) %>% 
  arrange(member_casual,weekday) %>% 
  ggplot(aes(x=weekday,y=average_ride_duration,fill = member_casual))+geom_col(position = "dodge")+
  labs(title = "Casual Vs. Members: Average Ride Duration", subtitle = "frequency by weekday")

# saving the output
ggsave = ( file ="MembervsCasual_by_weekday.PNG")

# Pie Chart of rides percentage
p1 <- ggplot(data = cas_vs_mem, aes(x = "", y = number_of_rides, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  theme_void()+
  geom_text(aes(label = scales::percent(number_of_rides/sum(number_of_rides))),
            color = "black", size = 6, position = position_stack(vjust = 0.5)) +
  labs(title = "Rides by User Type",
       subtitle = "Member Vs. Casual: Percentage of Rides by User Type",
       caption = "Cyclistic Bike Share (2022)")
p1

# Create the polar bar chart using the cas_vs_mem data frame
p2 <- ggplot(data = cas_vs_mem, aes(x = "", y = total_duration, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  theme_void() +
  geom_text(aes(label = scales::percent(total_duration/sum(all_trips_v2$ride_length))),
            color = "black", size = 6, position = position_stack(vjust = 0.5)) +
  labs(title = "Ride Total Duration",
       subtitle = "Member Vs Casual: Total Duration by User Type",
       caption = "Cyclistic Bike Share (2022)")

p2

#saving the visualization
ggsave = (file=g1 = "Member_vs_Casual_usage_by_percentage.PNG")
ggsave = (file=g2 = "Member_vs_Casual_usage_by_ride_duration.PNG")

# Bike preferance between the casual and members
bike_preferance %>%
  mutate(member_casual = as.factor(member_casual)) %>%
  ggplot(aes(x = rideable_type, y = number_of_rides/100000, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", show.legend = TRUE) +
  labs(title = "Member Vs. Casual Riders: Bike Preference",
       subtitle = "Count by Ride Type",
       caption = "Cyclistic Bike-share (2022)",
       x = "Rideable Type",
       y = "Count",
       fill = "User Type")

# saving as a output
ggsave = (file = "MembervsCasual_by_bike_preferance.PNG")

# End the timer
end_time <- Sys.time()

# Calculate the time difference
time_taken <- end_time - start_time

# Print the result
print(paste("Time taken:", time_taken))