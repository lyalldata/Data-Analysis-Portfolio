# Cyclistic Bike-Sharing Case Study

## Background
This case study is based on Google's Data Analyst Capstone Project. This project focuses on a company called Cyclistic. Under this licensing, Motivate International Inc. made the public bike-sharing dataset available for this project for the purpose of research and study. To dive deeper in the details, check the [Google Data Analytics Certification Capstone page](https://www.coursera.org/professional-certificates/google-data-analytics).

## About Cyclistic
In 2016, Cyclistic launched a successful bike-sharing offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system at any time. 

Until now, Cyclistic's marketing strategy relied on building general awareness and appealing to broad consumer segments. One approval that helped make these decisions possible was the flexibility of its pricing plans: single ride passes, full and annual memberships. Customers who purchase single-ride or full-day passes are referred to as "Casual" riders. Customers who purchase annual memberships are Cyclistic "Members".

Cyclistic's finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of Cyclistic for their mobility needs.

## Goal of the Organization
The Director of Marketing has set a goal for the future: Design marketing strategies aimed at converting casual riders into annual members. To do that, however, the marketing analyst team needs to better understand:

1. How annual members and casual riders differ?
2. Why casual riders would buy a membership?
3. How digital media could affect their marketing tactics?

Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

Here is a link for the [PowerPoint](#) that is based on the data and its analysis. The presentation shows the story of the project along with the ease of access to the visualizations to understand the insights to make data-driven decisions for the organization.

## Stakeholders
- **Lily Moreno**: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
- **Cyclistic marketing analytics team**: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic's mission and business goals – as well as how you, as a junior data analyst, can help Cyclistic achieve them.
- **Cyclistic executive team**: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.

## Project Procedure
To meet the goals of the organization, the pathway used in this case study is as follows:
1. Act
2. Prepare
3. Process
4. Analyze
5. Share
6. Act

## Ask
### What is the Problem?
How do annual members and casual riders use Cyclistic bikes differently?

### How to solve the problem?
By analyzing the provided data and understanding the trends.

### Who are the stakeholders?
1. Moreno (Director)
2. Cyclistic executive team
3. Cyclistic marketing analytics team

### Where will the data be collected?
Internal/Marketing Team

To perform an analysis of the most recent year for this study, 2022 is chosen to study and understand the trends and patterns. The data is provided by Motivate International Inc. as a part of the Google Data Analyst Certification.

## Prepare
In this stage, all the data is collected from the provided channels, identified, renamed, protected, and organized in a manner to make sure the data is unbiased.

### Step 1: Data Source
The data is collected from the public bike-sharing datasets. This dataset was provided by Motivate International Inc. under the license. The data is available on the website "Index of bucket", and the files on the website are named "divvy-tripdata" ending with the year and either numbered as months or quarters. Quarters are named as "Q1Q2" and "Q3Q4".

### Data Collection:
The most recent data to work with is 2022. The files for the year 2022 are created according to their respective months and these files are available in `.zip` format. Download the `.zip` file for each month and save it in `.csv` format. Store all the files locally in one place and rename the dataset to organize it appropriately.

#### Uploading datasets to Kaggle:
After organizing the datasets, it’s time to upload them to Kaggle. Click on "File" and select "Upload data". Select all datasets to upload to Kaggle and name the dataset. All the files will show up in the tab on the right side of the screen.

### Step 2: Checking the Metrics and Measures of the Datasets
This study is identifying the differences between the users’ groups of the Cyclistic bike-sharing company. The provided data categorizes the users of the bicycles into two groups: Annual members and Casual riders. To study the behavior and trends of both user types, there are some main categories to help understand the data.

- **Bike usage**:
  1. Average frequency
  2. Average duration
  3. User bike type preference
- **Time-varying preference**:
  1. Busiest day of the week
  2. Busiest month of the year by user type and trip duration
- **Location-based preference**:
  1. Most popular/frequent start and end station
  2. Least popular/frequent start and end station

## Process
In this phase, the data gets cleaned. Any errors or inaccuracies that could get in the way of the result are eliminated. One of the important steps in the "process" phase is transforming the data into a more useful format, creating more complete information, and removing outliers.

### Step 3: Setup the Analysis Environment
Set up the analysis environment by loading the important packages and libraries to clean the data and check for errors.

#### Loading Files on Kaggle:
Once the working environment is set, read files and rename them appropriately. The data is saved as the first three letters of the month followed by "_" to connect the month to its numeric value.

#### Checking the Consistency of the Data:
After loading the file, check the column names and structure of the dataset to ensure there are no errors or mistakes.

#### Merging All the Data in One Dataset:
Bind all months in one dataframe as "all_trips" to work collectively on the whole data group. NOTE: Make sure to check the column names before joining the dataset. If required, change the column names to match the header.

### Step 4: Cleaning the Data
It’s convenient to separate the date, month, year, and day of the week into independent columns. Separating the data now will come in handy for analyzing monthly, date, and day-of-week data.

#### Calculating the Length of Rides:
To calculate the length of the rides, use data from "started_at" and "ended_at" to calculate the time difference with the `difftime` function.

#### Removing Bad Time Data:
There are instances when Cyclistic tests the bikes, which result in data entries that are either "0" or have a negative value. This step will eliminate that data to avoid problems and confusion.

## Analyze
In this part of the project, calculations are performed to analyze the differences in trends for each day of the week, month, and ride length of its respective users.

### Step 6: Descriptive Analysis
In this step, we will dive into details and check the outliers from the data.

- Mean: 19.33 mins
- Median: 10.3 mins
- Min: 0 mins
- Max: 28.7 days
- IQR duration: 5.8 mins (1st Qu.) - 18.5 mins (3rd Qu.)

## Share
In this phase, all the summaries of the analysis are shared with the stakeholders. The data is interpreted in the form of visualizations to help and understand the data in a convenient and effective way.

Here is a link for the [PowerPoint](#) that is based on the data and its analysis.

### Monthly Use of Bikes by Casual and Members:
- January-February: The lowest count of each user type.
- Frequency and duration for each user type trend up, peaking in July for casual riders and in August for members.
- In the second half of the year, the trend goes downward for both users, but the count of members is almost double that of casual riders.

## Act
The final stage of the analysis is to derive conclusions and take actions by recommending solutions based on the problem statement and results. The goal of the organization is to maximize the annual memberships and increased ride durations to earn profits. The analysis is used to make data-driven decisions.

### Business and Analysis Team Insights:
From the summary of the analysis, the marketing team will develop an ad campaign to convert casual riders into annual riders and attract new riders to the Cyclistic bike share service.

# Cyclistic Bike-Sharing Case Study

# Cyclistic Bike-Sharing Case Study

## Project Overview

This project aims to analyze data from Cyclistic, a bike-sharing company, to design marketing strategies that will convert casual riders into annual members and maximize company profits.

## Recommendations

### 1. **Promotional Offers for Casual Riders**
- **Goal:** Encourage consistent use of the service during weekdays.
- **Strategy:** Introduce special weekday offers to casual riders to normalize usage and convert them to annual members.

### 2. **One-Week Free Trial**
- **Goal:** Provide casual riders with a full experience of the membership benefits.
- **Strategy:** Offer a one-week free trial during peak summer months to attract both new users and convert existing casual riders to annual subscriptions.

### 3. **Referral Program**
- **Goal:** Increase word-of-mouth marketing and user base.
- **Strategy:** Launch a referral program where annual members earn points for each friend or colleague they invite. Points can be redeemed for free rides with time and distance limits.

### 4. **Post-Trial Survey**
- **Goal:** Gather insights to refine strategies.
- **Strategy:** After the free trial, send a survey to casual riders to understand their experience and expectations, which will help improve services and conversion tactics.

### 5. **Mobile Application Features**
- **Goal:** Improve user engagement and convenience.
- **Strategy:** Develop a mobile app with features like:
  - Social competitions (compete with friends/family).
  - Route tracking and ride history.
  - Secure payment options.
  - A calorie meter to track calories burned during rides.
  - Fitness integration for personalized cycling plans.

### 6. **Discounts During Slow Hours**
- **Goal:** Balance usage throughout the day.
- **Strategy:** Offer discounts during non-peak hours to encourage casual riders to use the service during quieter times.

### 7. **Health & Environmental Campaign**
- **Goal:** Promote the health and environmental benefits of bike-sharing.
- **Strategy:** Design a campaign to emphasize the role of bike-sharing in reducing carbon emissions and promoting a healthy lifestyle.

### 8. **Machine Learning for Personalized Recommendations**
- **Goal:** Increase bike usage with personalized suggestions.
- **Strategy:** Use machine learning to identify users’ most frequent destinations and recommend bike-sharing as a time-efficient alternative to driving.

### 9. **Social Media Campaigns**
- **Goal:** Increase brand visibility and attract new riders.
- **Strategy:** Create targeted campaigns on Instagram, TikTok, Facebook, and YouTube to engage users and promote Cyclistic's benefits.

## Conclusion

Successfully pitching new strategies to Cyclistic requires data-backed recommendations. This project outlines effective marketing plans to drive membership growth and usage, helping Cyclistic maximize profits while enhancing user experience.

Thank you for reviewing the recommendations!
