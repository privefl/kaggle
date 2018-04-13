library(kaggler)
library(tidyverse)
library(lubridate)
# 185M rows
train_file <- "data/mnt/ssd/kaggle-talkingdata2/competition_files/train.csv"
data <- fread2(train_file, select = 6)
dates <- ymd_hms(data$click_time)
