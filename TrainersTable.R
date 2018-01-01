TrainersTable <- function(df, year, interval = "month") {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  df <- df %>%
    FilterBy("Surgeon.1", "Prof. Magdi Yacoub", "neq") %>%
    FilterBy("Surgeon.1", "Carin van Doorn", "neq") %>%
    FilterBy("Surgeon.1", "Ahmed Afifi", "neq") %>%
    FilterBy("Surgeon.1", "Ahmed Shazly", "neq") %>%
    FilterBy("Surgeon.1", "Hatem Hosny", "neq") %>%
    FilterBy("Surgeon.1", "Ismail El-hamamsy", "neq") %>%
    FilterBy("Surgeon.1", "Nancy Poirier", "neq") %>%
    FilterBy("Surgeon.1", "Hamza Elnady", "neq")


  Magdi.Yacoub <- getGroupFn(df, year, list(list("Surgeon.2", "Prof. Magdi Yacoub"),
                                            list("Surgeon.3", "Prof. Magdi Yacoub")),
                             apply.filters = "or")
  Carin.van.Doorn <- getGroupFn(df, year, list(list("Surgeon.2", "Carin van Doorn"),
                                               list("Surgeon.3", "Carin van Doorn")),
                                apply.filters = "or")
  Ahmed.Afifi <- getGroupFn(df, year, list(list("Surgeon.2", "Ahmed Afifi"),
                                           list("Surgeon.3", "Ahmed Afifi")),
                            apply.filters = "or")
  Ahmed.Shazly <- getGroupFn(df, year, list(list("Surgeon.2", "Ahmed Shazly"),
                                            list("Surgeon.3", "Ahmed Shazly")),
                             apply.filters = "or")
  Hatem.Hosny <- getGroupFn(df, year, list(list("Surgeon.2", "Hatem Hosny"),
                                           list("Surgeon.3", "Hatem Hosny")),
                            apply.filters = "or")

  Table <- data.frame(Magdi.Yacoub, Carin.van.Doorn, Ahmed.Afifi, Ahmed.Shazly,
                      Hatem.Hosny, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

    row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE)

  Table
}


