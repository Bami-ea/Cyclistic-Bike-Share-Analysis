# Cyclistic-Bike-Share-Analysis
This project analyzes how **Cyclistic Bike-Share** members and casual riders used bikes in 2019, and suggests how the company can convert more casual riders into annual subscribers.

##  Project Overview

**Main Goal:**  
To explore the differences in riding behavior between **annual members** and **casual riders** — and to identify **data-driven opportunities** for Cyclistic to grow membership.

---

##  Research Questions

- How do members and casual riders differ in terms of ride duration, timing, and frequency?
- Which stations are most popular for each user type?
- Are there *loyal casual riders* whose behavior is similar to members?
- How can these insights help design **targeted conversion strategies**?

---

##  Tools & Technologies

- **R:** Data cleaning, outlier removal, data organization, `member-like casuals` analysis
- **SQL (MySQL):** Data storage, data organization, aggregated summaries
- **Tableau:** Interactive dashboards and visual storytelling
- **Google Sheets:** Geocoding station locations (Google Maps API)

---

##  Key Insights

 **Peak Hours & Days:**  
- Members dominate weekday commute hours (8 AM & 5 PM).  
- Casual riders prefer weekends and midday trips.

 **Ride Duration:**  
- Casual riders take longer trips on average (39.4 mins) vs. members (12.9 mins).

 **Seasonal Trends:**  
- Usage drops for both groups in winter, but some casuals continue riding.

 **Member-like Casuals:**  
- Identified **493 casual riders** whose behavior mirrors members — these are strong candidates for conversion.

 **Top Starting Stations:**  
- Casual riders mostly start at scenic, recreation-friendly locations; members cluster around commuter rail hubs, dense business districts, and live-work neighborhoods.
- ⁠⁠The pattern shows casuals are likely tourists & locals out for scenic, seasonal leisure rides, while members mostly use the service for daily commuting and last-mile connections between transit and workplaces.


---

##  Recommendations

- **Target “winter-riding casuals”** with personalized offers to become annual members.
- Promote memberships during seasonal drop-offs to convert loyal casuals.
- Focus marketing at the top casual starting stations.
- Offer incentives for longer rides to encourage habitual usage.

---

##  Dashboard Preview

[Dashboard Screenshot] <img width="1034" height="685" alt="Cyclistic Bike Share" src="https://github.com/user-attachments/assets/eaa46681-6685-45cf-b0d6-37b2a3dc6304" />


 [View the full interactive Tableau dashboard here](https://public.tableau.com/views/CyclisticBikeShare_17519964294240/Dashboard1?:language=en-GB&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)  

---

## 📂 Explore the full dataset, Tableau, R & SQL scripts

- [Download Cleaned Dataset (ZIP, 84MB)](https://github.com/Bami-ea/Cyclistic-Bike-Share-Analysis/blob/main/data/Divvy_Trips_2019_Cleaned.csv.zip)
- [Explore R Scripts](https://github.com/Bami-ea/Cyclistic-Bike-Share-Analysis/tree/404bb661e2a6178bafd8306610221649353627eb/R)
- [View SQL Scripts](https://github.com/Bami-ea/Cyclistic-Bike-Share-Analysis/tree/main/sql)
- [Tableau workbook & screenshots](https://github.com/Bami-ea/Cyclistic-Bike-Share-Analysis/tree/343192a605f80f45cdc61e5e9364e8304d23209e/dashboard)

---


## **Files**

| File/Folder | Description |
|--------------------------|------------------------------------------------|
| [`/data`](./data) | `Divvy_Trips_2019_Cleaned.csv.zip`, `top_starting_stations.csv,`casual_member_like.csv` |
| [`/R`](./R) | `cleaning_script.R` — data cleaning & preparation; `member_like_casuals_analysis.R` — segmenting casuals |
| [`/sql`](./sql) | `Queries used for this project` |
| [`/dashboard`](./dashboard) | `Cyclistic_Bike_Share.twbx` — Tableau workbook & screenshots |
| [`README.md`](./README.md) | Project overview, key findings & recommendations |

---

##  About Me

Hi, I’m **Ayobami Ayoade**, a data analyst passionate about using data to drive business strategy.  
Let’s connect on [LinkedIn](https://www.linkedin.com/in/ayobamzi/)

---

##  Contact

Questions? Suggestions? Open an issue or [email me](ayobami.ayoade@yahoo.com).

---

**#RStats #SQL #Tableau #BikeShare #PortfolioProject #DataAnalytics**
