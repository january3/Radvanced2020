two_col_example <- function(ex1=NULL, ex2=NULL, pval=TRUE, lfc=FALSE, n=NULL) {

  if(!is.null(ex1)) { totN <- length(ex1) }
  else if(!is.null(ex2)) { totN <- length(ex2) }
  else if(!is.null(n)) { totN <- n }
  else stop("need a length (parameter n)")


  old.par <- par(mar=c(0, 0, 0, 0), bty="n")
  on.exit(par(old.par))
  plot(NULL, xlim=c(-.5, 3), ylim=c(totN, -4), xaxt="n", yaxt="n", xlab="", ylab="")

  if(!is.null(ex1)) {
    sel <- which(ex1==1)
    for(i in sel) { rect(.5, i, 1, i + 1, border=NA, col="#AA1C7D") }
    segments(.5, 1:totN, 1, 1:totN)
    segments(c(.5, 1), 1, c(.5, 1), totN)
    text(.75, -1, "Enriched", pos=3, cex=1)
  }

  if(!is.null(ex2)) {
    sel <- which(ex2==1)
    for(i in sel) { rect(1.5, i, 2, i + 1, border=NA, col="#AA1C7D") }
    segments(1.5, 1:totN, 2, 1:totN)
    segments(c(1.5, 2), 1, c(1.5, 2), totN)
    text(1.75, -1, "Not enriched", pos=3, cex=1)
  }

  if(pval) {
    arrows(.2, 1, .2, totN)
    text(.2, 1, "0", pos=2, cex=1)
    text(.2, totN, "1", pos=2, cex=1)
    text(0, totN/2, "P-Value", pos=3, srt=90, cex=1)
  }

  if(lfc) {
    arrows(-.3, totN, -.3, 1)
    text(-.3, 1, "+", pos=4, cex=1)
    text(-.3, totN, "-", pos=4, cex=1)
    text(-.35, totN/2, "log2 Fold Change", pos=3, srt=90, cex=1)
  }


  legend("bottomright", "In gene set", pch=15, col="#AA1C7D", cex=1, bty="n")
}


plot_gsea_example <- function(ex, steps=NULL) {

  n <- sum(ex == 1)
  totN <- length(ex)
  plot(NULL, yaxt="n", ylim=c(-n/10, n), xlim=c(1, totN), 
    xlab="All genes", ylab="Genes in the gene set", bty="n")
  axis(side=2, at=0:n)
  segments(0, 0, totN, n, col="grey")

  sel <- which(ex == 1)
  for(i in sel) { rect(i - 1, -n/10, i, 0, border=NA, col="#AA1C7D") }
  segments(0:totN, -n/10, 0:totN, 0)
  segments(0, c(0, -n/10), totN, c(0, -n/10))

  if(is.null(steps)) steps <- totN
  if(steps > totN) steps <- totN
  if(steps > 0) {

    y <- c(0, 1:n, n)
    x <- c(0, sel, totN)

    y <- cumsum(ex == 1)[1:steps]
    x <- (1:totN)[1:steps]
    segments(x-1, y, x, y)
    mm <- max(y)
    y <- 1:n
    x <- which(ex == 1) - 1
    .sel <- y <= mm
    segments(x[.sel], y[.sel] - 1, x[.sel], y[.sel])
  }
}
