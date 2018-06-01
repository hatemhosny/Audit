Config <- list()

Config$Default.Template <- "template.xlsx"

Config$Months <- c("JAN",	"FEB",	"MAR",	"APR", "MAY",	"JUN",
                   "JUL",	"AUG",	"SEP",	"OCT",	"NOV",	"DEC")

Config$Months.Total <- c(Config$Months, "Total")
Config$Months.Mean <- c(Config$Months, "Mean")
Config$Months.Total.Mean <- c(Config$Months.Total, "Mean")

Config$Quarters <- c("Q1",	"Q2",	"Q3",	"Q4")
Config$Quarters.Inclusive <- TRUE

Config$Quarters.Total <- c(Config$Quarters, "Total")
Config$Quarters.Mean <- c(Config$Quarters, "Mean")
Config$Quarters.Total.Mean <- c(Config$Quarters.Total, "Mean")
