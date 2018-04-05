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

To use the Kaggle API, go to the 'Account' tab of your Kaggle profile and select 'Create API Token'. This will trigger the download of `kaggle.json`, a file containing your API credentials. Place this file in the location that was given in the previous command.

For your security, ensure that other users of your computer do not have read access to your credentials. On Unix-based systems you can do this with the following command: `chmod 600 ~/.kaggle/kaggle.json`.
