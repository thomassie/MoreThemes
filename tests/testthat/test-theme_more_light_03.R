# Add these tests to your existing test file for theme_more_light_03

test_that("theme_more_light_03 grid visibility parameters work", {
  # Test with major grid off
  theme_no_major <- theme_more_light_03(show_grid_major = FALSE)
  expect_s3_class(theme_no_major$panel.grid.major, "element_blank")
  expect_s3_class(theme_no_major$panel.grid.major.x, "element_blank")
  expect_s3_class(theme_no_major$panel.grid.major.y, "element_blank")

  # Test with minor grid on
  theme_with_minor <- theme_more_light_03(show_grid_minor = TRUE)
  expect_s3_class(theme_with_minor$panel.grid.minor, "element_line")
  expect_equal(theme_with_minor$panel.grid.minor$colour, "#d0d0d0")
  expect_equal(theme_with_minor$panel.grid.minor$linewidth, 0.25)

  # Test with both grids off
  theme_no_grids <- theme_more_light_03(show_grid_major = FALSE, show_grid_minor = FALSE)
  expect_s3_class(theme_no_grids$panel.grid.major, "element_blank")
  expect_s3_class(theme_no_grids$panel.grid.minor, "element_blank")
})

test_that("theme_more_light_03 color parameters work", {
  # Test custom grid color
  custom_grid_color <- "#aaaaaa"
  theme_custom_grid <- theme_more_light_03(grid_color = custom_grid_color)
  expect_equal(theme_custom_grid$panel.grid.major$colour, custom_grid_color)
  expect_equal(theme_custom_grid$panel.grid.major.x$colour, custom_grid_color)
  expect_equal(theme_custom_grid$panel.grid.major.y$colour, custom_grid_color)

  # Test custom grid color with minor grid enabled
  theme_custom_both <- theme_more_light_03(grid_color = custom_grid_color, show_grid_minor = TRUE)
  expect_equal(theme_custom_both$panel.grid.major$colour, custom_grid_color)
  expect_equal(theme_custom_both$panel.grid.minor$colour, custom_grid_color)

  # Test custom background color
  custom_bg_color <- "#ffffff"
  theme_custom_bg <- theme_more_light_03(background_color = custom_bg_color)
  expect_equal(theme_custom_bg$plot.background$fill, custom_bg_color)
  expect_equal(theme_custom_bg$panel.background$fill, custom_bg_color)
})

test_that("theme_more_light_03 size multiplier parameters work", {
  # Test title size multiplier
  theme_big_title <- theme_more_light_03(title_size = 2.5)
  expect_equal(unclass(theme_big_title$plot.title$size), 2.5)

  theme_small_title <- theme_more_light_03(title_size = 1.0)
  expect_equal(unclass(theme_small_title$plot.title$size), 1.0)

  # Test subtitle size multiplier
  theme_big_subtitle <- theme_more_light_03(subtitle_size = 1.5)
  expect_equal(unclass(theme_big_subtitle$plot.subtitle$size), 1.5)

  theme_small_subtitle <- theme_more_light_03(subtitle_size = 0.8)
  expect_equal(unclass(theme_small_subtitle$plot.subtitle$size), 0.8)

  # Note: axis_title_size parameter is included but has no effect since axis.title = element_blank()
  # This is intentional as per the theme description
  theme_axis_param <- theme_more_light_03(axis_title_size = 2.0)
  expect_s3_class(theme_axis_param$axis.title, "element_blank")
})

test_that("theme_more_light_03 parameter combinations work", {
  # Test multiple parameters together
  theme_custom <- theme_more_light_03(
    base_size = 14,
    grid_color = "#888888",
    background_color = "#fafafa",
    title_size = 2.0,
    subtitle_size = 1.2,
    axis_title_size = 0.5,  # Should have no effect
    show_grid_major = TRUE,
    show_grid_minor = TRUE
  )

  expect_equal(theme_custom$text$size, 14)
  expect_equal(theme_custom$panel.grid.major$colour, "#888888")
  expect_equal(theme_custom$panel.grid.minor$colour, "#888888")
  expect_equal(theme_custom$plot.background$fill, "#fafafa")
  expect_equal(unclass(theme_custom$plot.title$size), 2.0)
  expect_equal(unclass(theme_custom$plot.subtitle$size), 1.2)
  expect_s3_class(theme_custom$axis.title, "element_blank")  # Still blank despite axis_title_size
  expect_s3_class(theme_custom$panel.grid.minor, "element_line")
})

test_that("theme_more_light_03 subtitle styling works correctly", {
  # Test subtitle default styling
  theme_default <- theme_more_light_03()
  expect_equal(theme_default$plot.subtitle$colour, "#666666")
  expect_equal(theme_default$plot.subtitle$hjust, 0)
  expect_equal(unclass(theme_default$plot.subtitle$size), 1.1)

  # Test subtitle margins (margins are stored as grid units)
  expect_s3_class(theme_default$plot.subtitle$margin, "margin")
  expect_equal(as.numeric(theme_default$plot.subtitle$margin)[1], 0)  # top
  expect_equal(as.numeric(theme_default$plot.subtitle$margin)[3], 15) # bottom
})

test_that("theme_more_light_03 legend is hidden", {
  # Test that legend is hidden as per theme description
  theme_default <- theme_more_light_03()
  expect_equal(theme_default$legend.position, "none")

  # Test with different parameters
  theme_custom <- theme_more_light_03(title_size = 2.0, subtitle_size = 1.3)
  expect_equal(theme_custom$legend.position, "none")
})

test_that("theme_more_light_03 parameters work in actual plots", {
  library(ggplot2)

  # Plot with custom parameters including subtitle
  p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(
      grid_color = "#ff0000",  # Red grid for visibility in test
      show_grid_minor = TRUE,
      subtitle_size = 1.3
    ) +
    labs(title = "Test Plot", subtitle = "Test Subtitle")
  expect_no_error(print(p1))

  # Plot with no grids
  p2 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(show_grid_major = FALSE)
  expect_no_error(print(p2))

  # Plot with custom background and subtitle
  p3 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(
      background_color = "#e0e0e0",
      subtitle_size = 0.9
    ) +
    labs(title = "Custom Background", subtitle = "Smaller subtitle")
  expect_no_error(print(p3))

  # Plot with custom title size
  p4 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(
      title_size = 2.2,
      subtitle_size = 1.0
    ) +
    labs(title = "Large Title Test", subtitle = "Normal subtitle")
  expect_no_error(print(p4))

  # Plot demonstrating bold minimal aesthetic with subtitle
  p5 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point(color = "#4a90e2", size = 3, alpha = 0.7) +
    theme_more_light_03(
      title_size = 1.8,
      subtitle_size = 1.1,
      grid_color = "#d0d0d0"
    ) +
    labs(
      title = "Bold Minimal Design",
      subtitle = "Clean aesthetic with no axis titles or legend"
    )
  expect_no_error(print(p5))
})

test_that("theme_more_light_03 relative sizing is updated correctly", {
  # The fixed theme now uses title_size parameter instead of hardcoded 1.64
  theme_default <- theme_more_light_03()
  expect_equal(unclass(theme_default$plot.title$size), 1.6)  # Default title_size
  expect_equal(unclass(theme_default$plot.subtitle$size), 1.1)  # Default subtitle_size

  # Test that the parameters actually change the values
  theme_custom <- theme_more_light_03(title_size = 1.64, subtitle_size = 0.95)
  expect_equal(unclass(theme_custom$plot.title$size), 1.64)
  expect_equal(unclass(theme_custom$plot.subtitle$size), 0.95)
})
