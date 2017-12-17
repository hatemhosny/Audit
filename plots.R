DrawPlots <- function(df) {

  lapply(names(df), function(var.name) {

    if(is.numeric(df[[var.name]])) {

      boxplot(df[[var.name]], main = var.name)

      hist(df[[var.name]], main = var.name, xlab = var.name)

    }

  })

}


pdf("plots.pdf")
DrawPlots(data)
dev.off()
