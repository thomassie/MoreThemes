test_that("theme_fivethirtyeight_variant returns a theme object", {
  theme <- theme_fivethirtyeight_variant()
  expect_s3_class(theme, "theme")
  expect_s3_class(theme, "gg")
})

test_that("theme_fivethirtyeight_variant works with ggplot", {
  library(ggplot2)

  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_fivethirtyeight_variant()

  expect_s3_class(p, "ggplot")
  expect_no_error(print(p))
})

test_that("theme parameters work correctly", {
  # Test base_size parameter
  theme_small <- theme_fivethirtyeight_variant(base_size = 10)
  theme_large <- theme_fivethirtyeight_variant(base_size = 20)

  expect_equal(theme_small$text$size, 10)
  expect_equal(theme_large$text$size, 20)

  # Test background_color parameter
  theme_white <- theme_fivethirtyeight_variant(background_color = "white")
  expect_equal(theme_white$panel.background$fill, "white")

  # Test grid_color parameter
  theme_grid <- theme_fivethirtyeight_variant(grid_color = "red")
  expect_equal(theme_grid$panel.grid.major$colour, "red")
})

test_that("grid visibility parameters work", {
  # Test show_grid_major
  theme_no_major <- theme_fivethirtyeight_variant(show_grid_major = FALSE)
  expect_s3_class(theme_no_major$panel.grid.major, "element_blank")

  theme_with_major <- theme_fivethirtyeight_variant(show_grid_major = TRUE)
  expect_s3_class(theme_with_major$panel.grid.major, "element_line")

  # Test show_grid_minor
  theme_no_minor <- theme_fivethirtyeight_variant(show_grid_minor = FALSE)
  expect_s3_class(theme_no_minor$panel.grid.minor, "element_blank")

  theme_with_minor <- theme_fivethirtyeight_variant(show_grid_minor = TRUE)
  expect_s3_class(theme_with_minor$panel.grid.minor, "element_line")
})

test_that("font size multipliers work correctly", {
  theme <- theme_fivethirtyeight_variant(
    base_size = 10,
    title_size = 2,
    axis_title_size = 0.5
  )

  # Title should be base_size * title_size
  expect_equal(theme$plot.title$size, 20)

  # Axis title should be base_size * axis_title_size
  expect_equal(theme$axis.title$size, 5)
})

test_that("theme elements have correct properties", {
  theme <- theme_fivethirtyeight_variant()

  # Check that certain elements are blank
  expect_s3_class(theme$panel.border, "element_blank")
  expect_s3_class(theme$axis.line, "element_blank")
  expect_s3_class(theme$axis.ticks, "element_blank")

  # Check legend position
  expect_equal(theme$legend.position, "top")
  expect_equal(theme$legend.direction, "horizontal")

  # Check text elements exist
  expect_s3_class(theme$plot.title, "element_text")
  expect_s3_class(theme$plot.subtitle, "element_text")
  expect_s3_class(theme$plot.caption, "element_text")
  expect_s3_class(theme$axis.title, "element_text")
  expect_s3_class(theme$axis.text, "element_text")
})

test_that("theme works with different plot types", {
  library(ggplot2)

  # Scatter plot
  p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_fivethirtyeight_variant()
  expect_no_error(print(p1))

  # Bar plot
  p2 <- ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar() +
    theme_fivethirtyeight_variant()
  expect_no_error(print(p2))

  # Line plot
  p3 <- ggplot(economics, aes(x = date, y = unemploy)) +
    geom_line() +
    theme_fivethirtyeight_variant()
  expect_no_error(print(p3))

  # Faceted plot
  p4 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_wrap(~cyl) +
    theme_fivethirtyeight_variant()
  expect_no_error(print(p4))
})

test_that("theme inheritance works correctly", {
  theme <- theme_fivethirtyeight_variant()

  # Should inherit from theme_bw
  # Check that it has the complete theme structure
  expect_true(is.list(theme))
  expect_true(length(theme) > 50)  # themes have many elements

  # Verify it can be combined with other theme elements
  combined_theme <- theme + theme(plot.title = element_text(color = "blue"))
  expect_equal(combined_theme$plot.title$colour, "blue")
})

test_that("edge cases are handled", {
  # Test with extreme values
  expect_no_error(theme_fivethirtyeight_variant(base_size = 1))
  expect_no_error(theme_fivethirtyeight_variant(base_size = 100))

  # Test with empty string for font family
  expect_no_error(theme_fivethirtyeight_variant(base_family = ""))

  # Test with unusual colors
  expect_no_error(theme_fivethirtyeight_variant(
    grid_color = "#FF0000",
    background_color = "transparent"
  ))
})
