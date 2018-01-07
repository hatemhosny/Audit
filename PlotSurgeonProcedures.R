PlotSurgeonProcedures <- function(df, file, surgeon, year) {

  df %>%
    FilterBy("Section", "Adults") %>%
    FilterByYear(year) %>%
    FilterBy("Surgeon.1", surgeon) %>%
    WriteToExcel(file, surgeon, PlotProcedures, isPlot=TRUE,
                 title=paste("Adults", year), section="Adults")

  df %>%
    FilterBy("Section", "Pediatrics") %>%
    FilterByYear(year) %>%
    FilterBy("Surgeon.1", surgeon) %>%
    WriteToExcel(file, surgeon, PlotProcedures, isPlot=TRUE,
                 title=paste("Pediatrics", year), section="Pediatrics", append=TRUE)

}
