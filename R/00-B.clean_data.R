## Load in entire dataset
load("data/insurance_data.RData")

library(lubridate)

## Modify dates to be lubridated
participants$dob <- lubridate::as_date(participants$dob)
participants$date_added <- lubridate::as_date(participants$date_added)
policy_info$policy_start_date <- lubridate::as_date(policy_info$policy_start_date)
activities$activity_date <- lubridate::as_date(activities$activity_date)

## Note:
## Remove participant columns:
## - email, street_address, _version_, collection_id
## Munge:
## - telephone -> area_code
## Remove policy_info columns:
## - _version_, collection_id
## Remove activities columns:
## - _version_, 
## Rename:
## - participants$id -> participants$participant_id
## - policy_info$id -> policy_info$policy_id
## - activities$promocodes -> activities$promo_codes
## - activities$id -> activities$activity_id

participants <- participants %>%
    dplyr::select(-email, -street_address, -`_version_`, -collection_id) %>% 
    dplyr::mutate(area_code = substr(telephone, 1, 3)) %>%
    dplyr::select(-telephone) %>%
    dplyr::rename(participant_id = id)
    
policy_info <- policy_info %>%
    dplyr::select(-`_version_`, -collection_id) %>%
    dplyr::rename(policy_id = id)
    
activities <- activities %>%
    dplyr::select(-`_version_`) %>%
    dplyr::rename(promo_codes = promocodes, activity_id = id)

## Save cleaned data
save(participants, policy_info, activities,
     file = "data/insurance_data_clean.RData")


