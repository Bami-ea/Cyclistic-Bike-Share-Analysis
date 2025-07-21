
library(dplyr)
install.packages("lubridate")

library(lubridate)


# Get top 10 member routes
top_routes <- Divvy_Trips_2019_cleaned %>%
  filter(usertype == "Subscriber") %>%
  group_by(from_station_name, to_station_name) %>%
  summarise(route_count = n()) %>%
  arrange(desc(route_count)) %>%
  slice_head(n = 10)

# Add time and weekday info
casual_member_like <- Divvy_Trips_2019_cleaned %>%
  filter(usertype == "Customer") %>%
  mutate(
    hour = hour(start_time),
    weekday = wday(start_time, label = TRUE),
    month = month(start_time, label = TRUE)
  ) %>%
  filter(
    hour %in% c(8, 17),
    weekday %in% c("Mon", "Tue", "Wed", "Thu", "Fri"),
    month %in% c("Dec", "Jan", "Feb")
  ) %>%
  inner_join(top_routes, by = c("from_station_name", "to_station_name"))

# See a sample of potential conversions
head(casual_member_like)

# Count how many unique trips match
nrow(casual_member_like)


write.csv(casual_member_like,"casual_member_like.csv", row.names = FALSE)