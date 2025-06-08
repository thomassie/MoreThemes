test_that("theme_more_light_03 returns a theme object", {
  theme <- theme_more_light_03()
  expect_s3_class(theme, "theme")
  expect_s3_class(theme, "gg")
})

test_that("theme_more_light_03 works with ggplot", {
  library(ggplot2)

  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03()

  expect_s3_class(p, "ggplot")
  expect_no_error(print(p))
})

test_that("theme_more_light_03 parameters work correctly", {
  # Test base_size parameter
  theme_small <- theme_more_light_03(base_size = 10)
  theme_large <- theme_more_light_03(base_size = 20)

  expect_equal(theme_small$text$size, 10)
  expect_equal(theme_large$text$size, 20)

  # Test base_family parameter
  theme_serif <- theme_more_light_03(base_family = "serif")
  expect_equal(theme_serif$text$family, "serif")
})

test_that("theme_more_light_03 has correct background colors", {
  theme <- theme_more_light_03()

  # Check light gray backgrounds
  expect_equal(theme$plot.background$fill, "#f5f5f5")
  expect_equal(theme$panel.background$fill, "#f5f5f5")

  # Check no borders
  expect_true(is.na(theme$plot.background$colour))
  expect_true(is.na(theme$panel.background$colour))
})

test_that("theme_more_light_03 grid lines are configured correctly", {
  theme <- theme_more_light_03()

  # Major grid lines should be medium gray
  expect_equal(theme$panel.grid.major$colour, "#d0d0d0")
  expect_equal(theme$panel.grid.major$linewidth, 0.5)
  expect_equal(theme$panel.grid.major$linetype, "solid")

  # Check x and y grid lines specifically
  expect_equal(theme$panel.grid.major.x$colour, "#d0d0d0")
  expect_equal(theme$panel.grid.major.x$linewidth, 0.5)
  expect_equal(theme$panel.grid.major.y$colour, "#d0d0d0")
  expect_equal(theme$panel.grid.major.y$linewidth, 0.5)

  # Minor grid lines should be blank
  expect_s3_class(theme$panel.grid.minor, "element_blank")
})

test_that("theme_more_light_03 axis styling is correct", {
  theme <- theme_more_light_03()

  # No axis lines or ticks
  expect_s3_class(theme$axis.line, "element_blank")
  expect_s3_class(theme$axis.ticks, "element_blank")

  # X-axis text should be bold dark gray
  expect_equal(theme$axis.text.x$colour, "#2d2d2d")
  expect_equal(theme$axis.text.x$face, "bold")

  # Y-axis text should be regular medium gray
  expect_equal(theme$axis.text.y$colour, "#666666")
  expect_true(is.null(theme$axis.text.y$face) || theme$axis.text.y$face == "plain")

  # No axis titles
  expect_s3_class(theme$axis.title, "element_blank")
})

test_that("theme_more_light_03 title elements are configured correctly", {
  theme <- theme_more_light_03()

  # Title should be bold dark gray
  expect_equal(theme$plot.title$colour, "#2d2d2d")
  expect_equal(theme$plot.title$face, "bold")
  expect_equal(theme$plot.title$hjust, 0)  # left-aligned
})

test_that("theme_more_light_03 legend is hidden", {
  theme <- theme_more_light_03()

  # Legend should be hidden
  expect_equal(theme$legend.position, "none")
})

test_that("theme_more_light_03 works with different plot types", {
  library(ggplot2)

  # Bar plot
  p1 <- ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar() +
    theme_more_light_03()
  expect_no_error(print(p1))

  # Line plot
  p2 <- ggplot(economics, aes(x = date, y = unemploy)) +
    geom_line() +
    theme_more_light_03()
  expect_no_error(print(p2))

  # Scatter plot
  p3 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point() +
    theme_more_light_03()
  expect_no_error(print(p3))

  # Column chart
  p4 <- data.frame(x = letters[1:5], y = 1:5) |>
    ggplot(aes(x = x, y = y)) +
    geom_col() +
    theme_more_light_03()
  expect_no_error(print(p4))
})

test_that("theme_more_light_03 margins are set correctly", {
  theme <- theme_more_light_03()

  # Check plot margins
  margins <- theme$plot.margin
  expect_s3_class(margins, "margin")

  # Check all margins are 20
  expect_equal(as.numeric(margins)[1], 20)  # top
  expect_equal(as.numeric(margins)[2], 20)  # right
  expect_equal(as.numeric(margins)[3], 20)  # bottom
  expect_equal(as.numeric(margins)[4], 20)  # left
})

test_that("theme_more_light_03 relative sizing works", {
  theme <- theme_more_light_03(base_size = 10)

  # Check that sizes are relative objects where used
  expect_s3_class(theme$axis.text.x$size, "rel")
  expect_s3_class(theme$axis.text.y$size, "rel")
  expect_s3_class(theme$plot.title$size, "rel")

  # Check the relative values
  expect_equal(unclass(theme$axis.text.x$size), 1)      # 100% of base
  expect_equal(unclass(theme$axis.text.y$size), 0.91)   # 91% of base
  expect_equal(unclass(theme$plot.title$size), 1.64)    # 164% of base
})

test_that("theme_more_light_03 inheritance works correctly", {
  theme <- theme_more_light_03()

  # Should inherit from theme_minimal
  # Verify it can be combined with other theme elements
  combined_theme <- theme + theme(plot.title = element_text(color = "blue"))
  expect_equal(combined_theme$plot.title$colour, "blue")

  # Check that it has the complete theme structure
  expect_true(is.list(theme))
  expect_true(length(theme) > 50)  # themes have many elements
})

test_that("theme_more_light_03 edge cases are handled", {
  # Test with extreme values
  expect_no_error(theme_more_light_03(base_size = 1))
  expect_no_error(theme_more_light_03(base_size = 100))

  # Test with different font families
  expect_no_error(theme_more_light_03(base_family = ""))
  expect_no_error(theme_more_light_03(base_family = "serif"))
  expect_no_error(theme_more_light_03(base_family = "mono"))
})

test_that("theme_more_light_03 unique features work correctly", {
  theme <- theme_more_light_03()

  # This theme has different colors for x and y axis text
  expect_false(identical(theme$axis.text.x$colour, theme$axis.text.y$colour))

  # X-axis text is bold, y-axis is not
  expect_equal(theme$axis.text.x$face, "bold")

  # No panel border
  expect_s3_class(theme$panel.border, "element_blank")

  # Verify specific grid line configuration
  expect_false(is.null(theme$panel.grid.major.x))
  expect_false(is.null(theme$panel.grid.major.y))
})
