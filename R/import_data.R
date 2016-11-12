## IMPORT DATA
## Download data from vitech challenge for YHack 2016
## utilizing the RESTful API that accesses data from a SOLR database
## source: https://v3v10.vitechinc.com/yhack/index.html

## -----------------------------------------------------------------------------
## Load libraries
library(jsonlite)
library(tidyverse)

## Tidying function for JSON input
tidy_solr <- function(x) {
    y <- x$response$docs
    return(y)
}

## -----------------------------------------------------------------------------
## Format RESTful requests

## URLS for data requests from SOLR
## Sliced into subsets for retrieval; &rows gives total rows to pull down
## See total rows in data with "numFound" from JSON output
REQUESTS_PARTICIPANTS <- list(
    PARTICIPANTS_FEMALE = 
        "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=gender=F&wt=json&rows=599881",
    PARTICIPANTS_MALE = 
        "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=gender=M&wt=json&rows=1019957")

REQUESTS_POLICY <- list(
    POLICY_DENTAL = 
        "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&wt=json&q=insurance_product:Dental&rows=1000000",
    POLICY_ACCIDENT =
        "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&wt=json&q=insurance_product:Accident&rows=50000")

REQUESTS_ACTIVITIES = list(
    ACTIVITIES =
        "https://v3v10.vitechinc.com/solr/activities/select?indent=on&q=*:*&wt=json")

## -----------------------------------------------------------------------------
## Raw to tidy to bound data

## Grab data from JSON objects/urls
## DAT <- lapply(REQUESTS, fromJSON)
RAW_PARTICIPANTS <- lapply(REQUESTS_PARTICIPANTS, fromJSON)
RAW_POLICY <- lapply(REQUESTS_POLICY, fromJSON)
RAW_ACTIVITIES <- lapply(REQUESTS_ACTIVITIES, fromJSON)

## Reformat requested data into a tidy-ish data frame
TDAT_PARTICIPANTS <- lapply(RAW_PARTICIPANTS, tidy_solr)
TDAT_POLICY <- lapply(RAW_POLICY, tidy_solr)
TDAT_ACTIVITIES <- lapply(RAW_ACTIVITIES, tidy_solr)

## Bind rows of datasets that have been sliced
DAT_PARTICIPANTS <- bind_rows(TDAT_PARTICIPANTS)
DAT_POLICY <- bind_rows(TDAT_POLICY)
DAT_ACTIVITIES <- bind_rows(TDAT_ACTIVITIES)


## -----------------------------------------------------------------------------
## Export datasets to JSON and RData formats

participants <- DAT_PARTICIPANTS
policy_info <- DAT_POLICY
activities <- DAT_ACTIVITIES

## Save data
save(participants, policy_info, activities,
     file = "data/insurance_data.RData")

## Export JSON
write(toJSON(participants), file = "data/participants.json")
write(toJSON(policy_info), file = "data/policy_info.json")
write(toJSON(activities), file = "data/activities.json")
