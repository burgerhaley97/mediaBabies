#' Generic Plot Class influences
#'
#' This function uses the generic plot function to plot an object of class
#'   influences a long with one additional class object (baby_count or baby_pc).
#'
#' @param x An object of class influences.
#' @param y An object of class baby_count or baby_pc.
#' @param ... Traditional plot function arguments.
#' @import ggplot2
#' @return A plot of the influences object
#' @examples
#' # creating baby_pc object
#' df <- data.frame(Leia=c(50, -4.8, 5, 366.7, 59.2, -24.4, 37.3),
#' Kizzy=c(0, 0, 0, 111600, -59.1, -41, -55.8))
#' rownames(df) <- c(1974:1980)
#' pc_obj <- baby_pc(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
#' # creating baby_count object
#' df <- data.frame(Leia=c(21, 20, 21, 98, 156, 118, 162),
#' Kizzy=c(0, 0, 0, 1116, 456, 269, 119))
#' rownames(df) <- c(1974:1980)
#' bc_obj <- baby_count(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
#' # creating influences object
#' df <- data.frame(name=c("Leia", "Leia"), title=c("Star Wars", "Star Wars"),
#' release_year=c(1977, 1978), poi_year=c(1977, 1978),
#' percent_change=c(366.7, 59.2))
#' influ_obj <- influences(df)
#' # plotting objects
#' plot(influ_obj, pc_obj)
#' plot(influ_obj, bc_obj)
#' @export
plot.influences <- function(x, y, ...) {
  # Determining y-axis name
  if (inherits(y, "baby_count")) {
    y_name = "Count"
  } else {
    y_name = "Percent Change"
  }
  # identifying needed values
  name <- attr(y, "name")
  year <- attr(y, "start_year")
  poi_year <- x[["poi_year"]]
  release_year <- x[["release_year"]]
  title <- x[["title"]]
  # creating data frame
  values <- y[1:length(y)]
  years <- seq(year, year + length(y)-1, 1)
  df <- data.frame(values = values,
                   years = years)
  # plotting objects
  ggplot2::ggplot(data = df, aes(x = years, y = values)) +
    geom_line() +
    geom_point(data = df[df$years %in% poi_year, ],
               aes(x = years, y = values, col = "lightblue"), size = 3) +
    geom_vline(xintercept = release_year, linetype = "dotted")+
    geom_text(data = df[df$years %in% release_year, ],
              aes(x = release_year, y = values, label = title),
              vjust = -1, hjust = 0.5) +
    scale_x_continuous(breaks=seq(year, year + length(y)-1, 1)) +
    theme(
      plot.title = element_text(size = 20, hjust = 0.5, face = "bold"),
      plot.subtitle = element_text(size = 14, face = "italic", hjust = 0.5),
      axis.title.y = element_text(size = 12, vjust = 3),
      axis.text.x = element_text(size = 10, vjust = -1),
      axis.text.y = element_text(size = 10),
      axis.ticks = element_blank(),
      legend.position = "none",
      plot.margin = unit(c(1, 1, 1, 1), "cm")
    ) +
    labs(x = "",
         y = y_name,
         title = name,
         subtitle = "Influence of Media Events on Baby Names")
}
