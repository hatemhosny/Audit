source("FixProcedureNames.R")

ProceduresTable <- function(df, year, interval="month", prefix="Procedures..choice.") {


  months <- c("JAN",	"FEB",	"MAR",	"APR", "MAY",	"JUN",
              "JUL",	"AUG",	"SEP",	"OCT",	"NOV",	"DEC", "Total")

  quarters <- c("Q1",	"Q2",	"Q3",	"Q4", "Total")

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  groups <- data.frame(row.names = usedInterval)
  procs <- names(select(df, starts_with(prefix)))


  for (proc in procs) {
    groups <- cbind(groups, getGroupFn(df, year, list(list(proc, TRUE))))
  }

  colnames(groups) <-  procs %>% FixProcedureNames()

  Table <- groups %>%
    t() %>%
    as.data.frame()

  Table
}
