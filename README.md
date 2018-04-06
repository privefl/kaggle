# kaggler

Kaggle challenges: helper package + code


## [Kaggle API](https://github.com/Kaggle/kaggle-api)

```r
# Update pip
system("python -m pip install --upgrade pip")

# Get the command line 'kaggle'
system("pip install kaggle")

# Then try running
system("kaggle config view")
```

To use the Kaggle API, go to the 'Account' tab of your Kaggle profile and select 'Create API Token'. This will trigger the download of `kaggle.json`, a file containing your API credentials. Place this file in the location that was given by the previous command.

For your security, ensure that other users of your computer do not have read access to your credentials. On Unix-based systems you can do this with the following command: `system("chmod 600 ~/.kaggle/kaggle.json")`.

## Use of this package

### Register competition and download data

```r
# Always use this package
library(kaggler)
add_pkg_to_rprofile("kaggler")

# Find you competition and add it as a global variable
kaggle_data()
add_competition_to_rprofile(YOUR_COMPETITION)

# Download data (and unzip zip files) in data/
kaggle_data()
```

### Submit

Use `kaggle_submit()`.
