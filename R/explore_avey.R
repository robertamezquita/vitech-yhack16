###################################################################################
## Explore Vitech data                                                           ##
###################################################################################
options(stringsAsFactors = FALSE)

##############
## Packages ##
##############
library(tidyr)
library(dplyr)
library(ggplot2)
library(scales)

tables <- c("participants", "policy_info", "activities")

###################
## Read in files ##
###################
participants <- read.delim("../data/participants.tsv")
str(participants)
policy_info <- read.delim("../data/policy_info.tsv")
str(policy_info)
activities <- read.delim("../data/activities.tsv")
str(activities)

########################
## Clean up Variables ##
########################
## Convert date strings to date objects
participants <- participants %>%
tbl_df() %>%
mutate(date_added = as.Date(substr(date_added, 1, 10)),
       dob = as.Date(substr(dob, 1, 10)))

policy_info <- policy_info %>%
tbl_df() %>%
mutate(policy_start_date = as.Date(substr(policy_start_date, 1, 10)))

activities <- activities %>%
tbl_df() %>%
mutate(activity_date = as.Date(substr(activity_date, 1, 10)))



###################################################################################
## Plot basic relationships over time                                            ##
###################################################################################

## PLot new subscriptions over time
ggplot(data = participants) +
geom_histogram(binwidth = 10, aes(x = date_added)) +
## stat_ecdf(aes(x = date_added)) +
scale_x_date(labels = date_format("%Y-%b"), breaks = date_breaks("1 month")) +
scale_y_log10() +
xlab("Date Added") +
ylab("New Plan Subscriptions") +
theme_bw() +
theme(axis.text.x  = element_text(angle=45, hjust = 1, vjust = 1))



## Major questions of interest are whether the campaigns are working
