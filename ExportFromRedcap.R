ExportFromRedcap <- function(file) {

  cat("Exporting data from REDCap...", "\n")

  # REDCap API URI
  uri <- "http://redcap.ahc-research.com/redcap/api/"
  reportid <- 551

  # REDCap Token (stored as environment variable in C:\Users\hatem\Documents\.Renviron")
  token <- Sys.getenv("AHC_REDCAP_TOKEN")

  report <- postForm(uri,
                     token=token,
                     content="report",
                     report_id=reportid,
                     format="csv",
                     rawOrLabel="label",
                     rawOrLabelHeaders="label")

  # report <- postForm(uri,
  #                 token=token,
  #                 content="record",
  #                 type="flat",
  #                 format="csv",
  #                 rawOrLabel="label",
  #                 rawOrLabelHeaders="label",
  #                 filterLogic="([operation_done] = 1)")

  write(report,file=file)

  cat("Download complete. Saved to:", file, "\n")


}
