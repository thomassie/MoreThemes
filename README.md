<img src="/assets/MoreThemes_HexLogo_QuicksandRegular400.png" align="right" height="139"/><br><br><br>

# MoreThemes

Additional themes for ggplot2 visualizations.

## Installation

You can install the development version of MoreThemes from GitHub:

```r
# install.packages("devtools")
devtools::install_github("thomassie/MoreThemes")
```

## Usage

The package currently includes `theme_more_light_01()`:

```r
library(ggplot2)
library(MoreThemes)

# Basic usage
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(
    title = "Miles per Gallon vs Weight",
    subtitle = "Colored by number of cylinders",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon",
    color = "Cylinders"
  ) +
  theme_more_light_01()

# Customized version with white background
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 2) +
  labs(
    title = "Iris Dataset: Sepal Dimensions",
    subtitle = "Length vs Width by Species"
  ) +
  theme_more_light_01(
    base_size = 14,
    background_color = "white",
    grid_color = "grey85",
    show_grid_minor = TRUE
  )
```

## Features

The `theme_more_light_01()` function provides:

- Clean, minimalist design
- Customizable background and grid colors
- Adjustable font sizes for different elements
- Option to show/hide major and minor grid lines
- Professional typography with bold titles
- Top-positioned horizontal legend by default
- Subtle facet strip styling

## Parameters

- `base_size`: Base font size (default: 12)
- `base_family`: Base font family (default: "sans")
- `grid_color`: Color of grid lines (default: "#D8D2C2")
- `background_color`: Panel background color (default: "#EDE9DE")
- `title_size`: Title font size multiplier (default: 1.2)
- `axis_title_size`: Axis title size multiplier (default: 0.9)
- `show_grid_major`: Show major grid lines (default: TRUE)
- `show_grid_minor`: Show minor grid lines (default: FALSE)

## Contributing

Feel free to submit issues, fork the repository, and create pull requests to add more themes!

## License

MIT License
