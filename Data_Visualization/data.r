install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
library(dplyr, ggplot2, tidyr);

#Importing the data set
port_data <- read.csv("Cleaned_Border_Crossing_Entry_Data.csv");

#Total traffic in 2023 and 2022

# Calculate the total traffic crossed in 2023
data_in_2023 <- filter(port_data, grepl("2023", Date))
total_traffic_2023 <- sum(data_in_2023$Value)
  
# Calculate the total traffic crossed in 2022  
data_in_2022 <- filter(port_data, grepl("2022", Date))
total_traffic_2022 <- sum(data_in_2022$Value)


#Port with most overall traffic
total <- port_data %>%
  group_by(Port.Name, State) %>%
  summarise(Total_Traffic = sum(Value)) %>%
  arrange(desc(Total_Traffic))

# Extract the port with the highest overall traffic
port_with_highest_traffic <- total$Port.Name[1]





# The traffic value for each year
port_data_copy <- port_data

# Extract the year from the "Date" column without modifying the original data
port_data_copy <- mutate(port_data_copy, Year = as.numeric(substring(Date, regexpr("\\d{4}", Date))))

# Group by year and summarize total traffic for each year
total_traffic_by_year <- port_data_copy %>%
  group_by(Year) %>%
  summarize(Total_Traffic = sum(Value))

# Print the total traffic for each year
print(total_traffic_by_year)


#traffic by state
state_traffic <- port_data %>%
  group_by(State) %>%
  summarize(Total_Traffic = sum(Value))

# Rank the states based on total traffic
ranked_states <- state_traffic %>%
  arrange(desc(Total_Traffic))

# Print or view the ranked states
print(ranked_states)


#sesonal observation
library(ggplot2)
library(tidyr)

date_table <- port_data_copy %>%
  separate(port_data_copy$Date, into = c("Month", "Year"), sep = " ")
