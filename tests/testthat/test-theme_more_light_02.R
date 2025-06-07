test_that("theme_more_light_02 returns a theme object", {
  theme <- theme_more_light_02()
  expect_s3_class(theme, "theme")
  expect_s3_class(theme, "gg")
})

test_that("theme_more_light_02 works with ggplot", {
  library(ggplot2)

  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_02()

  expect_s3_class(p, "ggplot")
  expect_no_error(print(p))
})

test_that("theme_more_light_02 parameters work correctly", {
  # Test base_size parameter
  theme_small <- theme_more_light_02(base_size = 10)
  theme_large <- theme_more_light_02(base_size = 20)

  expect_equal(theme_small$text$size, 10)
  expect_equal(theme_large$text$size, 20)

  # Test base_family parameter
  theme_serif <- theme_more_light_02(base_family = "serif")
  expect_equal(theme_serif$text$family, "serif")
})

test_that("theme_more_light_02 has correct background colors", {
  theme <- theme_more_light_02()

  # Check light gray backgrounds
  expect_equal(theme$plot.background$fill, "#f8f8f8")
  expect_equal(theme$panel.background$fill, "#f8f8f8")

  # Check no borders
  expect_true(is.na(theme$plot.background$colour))
  expect_true(is.na(theme$panel.background$colour))
})

test_that("theme_more_light_02 grid lines are configured correctly", {
  theme <- theme_more_light_02()

  # Major grid lines should be subtle gray
  expect_equal(theme$panel.grid.major$colour, "#e0e0e0")
  expect_equal(theme$panel.grid.major$linewidth, 0.3)
  expect_equal(theme$panel.grid.major$linetype, "solid")

  # Minor grid lines should be blank
  expect_s3_class(theme$panel.grid.minor, "element_blank")
})

test_that("theme_more_light_02 axis styling is correct", {
  theme <- theme_more_light_02()

  # No axis lines or ticks
  expect_s3_class(theme$axis.line, "element_blank")
  expect_s3_class(theme$axis.ticks, "element_blank")

  # Axis text should be gray
  expect_equal(theme$axis.text.x$colour, "#999999")
  expect_equal(theme$axis.text.y$colour, "#999999")

  # Axis titles should be gray
  expect_equal(theme$axis.title.x$colour, "#999999")
  expect_equal(theme$axis.title.y$colour, "#999999")
  expect_equal(theme$axis.title.y$angle, 90)
})

test_that("theme_more_light_02 title elements are configured correctly", {
  theme <- theme_more_light_02()

  # Title should be bold black
  expect_equal(theme$plot.title$colour, "#000000")
  expect_equal(theme$plot.title$face, "bold")
  expect_equal(theme$plot.title$hjust, 0)  # left-aligned

  # Subtitle and caption should be blank
  expect_s3_class(theme$plot.subtitle, "element_blank")
  expect_s3_class(theme$plot.caption, "element_blank")
})

test_that("theme_more_light_02 legend is positioned correctly", {
  theme <- theme_more_light_02()

  # Legend on right
  expect_equal(theme$legend.position, "right")
  expect_equal(theme$legend.justification, "center")

  # Legend styling
  expect_s3_class(theme$legend.background, "element_blank")
  expect_s3_class(theme$legend.key, "element_blank")
  expect_s3_class(theme$legend.title, "element_blank")

  # Legend text should be bold black
  expect_equal(theme$legend.text$colour, "#000000")
  expect_equal(theme$legend.text$face, "bold")
})

test_that("theme_more_light_02 works with different plot types", {
  library(ggplot2)

  # Scatter plot
  p1 <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point() +
    theme_more_light_02()
  expect_no_error(print(p1))

  # Bar plot
  p2 <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
    geom_bar() +
    theme_more_light_02()
  expect_no_error(print(p2))

  # Line plot
  p3 <- ggplot(economics, aes(x = date, y = unemploy)) +
    geom_line() +
    theme_more_light_02()
  expect_no_error(print(p3))

  # Faceted plot
  p4 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_wrap(~cyl) +
    theme_more_light_02()
  expect_no_error(print(p4))
})

test_that("theme_more_light_02 facet styling is correct", {
  theme <- theme_more_light_02()

  # Strip background should be blank
  expect_s3_class(theme$strip.background, "element_blank")

  # Strip text should be bold black
  expect_equal(theme$strip.text$colour, "#000000")
  expect_equal(theme$strip.text$face, "bold")
})

test_that("theme_more_light_02 margins are set correctly", {
  theme <- theme_more_light_02()

  # Check plot margins
  margins <- theme$plot.margin
  expect_s3_class(margins, "margin")

  # Check specific margin values
  expect_equal(as.numeric(margins)[1], 20)  # top
  expect_equal(as.numeric(margins)[2], 25)  # right
  expect_equal(as.numeric(margins)[3], 20)  # bottom
  expect_equal(as.numeric(margins)[4], 20)  # left
})

test_that("theme_more_light_02 relative sizing works", {
  theme <- theme_more_light_02(base_size = 10)

  # Check that sizes are relative objects
  expect_s3_class(theme$axis.text.x$size, "rel")
  expect_s3_class(theme$axis.text.y$size, "rel")
  expect_s3_class(theme$plot.title$size, "rel")
  expect_s3_class(theme$strip.text$size, "rel")

  # Check the relative values
  expect_equal(unclass(theme$axis.text.x$size), 0.9)
  expect_equal(unclass(theme$axis.text.y$size), 0.9)
  expect_equal(unclass(theme$plot.title$size), 1.3)
  expect_equal(unclass(theme$strip.text$size), 1.1)
})

test_that("theme_more_light_02 inheritance works correctly", {
  theme <- theme_more_light_02()

  # Should inherit from theme_minimal
  # Verify it can be combined with other theme elements
  combined_theme <- theme + theme(plot.title = element_text(color = "blue"))
  expect_equal(combined_theme$plot.title$colour, "blue")

  # Check that it has the complete theme structure
  expect_true(is.list(theme))
  expect_true(length(theme) > 50)  # themes have many elements
})

test_that("theme_more_light_02 edge cases are handled", {
  # Test with extreme values
  expect_no_error(theme_more_light_02(base_size = 1))
  expect_no_error(theme_more_light_02(base_size = 100))

  # Test with different font families
  expect_no_error(theme_more_light_02(base_family = ""))
  expect_no_error(theme_more_light_02(base_family = "serif"))
  expect_no_error(theme_more_light_02(base_family = "mono"))
})
