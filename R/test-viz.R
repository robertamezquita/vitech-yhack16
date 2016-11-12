## Load in entire dataset
load("data/insurance_data.RData")

library(tidyverse)
library(lubridate)


head(policy_info)
head(participants)


pp <- full_join(participants[, c("id", "first_name", "middle_name", "last_name",
                                 "dob", "gender", "marital_status",
                                 "city", "state", "zip",)]
policy_info,
                by = c("id" = "participant_id"))


