#' FiveThirtyEight Theme Variant
#'
#' A variation of the FiveThirtyEight theme with customizable options
#' for ggplot2 charts. This theme features a light gray background,
#' minimal grid lines, and a clean, modern appearance.
#'
#' @param base_size base font size, default is 12
#' @param base_family base font family, default is "sans"
#' @param grid_color color of grid lines, default is "grey90"
#' @param background_color background color, default is "grey95"
#' @param title_size title font size multiplier, default is 1.2
#' @param axis_title_size axis title size multiplier, default is 0.9
#' @param show_grid_major logical, show major grid lines, default is TRUE
#' @param show_grid_minor logical, show minor grid lines, default is FALSE
#'
#' @return A ggplot2 theme object
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' # Basic usage
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_fivethirtyeight_variant()
#'
#' # Customized version
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_fivethirtyeight_variant(
#'     base_size = 14,
#'     grid_color = "grey80",
#'     background_color = "white"
#'   )
#'
#' @import ggplot2
#' @import grid
theme_fivethirtyeight_variant <- function(base_size = 12,
                                          base_family = "sans",
                                          grid_color = "grey90",
                                          background_color = "grey95",
                                          title_size = 1.2,
                                          axis_title_size = 0.9,
                                          show_grid_major = TRUE,
                                          show_grid_minor = FALSE) {

  # Start with theme_bw as base
  theme_bw(base_size = base_size, base_family = base_family) +
    theme(
      # Panel settings
      panel.background = element_rect(fill = background_color, color = NA),
      panel.border = element_blank(),
      panel.spacing = unit(1, "lines"),

      # Grid settings
      panel.grid.major = if(show_grid_major) {
        element_line(color = grid_color, size = 0.5)
      } else {
        element_blank()
      },
      panel.grid.minor = if(show_grid_minor) {
        element_line(color = grid_color, size = 0.25)
      } else {
        element_blank()
      },

      # Axis settings
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_text(
        size = base_size * axis_title_size,
        face = "bold",
        color = "grey30"
      ),
      axis.title.x = element_text(
        margin = margin(t = 10),
        vjust = 1
      ),
      axis.title.y = element_text(
        margin = margin(r = 10),
        angle = 90,
        vjust = 1
      ),
      axis.text = element_text(
        size = base_size * 0.8,
        color = "grey40"
      ),

      # Title and labels
      plot.title = element_text(
        size = base_size * title_size,
        face = "bold",
        color = "grey20",
        margin = margin(b = 10),
        hjust = 0
      ),
      plot.subtitle = element_text(
        size = base_size,
        color = "grey30",
        margin = margin(b = 10),
        hjust = 0
      ),
      plot.caption = element_text(
        size = base_size * 0.7,
        color = "grey50",
        margin = margin(t = 10),
        hjust = 1
      ),

      # Legend settings
      legend.background = element_rect(fill = "white", color = NA),
      legend.key = element_rect(fill = "white", color = NA),
      legend.title = element_text(
        size = base_size * 0.9,
        face = "bold",
        color = "grey30"
      ),
      legend.text = element_text(
        size = base_size * 0.8,
        color = "grey40"
      ),
      legend.position = "top",
      legend.direction = "horizontal",
      legend.box = "horizontal",
      legend.key.size = unit(1, "lines"),

      # Plot background
      plot.background = element_rect(fill = "white", color = NA),
      plot.margin = margin(20, 20, 20, 20),

      # Strip settings (for facets)
      strip.background = element_rect(fill = "grey85", color = NA),
      strip.text = element_text(
        size = base_size * 0.9,
        face = "bold",
        color = "grey20",
        margin = margin(5, 5, 5, 5)
      )
    )
}
