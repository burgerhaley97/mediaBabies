#' Generic Plot Class influences
#'
#' This function uses the generic plot function to plot an object of class
#'   influences a long with one additional class object (baby_count or baby_pc).
#'
#' @param x An object of class influences.
#' @param y An object of class baby_count or baby_pc.
#' @param sex Enter whether the name is male or female.
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
#' release_year=c(1977, 1977), poi_year=c(1977, 1978),
#' percent_change=c(366.7, 59.2))
#' influ_obj <- influences(df)
#' # plotting objects
#' plot(influ_obj, pc_obj, "female")
#' plot(influ_obj, bc_obj, "female")
#' @export
plot.influences <- function(x, y, sex, ...) {

  # Determining y-axis name
  y_name <- ifelse(inherits(y, "baby_count"),
                   "Name Count", "Name Percent Change")
  mf_color <- ifelse(tolower(sex) == "male", "lightblue", "pink")

  # identifying needed values
  name <- attr(y, "name")
  year <- attr(y, "start_year")
  poi_year <- x[["poi_year"]]
  release_year <- x[["release_year"]]
  title <- x[["title"]]

  # creating data frame
  values <- y[seq_along(y)]
  years <- seq(year, year + length(y) - 1, 1)
  df <- data.frame(values = values,
                   years = years)

  # plotting objects
  ggplot2::ggplot(data = df, aes(x = years, y = values)) +
    geom_line(color = mf_color, linewidth = 3) +
    geom_point(data = df[df$years %in% poi_year, ],
               aes(x = years, y = values, color = mf_color), size = 5) +
    geom_vline(xintercept = release_year, linetype = "dotted") +
    geom_text(data = df[df$years %in% release_year, ],
              aes(x = unique(release_year), y = values,
                  label = unique(title)),
              vjust = -1, hjust = 0.5) +
    scale_color_manual(values = c(mf_color)) +
    theme(
      plot.background = element_rect(fill = "white"),
      panel.background = element_rect(fill = "white"),
      panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
      panel.grid.major.y = element_line(color = "lightgrey", linewidth = 0.2),
      panel.grid.major.x = element_line(color = "lightgrey", linewidth = 0.2),
      plot.title = element_text(size = 22, hjust = 0.5, face = "bold"),
      plot.subtitle = element_text(size = 15, face = "italic", hjust = 0.5),
      axis.title.y = element_text(size = 12, vjust = 3),
      axis.text.x = element_text(size = 10, vjust = -1, color = "black"),
      axis.text.y = element_text(size = 10, color = "black"),
      axis.ticks = element_blank(),
      legend.position = "none",
      plot.margin = unit(c(1, 1, 1, 1), "cm")
    ) +
    labs(x = "",
         y = y_name,
         title = name,
         subtitle = "Influence of Media Events on Baby Names")
}
