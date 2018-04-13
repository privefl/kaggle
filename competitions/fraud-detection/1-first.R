## Need to get the probability of being a bot
## and also the rank of the click (modified/linearized)

library(kaggler)
library(tidyverse)
library(lubridate)
train_file <- "data/mnt/ssd/kaggle-talkingdata2/competition_files/train.csv"
data <- fread2(train_file, nrows = 1e6)
pryr::object_size(data)

AUC <- bigstatsr::AUC

data2 <- data %>% 
  select(-attributed_time) %>%
  mutate(
    click_time = ydm_hms(click_time),
    click_hour = hour(click_time)
  ) %>%
  arrange(click_time) %>%
  group_by(ip) %>%
  mutate(
    click_num = seq_along(click_time),
    mean_time = mean(diff(click_time)),
    n = n()
  )

p <- mean(data2$click_num[data2$is_attributed == 1] == 1)
data3 <- data2 %>%
  ungroup() %>%
  select(-ip, -click_time) %>%
  mutate(click_p = (1 - p)^click_num) %>%
  mutate_at(c("app", "device", "os", "channel"), as.factor)

n <- nrow(data3)
skimr::skim(data3)

ind.train <- sort(sample(n, 0.1 * n))
ind.test <- setdiff(seq_len(n), ind.train)
system.time(
  mod <- glm(is_attributed ~ ., data = data3, subset = ind.train, family = "binomial")
)

pred <- predict(mod, data3)

ggplot(data2, aes(click_time, fill = as.factor(is_attributed))) +
  geom_density(alpha = 0.4)
ggplot(data2, aes(n, fill = as.factor(is_attributed))) +
  geom_density(alpha = 0.4) + 
  xlim(NA, 200)

data2 %>%
