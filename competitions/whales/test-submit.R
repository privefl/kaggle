test_files <- list.files("data/test", full.names = TRUE)

library(dplyr)
frequent_ids <- count(fread2("data/train.csv"), Id, sort = TRUE)$Id[1:5]
paste(frequent_ids, collapse = " ")


data.frame(Image = basename(test_files), Id = paste(frequent_ids, collapse = " ")) %>%
  to_csv(file = "try_submit.csv") %>%
  kaggle_submit(message = "Try submission via API (+ browse)")

