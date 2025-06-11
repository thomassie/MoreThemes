#' A Light Minimal Theme for ggplot2
#'
#' This theme provides a clean, light aesthetic with subtle gray backgrounds
#' and minimal visual elements. It features a light gray background (#f8f8f8),
#' very subtle grid lines, and clean typography with right-positioned legends.
#'
#' @param base_size base font size, given in pts.
#' @param base_family base font family
#' @param grid_color color of grid lines, default is "#E0E0E0"
#' @param background_color background color, default is "#F8F8F8"
#' @param title_size title font size multiplier, default is 1.3
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
#' # Basic scatter plot
#' ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
#'   geom_point(size = 3) +
#'   theme_more_light_02() +
#'   labs(title = "Fuel Efficiency by Weight",
#'        x = "Weight (1000 lbs)",
#'        y = "Miles per Gallon")
#'
#' # Bar chart with no grid lines
#' ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
#'   geom_bar() +
#'   theme_more_light_02(show_grid_major = FALSE) +
#'   labs(title = "Distribution of Cylinders",
#'        x = "Number of Cylinders",
#'        y = "Count")
#'
#' # Plot with minor grid lines
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_more_light_02(show_grid_minor = TRUE, grid_color = "#d0d0d0") +
#'   labs(title = "MPG vs Weight")
#'
theme_more_light_02 <- function(base_size = 11,
                                base_family = "",
                                grid_color = "#e0e0e0",
                                background_color = "#f8f8f8",
                                title_size = 1.3,
                                axis_title_size = 1,
                                show_grid_major = TRUE,
                                show_grid_minor = FALSE) {

  # Define grid elements based on parameters
  grid_major_element <- if (show_grid_major) {
    element_line(color = grid_color, size = 0.3, linetype = "solid")
  } else {
    element_blank()
  }

  grid_minor_element <- if (show_grid_minor) {
    element_line(color = grid_color, size = 0.15, linetype = "solid")
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
      plot.title = element_text(color = "#000000", size = rel(title_size), face = "bold",
                                margin = margin(b = 20), hjust = 0),

      # No subtitle for this style
      plot.subtitle = element_blank(),

      # No caption for this clean style
      plot.caption = element_blank(),

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
