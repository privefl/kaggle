library(tidyverse)

# 185M rows
train_file <- "data/mnt/ssd/kaggle-talkingdata2/competition_files/train.csv"
system.time(
  train <- fread2(train_file)
) # 46 sec
pryr::object_size(train) # 7.4 GB

# 18.8M rows
test_file <- "data/test.csv"
system.time(
  test <- fread2(test_file)
) # 4 sec
pryr::object_size(test) # 600 MB

# 57.5M rows
test_sup_file <- "data/test_supplement.csv"
system.time(
  test_sup <- fread2(test_sup_file)
) # 13 sec
pryr::object_size(test_sup) # 1.85 GB

library(lubridate)
train.times    <- ymd_hms(train$click_time)
test.times     <- ymd_hms(test$click_time)
test_sup.times <- ymd_hms(test_sup$click_time)
## 27 GB used

range(train.times)
# "2017-11-06 14:32:21 UTC" "2017-11-09 16:00:00 UTC"
range(test.times)
# "2017-11-10 04:00:00 UTC" "2017-11-10 15:00:00 UTC"
range(test_sup.times)
# "2017-11-09 14:23:39 UTC" "2017-11-10 16:00:00 UTC"

length(test.times) / length(test_sup.times)

try_join <- inner_join(test, test_sup, by = names(test)[-1])
duplicates <- try_join %>%
  group_by(click_id.x) %>%
  filter(n() > 1)
