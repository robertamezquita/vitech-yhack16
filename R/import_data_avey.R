###################################################################################
## Download the Vitech data and write as flat files                              ##
###################################################################################
library(jsonlite)

urls <- c(participants = "https://v3v10.vitechinc.com/solr/participant/select?indent=on&q=*:*&wt=json&rows=1196000",
          policy_info = "https://v3v10.vitechinc.com/solr/policy_info/select?indent=on&q=*:*&wt=json&rows=1050000",
          activities = "https://v3v10.vitechinc.com/solr/activities/select?indent=on&q=*:*&wt=json&rows=7")

## Read in data from each URL into a list
dat_list <- lapply(urls, fromJSON)

## Write data to TSV files
lapply(names(dat_list), function(table)
  write.table(x = dat_list[[table]]$response$docs, file = paste0(table, '.tsv'),
              sep = '\t', quote = FALSE, row.names = FALSE))

