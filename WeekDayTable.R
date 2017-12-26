WeekDayTable <- function(df, year, interval = "month") {

  months <-   months <- Config$Months.Mean

  usedInterval <- months
  getGroupFn <- GetGroupMean

  daysDf <- df %>%
    group_by(Date.of.Operation) %>%
    summarise(n = n())

  daysDf$week.day = wday(daysDf$Date.of.Operation, label = TRUE)

  Sunday <- getGroupFn(daysDf, year, list(list("week.day", "Sun")), "n")
  Monday <- getGroupFn(daysDf, year, list(list("week.day", "Mon")), "n")
  Tuesday <- getGroupFn(daysDf, year, list(list("week.day", "Tue")), "n")
  Wednesday <- getGroupFn(daysDf, year, list(list("week.day", "Wed")), "n")
  Thursday <- getGroupFn(daysDf, year, list(list("week.day", "Thu")), "n")
  Friday <- getGroupFn(daysDf, year, list(list("week.day", "Fri")), "n")
  Saturday <- getGroupFn(daysDf, year, list(list("week.day", "Sat")), "n")


  Total <- Sunday + Monday + Tuesday + Wednesday + Thursday + Friday + Saturday

  weekDayTable <- data.frame(Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  weekDayTable
}


