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
#' @param subtitle_size subtitle font size multiplier, default is 1.1
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
#' # Time series with custom background
#' ggplot(economics, aes(x = date, y = unemploy/1000)) +
#'   geom_line(color = "#e74c3c", size = 1.5) +
#'   theme_more_light_03(background_color = "#fafafa", grid_color = "#e0e0e0") +
#'   labs(title = "US Unemployment Over Time (thousands)")
#'
#' # Scatter plot with no grid
#' ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(color = "#2ecc71", size = 3, alpha = 0.7) +
#'   theme_more_light_03(show_grid_major = FALSE) +
#'   labs(title = "Iris Sepal Dimensions")
#'
#' # Plot with minor grid lines and custom subtitle size
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point(size = 3) +
#'   theme_more_light_03(show_grid_minor = TRUE, subtitle_size = 0.9) +
#'   labs(title = "Fuel Efficiency by Weight",
#'        subtitle = "Relationship between car weight and miles per gallon")
#'
theme_more_light_03 <- function(base_size = 11,
                                base_family = "",
                                grid_color = "#d0d0d0",
                                background_color = "#f5f5f5",
                                title_size = 1.6,
                                subtitle_size = 1.1,
                                axis_title_size = 0.7,
                                show_grid_major = TRUE,
                                show_grid_minor = FALSE) {

  # Define grid elements based on parameters
  grid_major_element <- if (show_grid_major) {
    element_line(color = grid_color, linewidth = 0.5, linetype = "solid")
  } else {
    element_blank()
  }

  grid_minor_element <- if (show_grid_minor) {
    element_line(color = grid_color, linewidth = 0.25, linetype = "solid")
  } else {
    element_blank()
  }

  # Note: axis_title_size is included but won't have visible effect since axis.title = element_blank()
  # This is intentional as per the theme description stating "no axis titles"

  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # Plot background - using background_color parameter
      plot.background = element_rect(fill = background_color, color = NA),
      panel.background = element_rect(fill = background_color, color = NA),

      # Grid lines - using conditional elements and grid_color parameter
      panel.grid.major = grid_major_element,
      panel.grid.minor = grid_minor_element,
      panel.grid.major.x = grid_major_element,
      panel.grid.major.y = grid_major_element,

      # Axes
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(color = "#2d2d2d", size = rel(1), face = "bold",
                                 margin = margin(t = 8)),
      axis.text.y = element_text(color = "#666666", size = rel(0.91),
                                 margin = margin(r = 8)),
      axis.title = element_blank(),  # Intentionally blank as per theme description

      # Plot title - using title_size parameter
      plot.title = element_text(color = "#2d2d2d", size = rel(title_size), face = "bold",
                                margin = margin(b = 10), hjust = 0),

      # Plot subtitle - using subtitle_size parameter
      plot.subtitle = element_text(color = "#666666", size = rel(subtitle_size),
                                   margin = margin(t = 0, b = 15), hjust = 0),

      # Legend - hidden as per theme description
      legend.position = "none",

      # Panel border
      panel.border = element_blank(),

      # Margins
      plot.margin = margin(20, 20, 20, 20)
    )
}
