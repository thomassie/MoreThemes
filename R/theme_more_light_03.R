#' A Bold Minimal Theme for ggplot2
#'
#' This theme provides a clean aesthetic with bold typography and no axis titles
#' or legend. It features a light gray background (#f5f5f5), medium gray grid lines,
#' bold x-axis text, and large bold titles. Perfect for presentations or displays
#' where the data speaks for itself.
#'
#' @param base_size base font size, given in pts.
#' @param base_family base font family
#' @param grid_color color of grid lines, default is "#D0D0D0"
#' @param background_color background color, default is "#F5F5F5"
#' @param title_size title font size multiplier, default is 1.6
#' @param axis_title_size axis title size multiplier, default is 0.7
#' @param show_grid_major logical, show major grid lines, default is TRUE
#' @param show_grid_minor logical, show minor grid lines, default is FALSE
#'
#' @return A ggplot2 theme object
#' @export
#' @import ggplot2
#'
#' @examples
#' library(ggplot2)
#'
#' # Simple bar chart - great for this theme
#' ggplot(mtcars, aes(x = rownames(mtcars), y = mpg)) +
#'   geom_col(fill = "#4a90e2") +
#'   theme_more_light_03() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#'   labs(title = "Miles per Gallon by Car Model")
#'
#' # Time series
#' ggplot(economics, aes(x = date, y = unemploy/1000)) +
#'   geom_line(color = "#e74c3c", size = 1.5) +
#'   theme_more_light_03() +
#'   labs(title = "US Unemployment Over Time (thousands)")
#'
#' # Scatter plot
#' ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(color = "#2ecc71", size = 3, alpha = 0.7) +
#'   theme_more_light_03() +
#'   labs(title = "Iris Sepal Dimensions")
#'
theme_more_light_03 <- function(base_size = 11,
                                base_family = "",
                                grid_color = "#d0d0d0",
                                background_color = "#f5f5f5",
                                title_size = 1.6,
                                axis_title_size = 0.7,
                                show_grid_major = TRUE,
                                show_grid_minor = FALSE) {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # Plot background
      plot.background = element_rect(fill = "#f5f5f5", color = NA),
      panel.background = element_rect(fill = "#f5f5f5", color = NA),

      # Grid lines
      panel.grid.major = element_line(color = "#d0d0d0", linewidth = 0.5, linetype = "solid"),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_line(color = "#d0d0d0", linewidth = 0.5),
      panel.grid.major.y = element_line(color = "#d0d0d0", linewidth = 0.5),

      # Axes
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(color = "#2d2d2d", size = rel(1), face = "bold",
                                 margin = margin(t = 8)),
      axis.text.y = element_text(color = "#666666", size = rel(0.91),
                                 margin = margin(r = 8)),
      axis.title = element_blank(),

      # Plot title
      plot.title = element_text(color = "#2d2d2d", size = rel(1.64), face = "bold",
                                margin = margin(b = 20), hjust = 0),

      # Legend
      legend.position = "none",

      # Panel border
      panel.border = element_blank(),

      # Margins
      plot.margin = margin(20, 20, 20, 20)
    )
}
