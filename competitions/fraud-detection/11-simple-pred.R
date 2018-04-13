auc_boot <- function(pred, target, n = 20) {
  bigstatsr::AUCBoot(pred, target, nboot = n)
}

data <- train[nrow(train) - 0:1e6, ]
# data <- train[1:1e6, ]

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
  ) %>%
  group_by(click_hour) %>%
  mutate(p = n / n()) %>%
  ungroup()

data2 %>%
  ggplot(aes(p, fill = as.factor(is_attributed))) +
  geom_density(alpha = 0.4) +
  xlim(NA, 0.0001)

# Proportion of clicks per hour: 89% -> need to change way is computed
bigstatsr::AUCBoot(data2$p, 1 - data2$is_attributed, nboot = 20)
# Mean time between two clicks: 78%
bigstatsr::AUCBoot(data2$mean_time, data2$is_attributed, nboot = 20)

data2 <- data2 %>%
  mutate(
    der_prop = 0.6^click_num,
    mean_time = as.numeric(replace_na(mean_time, median(mean_time, na.rm = TRUE)))
  ) %>%
  mutate_at(c("app", "device", "os", "channel"), as.factor)


ind.train <- sample(nrow(data), size = 5e5)
system.time(
  mod <- glm(is_attributed ~ log(n) * log(click_num) * der_prop * mean_time +
               log(mean_time + 1), 
             data = data2, subset = ind.train, family = "binomial")
) # using catagorial variable 2 sec -> 278 sec
summary(mod)


preds <- predict(mod, data2, type = "response")
stopifnot(sum(is.na(preds)) == 0)
auc_boot(preds[-ind.train], data2$is_attributed[-ind.train])
# 79% with the beginning, 90% with the end

test2 <- test %>%
  group_by(ip) %>%
  mutate(n = n()) %>%
  ungroup()
  
test2$is_attributed <- predict(mod, test2, type = "response")
test2 %>%
  select(click_id, is_attributed) %>%
  data.table::fwrite(file = "submit1.csv", quote = FALSE, row.names = FALSE)

kaggle_submit("submit1.csv", "Try submission with only log(n)")
# Got 0.7657
 
count_ip <- count(test_sup, ip)
test3 <- left_join(test, count_ip, by = "ip")
test3
cor(log(test2$n), log(test3$n))



tmp <- log(data2$n)
tmp2 <- log(data2$n)
hist(tmp, col = scales::alpha("blue", 0.4))
hist(tmp2, add = TRUE, col = scales::alpha("red", 0.4))
