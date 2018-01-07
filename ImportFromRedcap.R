# devtools::install_github("hatemhosny/REDCapR")
library(REDCapR)

# REDCap API URI
uri <- "http://redcap.ahc-research.com/redcap/api/"

# REDCap Token (stored as environment variable in C:\Users\hatem\Documents\.Renviron")
token <- Sys.getenv("AHC_REDCAP_TOKEN")

desired_records <- c(1, 4)

ds_some_rows <- redcap_read_oneshot(
  redcap_uri   = uri,
  token        = token,
  raw_or_label = "label",
  raw_or_label_headers = "label"
)$data
