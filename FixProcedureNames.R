FixProcedureNames <- function(df) {
  procedureFixes <- list(
    c("Procedures..choice.", ""),
    c("..", " "),
    c(".", " "),
    c("Pulmonary Valve Replacement", "PVR"),
    c("Coarctectomy with extended end to end anastomosis", "CoA X-end-to-end"),
    c("Anomalous Systemic Venous Drainage Repair", "Systemic Venous Drainage Repair"),
    c("Valve sparing Aortic Root Replacement", "Valve-sparing Aortic Root"),
    c("Homograft Aortic Root Replacement", "Homograft Aortic Root"),
    c("Pulmonary Trans annular Patch", "Pulmonary Trans-annular Patch")
  )

  for (fix in procedureFixes) {
    df <- lapply(df, gsub, pattern = fix[1], replacement = fix[2], fixed = TRUE)
  }
  df
}
