#' Complete list of palettes
#'
#' Use \code{\link{haribo_palette}} to construct palettes of desired length.
#'
#' @export
haribo_palettes <- list(
  goldbears = c("#D9030B","#FF2E00","#FEAE01","#FFDF00","#F5EFE3","#A6BC1B"),
  goldbearsUS = c("#FB0000","#FEC601","#FEE202","#FAF3D7","#08BF0B"),
  konfekt = c("#79391F","#C1722E","#F8D54B","#E4DEC9","#FB9227","#D96892"),
  picoballa = c("#DE3135","#70F2FF","#FFBA76","#4B9438","#016565","#FD7D8A","#F5E48A"),
  baerchenpaerchen = c("#C9631B","#459B3A","#C5B347","#7C365A","#B64946","#2A8985"),
  tropifrutti = c("#637624","#B5A12E","#B5A78C","#B38122","#87232F","#4F2C42")
)

#' A palette generator inspired by the colors of Haribo gummy bears
#'
#' These are a handful of color palettes from Haribo gummy bear compositions.
#'
#' @param n Number of colors desired. If \code{type} is set to "discrete", this
#'   value will be limited to the number of colors available in the palette.
#'   If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   \code{goldbears}, \code{goldbearsUS},  \code{konfekt},
#'   \code{picoballa}, \code{baerchenpaerchen}, \code{tropifrutti}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#' @return A vector of colours.
#' @export
#' @keywords colors
#'
haribo_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  if (missing(name)) {
    # pick a palette at random from the ones available
    name <- sample(names(haribo_palettes),1)
  }

  pal <- haribo_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 3, family = "HersheyScript",font = 3)
}