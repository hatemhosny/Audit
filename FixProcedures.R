FixProcedures <- function(df) {
  procedureFixes <- list(
    c("Procedures..choice.", ""),
    c("..", " "),
    c(".", " "),
    c("Pulmonary Valve Replacement", "PVR")
  )

  for (fix in procedureFixes) {
    df <- lapply(df, gsub, pattern = fix[1], replacement = fix[2], fixed = TRUE)
  }
  df
}
