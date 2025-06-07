<img src="/assets/MoreThemes_HexLogo_QuicksandRegular400.png" align="right" height="139"/><br><br><br>
# MoreThemes
Additional themes for ggplot2 visualizations.
## Installation
You can install the development version of MoreThemes from GitHub:
```r
# install.packages("devtools")
devtools::install_github("thomassie/MoreThemes")
```
## Available Themes

The package currently includes two themes:

### 1. `theme_more_light_01()`
A customizable light theme with warm tones and flexible grid options.

### 2. `theme_more_light_02()`
A clean, minimal theme with subtle gray backgrounds and right-positioned legends.

## Usage Examples

### Using theme_more_light_01
```r
library(ggplot2)
library(MoreThemes)

# Basic usage with warm background
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

### Using theme_more_light_02
```r
# Clean minimal style with light gray background
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  theme_more_light_02() +
  labs(title = "Fuel Efficiency by Weight",
       x = "Weight (1000 lbs)",
       y = "Miles per Gallon")

# Bar chart with the minimal theme
ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  theme_more_light_02() +
  labs(title = "Distribution of Cylinders",
       x = "Number of Cylinders",
       y = "Count") +
  scale_fill_brewer(palette = "Set2", guide = "none")
```

## Theme Features

### theme_more_light_01
- Warm, customizable background colors (default: #EDE9DE)
- Flexible grid line options (major and minor)
- Top-positioned horizontal legend
- Bold titles with adjustable sizes
- Subtle facet strip styling

**Parameters:**
- `base_size`: Base font size (default: 12)
- `base_family`: Base font family (default: "sans")
- `grid_color`: Color of grid lines (default: "#D8D2C2")
- `background_color`: Panel background color (default: "#EDE9DE")
- `title_size`: Title font size multiplier (default: 1.2)
- `axis_title_size`: Axis title size multiplier (default: 0.9)
- `show_grid_major`: Show major grid lines (default: TRUE)
- `show_grid_minor`: Show minor grid lines (default: FALSE)

### theme_more_light_02
- Clean, minimalist design with light gray background (#f8f8f8)
- Very subtle grid lines for unobtrusive data focus
- Right-positioned legend with bold text
- No subtitle or caption for maximum simplicity
- Gray axis text and titles for reduced visual weight

**Parameters:**
- `base_size`: Base font size (default: 11)
- `base_family`: Base font family (default: "")

## Contributing
Feel free to submit issues, fork the repository, and create pull requests to add more themes!

## License
MIT License
