#### Connecting to Google Analytics API via R
#### Uses OAuth 2.0
#### https://developers.google.com/analytics/devguides/reporting/core/v3/ for documentation

# Install devtools package & rga - This is only done one time
install.packages("devtools")
library(devtools)
install_github("rga", "skardhamar")


# Load rga package - requires bitops, RCurl, rjson
# Load lubridate to handle dates
library(rga)
library(lubridate)
# library(ProjectTemplate)
library(ggplot2)
setwd('C:/Users/m.parzakonis/Google Drive/MyCodeRants/GA/src')
# Authenticating to GA API. Go to https://code.google.com/apis/console/ and create
# an API application.  Don't need to worry about the client id and shared secret for
# this R code, it is not needed

# setwd('GA')
# load.project()
# If file listed in "where" location doesn't exist, browser window will open.
# Allow access, copy code into R console where prompted
# Once file located in "where" directory created, you will have continous access to
# API without needing to do browser authentication
# The next line is to cure the well known issue with rCurl, should be fixed in the next release
options(RCurlOptions = list(verbose = FALSE, capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))
rga.open(instance = "ga", where = "~/Documents/R/ga-api")

# Check that you do made a connection
ga$status()
