CityTable <- function(df, year, interval = "month") {

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


  AswanFilter <- list(list("City", "Aswan"))
  Aswan <- getGroupFn(df, year, AswanFilter, "or")

  UpperEgyptFilter <- list(
    list("City", "Luxor"),
    list("City", "Qena"),
    list("City", "Sohag"),
    list("City", "Assuit"),
    list("City", "New Valley"),
    list("City", "Red Sea"),
    list("City", "Menia")
  )
  Upper_Egypt <- getGroupFn(df, year, UpperEgyptFilter, "or")

  CairoFilter <- list(
    list("City", "Cairo"),
    list("City", "Giza"),
    list("City", "Qalioubia")
  )
  Cairo <- getGroupFn(df, year, CairoFilter, "or")

  RestOfEgyptFilter <- list(
    list("City", "Alexandria"),
    list("City", "Behera"),
    list("City", "Beni Sweif"),
    list("City", "Dakahlia"),
    list("City", "Damietta"),
    list("City", "Fayoum"),
    list("City", "Gharbia"),
    list("City", "Ismailia"),
    list("City", "Kafr ElSheikh"),
    list("City", "Mansoura"),
    list("City", "Matrouh"),
    list("City", "Menoufia"),
    list("City", "North Sinai"),
    list("City", "Port Said"),
    list("City", "Sharkia"),
    list("City", "South Sinai"),
    list("City", "Suez"),
    list("City", "Other")
  )
  Rest_of_Egypt <- getGroupFn(df, year, RestOfEgyptFilter, "or")

  NonEgyptianFilter <- list(list("City", "Not Egyptian"))
  Non_Egyptian <- getGroupFn(df, year, NonEgyptianFilter, "or")

  Total <- Aswan + Upper_Egypt + Cairo + Rest_of_Egypt + Non_Egyptian

  cityTable <- data.frame(Aswan, Upper_Egypt, Cairo, Rest_of_Egypt, Non_Egyptian, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  cityTable
}
