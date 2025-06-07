# ===== File: R/zzz.R =====
# This file handles package loading and font registration

.onLoad <- function(libname, pkgname) {
  # Load and register Nunito Sans font when package is loaded
  if (requireNamespace("showtext", quietly = TRUE)) {
    tryCatch({
      showtext::font_add_google("Nunito Sans", "Nunito Sans")
      showtext::showtext_auto()
      packageStartupMessage("Nunito Sans font loaded successfully")
    }, error = function(e) {
      packageStartupMessage("Could not load Nunito Sans font: ", e$message)
      packageStartupMessage("Theme will fall back to system sans font")
    })
  } else {
    packageStartupMessage("showtext package not available. Install with: install.packages('showtext')")
    packageStartupMessage("Theme will use system sans font")
  }
}

.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Package loaded. Nunito Sans font should now be available for themes.")
}

# ===== File: R/font-helpers.R =====
# Helper functions for font management

#' Check if Nunito Sans font is available
#'
#' This function checks whether the Nunito Sans font has been successfully
#' loaded and is available for use in ggplot2 themes.
#'
#' @return Logical value indicating if Nunito Sans font is available
#' @export
#'
#' @examples
#' # Check font availability
#' if (check_nunito_font()) {
#'   message("Nunito Sans is available!")
#' } else {
#'   message("Nunito Sans is not available, using fallback font")
#' }
check_nunito_font <- function() {
  if (requireNamespace("showtext", quietly = TRUE)) {
    return("Nunito Sans" %in% names(showtext::font_families()))
  }
  return(FALSE)
}

#' Force reload Nunito Sans font
#'
#' Attempts to reload the Nunito Sans font from Google Fonts.
#' Useful if the font failed to load during package startup.
#'
#' @return Logical value indicating success of font loading
#' @export
#'
#' @examples
#' # Manually reload font if needed
#' if (!check_nunito_font()) {
#'   reload_nunito_font()
#' }
reload_nunito_font <- function() {
  if (!requireNamespace("showtext", quietly = TRUE)) {
    message("showtext package not available. Install with: install.packages('showtext')")
    return(FALSE)
  }

  tryCatch({
    showtext::font_add_google("Nunito Sans", "Nunito Sans")
    showtext::showtext_auto()
    message("Nunito Sans font reloaded successfully")
    return(TRUE)
  }, error = function(e) {
    message("Could not reload Nunito Sans font: ", e$message)
    return(FALSE)
  })
}

#' Get available font family for theme
#'
#' Internal helper function that returns the appropriate font family
#' to use in the theme, with fallback logic.
#'
#' @param preferred_font Character string of preferred font family
#' @return Character string of font family to use
#' @keywords internal
get_theme_font <- function(preferred_font = "Nunito Sans") {
  if (preferred_font == "Nunito Sans") {
    if (check_nunito_font()) {
      return("Nunito Sans")
    } else {
      warning("Nunito Sans font not available. Using system sans font instead. Try reload_nunito_font() to reload the font.")
      return("sans")
    }
  }
  return(preferred_font)
}

# ===== File: R/theme-fivethirtyeight-variant.R =====
# Main theme function with robust font handling

#' FiveThirtyEight Theme Variant
#'
#' A variation of the FiveThirtyEight theme with customizable options
#' for ggplot2 charts. This theme features a warm beige background,
#' minimal grid lines, and uses Nunito Sans font for a clean, modern appearance.
#' The Nunito Sans font is automatically loaded when the package is loaded.
#'
#' @param base_size base font size, default is 12
#' @param base_family base font family, default is "Nunito Sans"
#' @param grid_color color of grid lines, default is "#D8D2C2"
#' @param background_color background color, default is "#EDE9DE"
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
#' # Check if font is available
#' check_nunito_font()
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
#'     grid_color = "#B8B0A0",
#'     background_color = "#F5F2E8"
#'   )
#'
#' # Using different font
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_fivethirtyeight_variant(base_family = "Arial")
#'
#' @import ggplot2
#' @import grid
theme_fivethirtyeight_variant <- function(base_size = 12,
                                          base_family = "Nunito Sans",
                                          grid_color = "#D8D2C2",
                                          background_color = "#EDE9DE",
                                          title_size = 1.2,
                                          axis_title_size = 0.9,
                                          show_grid_major = TRUE,
                                          show_grid_minor = FALSE) {

  # Use helper function to get appropriate font
  actual_font <- get_theme_font(base_family)

  # Start with theme_bw as base
  theme_bw(base_size = base_size, base_family = actual_font) +
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
