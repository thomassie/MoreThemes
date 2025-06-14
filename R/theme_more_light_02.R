#' A Clean Minimal Theme for ggplot2
#'
#' This theme provides a clean, professional aesthetic with subtle gray colors,
#' minimal grid lines, and clear typography. Features a very light gray background
#' (#f8f8f8), subtle grid lines, and includes axis titles and legend. Perfect for
#' professional reports and publications where clarity and readability are key.
#'
#' @param base_size base font size, given in pts.
#' @param base_family base font family
#' @param grid_color color of grid lines, default is "#e0e0e0"
#' @param background_color background color, default is "#f8f8f8"
#' @param title_size title font size multiplier, default is 1.3
#' @param subtitle_size subtitle font size multiplier, default is 1.1
#' @param axis_title_size axis title size multiplier, default is 1
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
#' # Scatter plot with axis titles
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point(size = 3, alpha = 0.7) +
#'   theme_more_light_02() +
#'   labs(title = "Fuel Efficiency by Weight",
#'        subtitle = "Data from 1974 Motor Trend magazine",
#'        x = "Weight (1000 lbs)", y = "Miles per Gallon")
#'
#' # Bar chart with legend
#' ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +
#'   geom_bar(position = "dodge") +
#'   theme_more_light_02() +
#'   labs(title = "Car Count by Cylinders and Gears",
#'        x = "Number of Cylinders", y = "Count")
#'
#' # Custom colors and sizing
#' ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(aes(color = Species), size = 3) +
#'   theme_more_light_02(background_color = "#fafafa",
#'                       title_size = 1.5,
#'                       subtitle_size = 0.9) +
#'   labs(title = "Iris Sepal Dimensions",
#'        subtitle = "Measurements by species",
#'        x = "Sepal Length (cm)", y = "Sepal Width (cm)")
#'
theme_more_light_02 <- function(base_size = 11,
                                base_family = "",
                                grid_color = "#e0e0e0",
                                background_color = "#f8f8f8",
                                title_size = 1.3,
                                subtitle_size = 1.1,
                                axis_title_size = 1,
                                show_grid_major = TRUE,
                                show_grid_minor = FALSE) {

  # Define grid elements based on parameters
  grid_major_element <- if (show_grid_major) {
    element_line(color = grid_color, linewidth = 0.3, linetype = "solid")
  } else {
    element_blank()
  }

  grid_minor_element <- if (show_grid_minor) {
    element_line(color = grid_color, linewidth = 0.15, linetype = "solid")
  } else {
    element_blank()
  }

  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # Plot background - using background_color parameter
      plot.background = element_rect(fill = background_color, color = NA),
      panel.background = element_rect(fill = background_color, color = NA),

      # Grid lines - using the conditional elements
      panel.grid.major = grid_major_element,
      panel.grid.minor = grid_minor_element,

      # Axes - clean minimal styling
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(color = "#999999", size = rel(0.9),
                                 margin = margin(t = 8)),
      axis.text.y = element_text(color = "#999999", size = rel(0.9),
                                 margin = margin(r = 8)),
      axis.title.x = element_text(color = "#999999", size = rel(axis_title_size),
                                  margin = margin(t = 12)),
      axis.title.y = element_text(color = "#999999", size = rel(axis_title_size),
                                  margin = margin(r = 12), angle = 90),

      # Plot title - using title_size parameter
      plot.title = element_text(color = "#273E47", size = rel(title_size), face = "bold",
                                margin = margin(b = 10), hjust = 0),

      # Plot subtitle - using subtitle_size parameter
      plot.subtitle = element_text(color = "#999999", size = rel(subtitle_size),
                                   margin = margin(t = 0, b = 15), hjust = 0),

      # Legend - positioned on right side
      legend.position = "right",
      legend.justification = "center",
      legend.background = element_blank(),
      legend.key = element_blank(),
      legend.text = element_text(color = "#000000", size = rel(1), face = "bold"),
      legend.title = element_blank(),
      legend.margin = margin(l = 20),
      legend.spacing.y = unit(8, "pt"),

      # Panel border
      panel.border = element_blank(),

      # Margins
      plot.margin = margin(20, 25, 20, 20),

      # Strip text (if using facets)
      strip.background = element_blank(),
      strip.text = element_text(color = "#000000", face = "bold", size = rel(1.1))
    )
}
