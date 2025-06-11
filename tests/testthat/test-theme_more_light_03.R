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
    axis_title_size = 0.5,  # Should have no effect
    show_grid_major = TRUE,
    show_grid_minor = TRUE
  )

  expect_equal(theme_custom$text$size, 14)
  expect_equal(theme_custom$panel.grid.major$colour, "#888888")
  expect_equal(theme_custom$panel.grid.minor$colour, "#888888")
  expect_equal(theme_custom$plot.background$fill, "#fafafa")
  expect_equal(unclass(theme_custom$plot.title$size), 2.0)
  expect_s3_class(theme_custom$axis.title, "element_blank")  # Still blank despite axis_title_size
  expect_s3_class(theme_custom$panel.grid.minor, "element_line")
})

test_that("theme_more_light_03 parameters work in actual plots", {
  library(ggplot2)

  # Plot with custom parameters
  p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(
      grid_color = "#ff0000",  # Red grid for visibility in test
      show_grid_minor = TRUE
    )
  expect_no_error(print(p1))

  # Plot with no grids
  p2 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(show_grid_major = FALSE)
  expect_no_error(print(p2))

  # Plot with custom background
  p3 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(background_color = "#e0e0e0")
  expect_no_error(print(p3))

  # Plot with custom title size
  p4 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_more_light_03(title_size = 2.2) +
    labs(title = "Large Title Test")
  expect_no_error(print(p4))
})

test_that("theme_more_light_03 relative sizing is updated correctly", {
  # The fixed theme now uses title_size parameter instead of hardcoded 1.64
  theme_default <- theme_more_light_03()
  expect_equal(unclass(theme_default$plot.title$size), 1.6)  # Default title_size

  # Test that the parameter actually changes the value
  theme_custom <- theme_more_light_03(title_size = 1.64)
  expect_equal(unclass(theme_custom$plot.title$size), 1.64)
})
