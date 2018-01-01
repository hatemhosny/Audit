SurgeonMortalityTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }



  Magdi.Yacoub <- getGroupFn(df, year, list(list("Surgeon.1", "Prof. Magdi Yacoub")))
  Magdi.YacoubMortalityFilter <- list(list("Surgeon.1", "Prof. Magdi Yacoub"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Magdi.Yacoub.Mortality <- getGroupFn(allDf, year, Magdi.YacoubMortalityFilter)
  Magdi.Yacoub.Mortality.Percent <- round(Magdi.Yacoub.Mortality/Magdi.Yacoub*100, digits = 1)

  Carin.van.Doorn <- getGroupFn(df, year, list(list("Surgeon.1", "Carin van Doorn")))
  Carin.van.DoornMortalityFilter <- list(list("Surgeon.1", "Carin van Doorn"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Carin.van.Doorn.Mortality <- getGroupFn(allDf, year, Carin.van.DoornMortalityFilter)
  Carin.van.Doorn.Mortality.Percent <- round(Carin.van.Doorn.Mortality/Carin.van.Doorn*100, digits = 1)


  Ahmed.Afifi <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Afifi")))
  Ahmed.AfifiMortalityFilter <- list(list("Surgeon.1", "Ahmed Afifi"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Ahmed.Afifi.Mortality <- getGroupFn(allDf, year, Ahmed.AfifiMortalityFilter)
  Ahmed.Afifi.Mortality.Percent <- round(Ahmed.Afifi.Mortality/Ahmed.Afifi*100, digits = 1)



  Ahmed.Shazly <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Shazly")))
  Ahmed.ShazlyMortalityFilter <- list(list("Surgeon.1", "Ahmed Shazly"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Ahmed.Shazly.Mortality <- getGroupFn(allDf, year, Ahmed.ShazlyMortalityFilter)
  Ahmed.Shazly.Mortality.Percent <- round(Ahmed.Shazly.Mortality/Ahmed.Shazly*100, digits = 1)


  Hatem.Hosny <- getGroupFn(df, year, list(list("Surgeon.1", "Hatem Hosny")))
  Hatem.HosnyMortalityFilter <- list(list("Surgeon.1", "Hatem Hosny"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Hatem.Hosny.Mortality <- getGroupFn(allDf, year, Hatem.HosnyMortalityFilter)
  Hatem.Hosny.Mortality.Percent <- round(Hatem.Hosny.Mortality/Hatem.Hosny*100, digits = 1)


  Walid.Simry <- getGroupFn(df, year, list(list("Surgeon.1", "Walid Simry")))
  Walid.SimryMortalityFilter <- list(list("Surgeon.1", "Walid Simry"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Walid.Simry.Mortality <- getGroupFn(allDf, year, Walid.SimryMortalityFilter)
  Walid.Simry.Mortality.Percent <- round(Walid.Simry.Mortality/Walid.Simry*100, digits = 1)


  Ahmed.Mahgoub <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Mahgoub")))
  Ahmed.MahgoubMortalityFilter <- list(list("Surgeon.1", "Ahmed Mahgoub"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Ahmed.Mahgoub.Mortality <- getGroupFn(allDf, year, Ahmed.MahgoubMortalityFilter)
  Ahmed.Mahgoub.Mortality.Percent <- round(Ahmed.Mahgoub.Mortality/Ahmed.Mahgoub*100, digits = 1)


  separator <- rep(NA, times=length(usedInterval))
  Table <- data.frame(Magdi.Yacoub, Magdi.Yacoub.Mortality, Magdi.Yacoub.Mortality.Percent,
                      separator,
                      Carin.van.Doorn, Carin.van.Doorn.Mortality, Carin.van.Doorn.Mortality.Percent,
                      separator,
                      Ahmed.Afifi, Ahmed.Afifi.Mortality, Ahmed.Afifi.Mortality.Percent,
                      separator,
                      Ahmed.Shazly, Ahmed.Shazly.Mortality, Ahmed.Shazly.Mortality.Percent,
                      separator,
                      Hatem.Hosny, Hatem.Hosny.Mortality, Hatem.Hosny.Mortality.Percent,
                      separator,
                      Walid.Simry, Walid.Simry.Mortality, Walid.Simry.Mortality.Percent,
                      separator,
                      Ahmed.Mahgoub, Ahmed.Mahgoub.Mortality, Ahmed.Mahgoub.Mortality.Percent,
                      row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  insertSpaces <- function() {

  }
  row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE) %>%
    gsub(pattern = "separator", replacement = "------", fixed = TRUE)

  Table
}
