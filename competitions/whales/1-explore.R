library(tidyverse)

first_imgs <- list.files("data/train", full.names = TRUE)[1:50 + 150]

tmp <- map(first_imgs, ~magick::image_read(.x)) %>%
  do.call('c', .)
pryr::object_size(tmp)
tmp

img1 <- "data/train/00022e1a.jpg"
img2 <- "data/train/000466c4.jpg"
magick::image_read(img1)
magick::image_read(img2)

library(tidyverse)
test <- fread2("data/train.csv")
count(test, Id, sort = TRUE)[-1, ] %>%
  ggplot() +
  geom_histogram(aes(n), binwidth = 1)

test
# 9850 -> 2808
test %>%
  group_by(Id) %>%
  filter(n() > 5)
