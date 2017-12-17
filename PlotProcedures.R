library(circlize)

source("FilterBy.R")
source("ProcedureGroups.R")
source("FixProcedures.R")

PlotProcedures <- function(df, section, width=10, height=10, res=800, units="in", pointsize=12) {

  GetProcedureAssociations <- function(df, prefix = "Procedures..choice.") {

    procs <- names(select(df, starts_with(prefix)))

    relation <- data.frame(from=character(), to=character(), weight=integer(), stringsAsFactors=FALSE)
    for(i in 1:length(procs)) {
      x <- i
      selfCount <- 0
      filter1 <- FilterBy(df, procs[i], TRUE)
      for(j in x:length(procs)) {
        rowCount <- nrow(FilterBy(filter1, procs[j], TRUE))
        relation <- rbind(relation, data.frame(from=procs[i], to=procs[j], weight=rowCount))
        if (j == i) {
          selfCount <- rowCount
        }
      }
      relationToOthers <- filter(relation, from == procs[i] & to != procs[i])
      relation[relation$from == procs[i] & relation$to == procs[i],3] <-
        selfCount - sum(relationToOthers$weight)
    }
    relation
  }

  highlightGroup <- function(groupName, sectionGroups, color=rand_color(1, transparency = 0.5)) {
    group <- intersect(get.all.sector.index(), sectionGroups[[groupName]])
    highlight.sector(sector.index = group,
                     track.index = 1, text=groupName, col = color,
                     padding=c(-0.2,0,-0.5,0), border=1, niceFacing=TRUE,
                     cex = 0.8, text.col = "white")
  }

  drawPlot <- function(df) {
    relDf <- GetProcedureAssociations(df)

    relDf[-3] <- FixProcedures(relDf[-3])

    colors <- c("#FF0000", "#D2960C", "#7DAF00", "#7500FF", "#A0007D", "#1D64FF",
                    "#00FFE9", "#49FF64", "#64927D", "#FFDB00")
    # col = sample(colors, nrow(distinct(relDf, from)), replace = TRUE)
    col = rep(colors,length.out=nrow(distinct(relDf, from)))

    circos.par(canvas.xlim=c(-1.5,1.5), canvas.ylim=c(-1.5,1.5), points.overflow.warning=FALSE)
    chordDiagram(relDf, grid.col = col, link.visible = relDf[[1]] != relDf[[2]],
                 annotationTrack = "grid",
                 preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(relDf))))))

    for(si in get.all.sector.index()) {
      circos.axis(h="top", labels=FALSE, sector.index=si, track.index=2)
    }

    # we go back to the first track and customize sector labels
    circos.track(track.index = 1, panel.fun = function(x, y) {
      circos.text(CELL_META$xcenter, CELL_META$ylim[1]+0.6, CELL_META$sector.index,
                  facing="clockwise", niceFacing=TRUE, adj=c(0, 0.5), cex=0.7)
      circos.text(CELL_META$xcenter, 0.03, CELL_META$xlim[2],
                  niceFacing=TRUE, adj=c(0.5, 0.5), cex=0.7)
    }, bg.border = NA) # here set bg.border to NA is important

    sectionGroups <- ProcedureGroups[[section]]
    lapply(names(sectionGroups), highlightGroup, sectionGroups)

    circos.clear()

  }

  random <- ceiling(runif(1, 0, 10^12))
  tmpName <- paste("output/", random, ".tmp.png", sep="")
  png(tmpName, type="cairo", width=width, height=height, res=res,
      units=units, pointsize=pointsize)
  drawPlot(df)
  dev.off()

  tmpName
}
