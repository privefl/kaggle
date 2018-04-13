train_file <- "data/mnt/ssd/kaggle-talkingdata2/competition_files/train.csv"
data <- fread2(train_file, nrows = 10e6)
pryr::object_size(data)

AUC <- bigstatsr::AUC

library(tidyverse)
library(lubridate)
data %>%
  filter(attributed_time != "") %>%
  pull(is_attributed) %>%
  mean()
n_distinct(data$ip)
mean(data$is_attributed)
n_distinct(data$ip)
count(data, ip, sort = TRUE) %>%
  pull(n) %>%
  summary()

# devtools::install_github("ropenscilabs/skimr")
skimr::skim(data)

# Can have IPs different values for categorial variables?
dates <- lubridate::ydm_hms(data$click_time)
dates[1:5]
range(dates)

data %>%
  group_by(ip) %>% 
  summarise(n = n(), status = mean(is_attributed)) %>%
  ggplot(aes(n, status)) + 
  geom_point() + 
  scale_x_log10() +
  scale_y_log10()

data2 <- data %>%
  mutate(click_time = ydm_hms(click_time)) %>%
  group_by(ip) %>%
  arrange(click_time) %>%
  mutate(click_num = seq_along(click_time))

click_num_when_attributed <- data2 %>% 
  # select(-app, -device, -os, -channel) %>%
  filter(is_attributed == 1) %>% 
  pull(click_num)

tab_to_vec <- function(tab) {
  ind <- as.integer(names(tab))
  bool <- (min(ind) == 0)
  tab2 <- rep(0, max(ind) + bool)
  tab2[ind + bool] <- tab
  tab2
}

tab <- table(click_num_when_attributed)
tab2 <- tab_to_vec(tab)
N <- sum(tab2)
(p <- N / sum(tab2 * (seq_along(tab2))))

(p <- tab2[1] / N)
plot(tab2, p * (1 - p)^(seq_along(tab2) - 1), pch = 20)
plot(p * (1 - p)^(seq_along(tab2) - 1), pch = 20)

AUC(data2$click_num, data2$is_attributed)
bigstatsr::AUCBoot(data2$click_num, 1 - data2$is_attributed, nboot = 20)
ggplot(data2, aes(p * (1 - p)^(click_num - 1), is_attributed)) +
  geom_point()

abline(0, 1, col = "red")
tab3 <- tab_to_vec(tab)[1:5000]
plot(log(tab3))
plot(1 / sum(tab3 * (seq_along(tab3) - 1)))

plot(1 / (cummean(click_num_when_attributed + 0))[1:12000], pch = 20, log = 'y')
length()

tmp <- rgeom(100000, 0.2)
tmp2 <- tab_to_vec(table(tmp))
length(tmp) / sum(tmp2 * (seq_along(tmp2)))


tmp <- rgeom(100000, 0.2) + 1
tmp2 <- tab_to_vec(table(tmp))
length(tmp) / sum(tmp2 * (seq_along(tmp2)))
