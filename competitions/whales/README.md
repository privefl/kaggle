# Competition

[Humpback Whale Identification Challenge: can you identify a whale by the picture of its fluke?](https://www.kaggle.com/c/whale-categorization-playground)


## Evaluation

See https://www.kaggle.com/c/whale-categorization-playground#evaluation.

Basically, submit 5 labels for each entry, with most certain predictions coming first (see http://fastml.com/what-you-wanted-to-know-about-mean-average-precision/).

## Strategies

### Cleaning

- Remove weird images?

- Remove duplicates?

- Remove whales with not enough entries?

### Training

- Classification problem? Reported as bad

- Answer "have I seen this whale before?" 

- Siamese networks, wtfit?

- Try `h2o.automl`


## Remarks

- There are also many duplicates of the training data images in the test set, over 2000 or so.

- 0.32 corresponds to submitting just new_whale for all test images.

## Easier challenges

> If you're new to neural networks, I'd start with Digits, then Dog Breed, and then Whale. That will give you progressively harder challenges to work with.