# Rename columns to match the correct structure
colnames(Divvy_Trips_2019_Q2) <- c(
  "trip_id",
  "start_time",
  "end_time",
  "bikeid",
  "tripduration",
  "from_station_id",
  "from_station_name",
  "to_station_id",
  "to_station_name",
  "usertype",
  "gender",
  "birthyear"
)
# Confirm the change
colnames(Divvy_Trips_2019_Q2)

#Check for Missing Values for all datasets
colSums(is.na(Divvy_Trips_2019_Q4))
summary(Divvy_Trips_2019_Q4)

# Fill missing gender with "unknown" and fill missing birthyear with "NA" for all datasets 
Divvy_Trips_2019_Q4$gender[is.na(Divvy_Trips_2019_Q4$gender)] <- "unknown"
Divvy_Trips_2019_Q4$birthyear[is.na(Divvy_Trips_2019_Q4$birthyear)] <- "NA"

# Check duplicates in each quarter Q1,Q2,Q3,Q4
sum(duplicated(Divvy_Trips_2019_Q1))  
sum(duplicated(Divvy_Trips_2019_Q2))  
sum(duplicated(Divvy_Trips_2019_Q3))  
sum(duplicated(Divvy_Trips_2019_Q4)) 

# To removes duplicate rows from the Divvy_Trips_2019_Q1 dataset.
Divvy_Trips_2019_Q1 <- Divvy_Trips_2019_Q1[!duplicated(Divvy_Trips_2019_Q1), ]

# To view only the duplicated rows:
duplicated_rows <- Divvy_Trips_2019_Q1[duplicated(Divvy_Trips_2019_Q1), ]
head(duplicated_rows)

# To see every copy of duplicated rows (not just those after the first), you can do:
all_duplicates <- Divvy_Trips_2019_Q1[duplicated(Divvy_Trips_2019_Q1) | duplicated(Divvy_Trips_2019_Q1, fromLast = TRUE), ]
head(all_duplicates)

# To delete or drop a data frame (table) from memory
rm(duplicated_rows)
exists(duplicated_rows)

# Convert to datetime for all quarterly datasets
Divvy_Trips_2019_Q1$start_time <- as.POSIXct(Divvy_Trips_2019_Q1$start_time, format="%Y-%m-%d %H:%M:%S")
Divvy_Trips_2019_Q1$end_time   <- as.POSIXct(Divvy_Trips_2019_Q1$end_time, format="%Y-%m-%d %H:%M:%S")

Divvy_Trips_2019_Q2$start_time <- as.POSIXct(Divvy_Trips_2019_Q2$start_time, format="%Y-%m-%d %H:%M:%S")
Divvy_Trips_2019_Q2$end_time   <- as.POSIXct(Divvy_Trips_2019_Q2$end_time, format="%Y-%m-%d %H:%M:%S")

Divvy_Trips_2019_Q3$start_time <- as.POSIXct(Divvy_Trips_2019_Q3$start_time, format="%Y-%m-%d %H:%M:%S")
Divvy_Trips_2019_Q3$end_time   <- as.POSIXct(Divvy_Trips_2019_Q3$end_time, format="%Y-%m-%d %H:%M:%S")

Divvy_Trips_2019_Q4$start_time <- as.POSIXct(Divvy_Trips_2019_Q4$start_time, format="%Y-%m-%d %H:%M:%S")
Divvy_Trips_2019_Q4$end_time <- as.POSIXct(Divvy_Trips_2019_Q4$end_time, format="%Y-%m-%d %H:%M:%S")

#To confirm Data Type
str(Divvy_Trips_2019_Q4$start_time)
str(Divvy_Trips_2019_Q4$end_time) 

# Load dplyr package
library(dplyr)

# Create new time-based columns for Q1
Divvy_Trips_2019_Q1 <- Divvy_Trips_2019_Q1 %>%
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(start_time),
    month = format(start_time, "%m"),
    start_hour = format(start_time, "%H"),
    end_hour = format(end_time, "%H")
  )

# Repeat for Q2
Divvy_Trips_2019_Q2 <- Divvy_Trips_2019_Q2 %>%
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(start_time),
    month = format(start_time, "%m"),
    start_hour = format(start_time, "%H"),
    end_hour = format(end_time, "%H")
  )

# Repeat for Q3
Divvy_Trips_2019_Q3 <- Divvy_Trips_2019_Q3 %>%
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(start_time),
    month = format(start_time, "%m"),
    start_hour = format(start_time, "%H"),
    end_hour = format(end_time, "%H")
  )

# Repeat for Q4
Divvy_Trips_2019_Q4 <- Divvy_Trips_2019_Q4 %>%
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(start_time),
    month = format(start_time, "%m"),
    start_hour = format(start_time, "%H"),
    end_hour = format(end_time, "%H")
  )

library(dplyr)

# Merge all quarters into one dataset
Divvy_Trips_2019 <- bind_rows(
  Divvy_Trips_2019_Q1,
  Divvy_Trips_2019_Q2,
  Divvy_Trips_2019_Q3,
  Divvy_Trips_2019_Q4
)

# To View the structure or first few rows
str(Divvy_Trips_2019)
head(Divvy_Trips_2019)

# Convert tripduration to minutes, so both metrics are comparable:(To check how different they are)
Divvy_Trips_2019 <- Divvy_Trips_2019 %>%
  mutate(tripduration_mins = tripduration / 60,
         duration_diff = abs(tripduration_mins - ride_length)) %>%
  arrange(desc(duration_diff))

head(Divvy_Trips_2019[Divvy_Trips_2019$duration_diff > 1, ])

# Count original number of rows
original_count <- nrow(Divvy_Trips_2019)

# Filter out outliers
Divvy_Trips_2019_cleaned <- Divvy_Trips_2019 %>%
  filter(
    ride_length >= 0,
    ride_length <= 1440
  )

# Count cleaned rows
cleaned_count <- nrow(Divvy_Trips_2019_cleaned)

# Calculate number of removed rows
removed_rows <- original_count - cleaned_count

# Print results
cat("Original rows:", original_count, "\n")
cat("Cleaned rows:", cleaned_count, "\n")
cat("Removed rows:", removed_rows, "\n")

colnames(Divvy_Trips_2019_cleaned)

#Remove Unuseful columns
Divvy_Trips_2019 <- Divvy_Trips_2019_cleaned %>%
  select(-trip_id, -bikeid, -tripduration,
         -from_station_id, -to_station_id,
         -tripduration_mins, -duration_diff)

#creating date and age columns
Divvy_Trips_2019 <- Divvy_Trips_2019_cleaned %>%
  mutate(
    trip_date = as.Date(start_time),       # Extract just the date part
    age = 2025 - as.numeric(birthyear)     # Calculate age from birth year
  )

# Creating Season columns 
Divvy_Trips_2019 <- Divvy_Trips_2019 %>%
  mutate(
    season = case_when(
      month %in% c("12", "01", "02") ~ "Winter",
      month %in% c("03", "04", "05") ~ "Spring",
      month %in% c("06", "07", "08") ~ "Summer",
      month %in% c("09", "10", "11") ~ "Fall",
      TRUE ~ NA_character_
    )
  )

# Creating Column Weekday_Vs_Weekend
Divvy_Trips_2019$weekday_vs_weekend <- ifelse(Divvy_Trips_2019$day_of_week %in% c("Saturday", "Sunday"),
                                              "Weekend", "Weekday")
# Columns Reorder
Divvy_Trips_2019 <- Divvy_Trips_2019 %>%
  select(
    start_time, end_time,trip_date, start_hour, end_hour,day_of_week, month, 
    season,weekday_vs_weekend, ride_length, usertype,from_station_name, to_station_name,
    gender, birthyear, age)

getwd()

# Export the cleaned dataset
write.csv(Divvy_Trips_2019,"Divvy_Trips_2019_Cleaned.csv", row.names = FALSE)


