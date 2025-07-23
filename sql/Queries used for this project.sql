# Number Of Observations
SELECT count(*) FROM trip_data.divvy_trips_2019_cleaned;

# Number Of Rides By User Type
SELECT usertype, COUNT(*) AS ride_count,ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY usertype;

#Average Ride Length by User Type
SELECT 
  usertype,
  ROUND(AVG(ride_length), 2) AS avg_ride_length_minutes,
  COUNT(*) AS total_rides
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY usertype;

# Ride Count by Day of Week (Customer vs Subscriber)
SELECT 
  day_of_week,
  usertype,
  COUNT(*) AS ride_count
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY day_of_week, usertype
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'), usertype;

#Shows peak usage hours Subsribers vs. Customers
SELECT 
  start_hour,
  usertype,
  COUNT(*) AS ride_count
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY start_hour, usertype
ORDER BY start_hour, usertype;

#Shows peak usage hours across day_of_week for Subsribers vs. Customers
SELECT 
  day_of_week,
  start_hour,
  usertype,
  COUNT(*) AS ride_count
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY day_of_week, start_hour, usertype
ORDER BY 
  FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
  start_hour, 
  usertype;
  
  # Rides by Month
  SELECT month, usertype, COUNT(*) AS ride_count
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY month, usertype
ORDER BY month, usertype;

# Seasonal Usage Trend
SELECT 
  season,
  usertype,
  COUNT(*) AS ride_count,
  ROUND(AVG(ride_length), 2) AS avg_ride_length
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY season, usertype
ORDER BY season, usertype;

#Top 7 most common station-to-station routes per user type
SELECT *
FROM (
  SELECT 
    usertype,
    from_station_name,
    to_station_name,
    COUNT(*) AS ride_count,
    ROW_NUMBER() OVER (
      PARTITION BY usertype 
      ORDER BY COUNT(*) DESC
    ) AS `row_num`
  FROM trip_data.divvy_trips_2019_cleaned
  GROUP BY usertype, from_station_name, to_station_name
) AS ranked
WHERE row_num <= 7
ORDER BY usertype, ride_count DESC;

#Top 7 Starting Stations per user type
WITH ranked_start_stations AS (
  SELECT
    usertype,
    from_station_name AS starting_station,
    COUNT(*) AS ride_count,
    ROW_NUMBER() OVER (
      PARTITION BY usertype
      ORDER BY COUNT(*) DESC
    ) AS `rank`
  FROM
    trip_data.divvy_trips_2019_cleaned
  GROUP BY
    usertype, from_station_name
)

SELECT
  usertype,
  starting_station,
  ride_count
FROM
  ranked_start_stations
WHERE
  `rank` <= 7
ORDER BY
  usertype,
  `rank`;

# Weekday vs. Weekend Behavior
SELECT 
  usertype,
  CASE 
    WHEN day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS ride_period,
  COUNT(*) AS ride_count,
  ROUND(AVG(ride_length), 2) AS avg_ride_length
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY usertype, ride_period;

# Age Distribution by User Type
SELECT 
  usertype,
  FLOOR(age / 10) * 10 AS age_group,
  COUNT(*) AS rider_count
FROM trip_data.divvy_trips_2019_cleaned
WHERE age IS NOT NULL
GROUP BY usertype, age_group
ORDER BY age_group, usertype;

#Gender Distribution by User Type
SELECT usertype, gender, COUNT(*) AS count
FROM trip_data.divvy_trips_2019_cleaned
GROUP BY usertype, gender;  
