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

The package currently includes three themes:

### 1. `theme_more_light_01()`
A customizable light theme with warm tones and flexible grid options.

### 2. `theme_more_light_02()`
A clean, minimal theme with subtle gray backgrounds and right-positioned legends.

### 3. `theme_more_light_03()`
A bold minimal theme with no axis titles or legend, perfect for presentations.

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

### Using theme_more_light_03
```r
# Bold minimal style - great for presentations
ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(fill = "#4a90e2") +
  theme_more_light_03() +
  labs(title = "Distribution of Cylinders")

# Time series with impactful styling
ggplot(economics, aes(x = date, y = unemploy/1000)) +
  geom_line(color = "#e74c3c", size = 1.5) +
  theme_more_light_03() +
  labs(title = "US Unemployment Over Time (thousands)")
```

## Theme Features

### theme_more_light_01
**Design philosophy:** Warm and customizable theme with flexible options for various use cases

**Key features:**
- Warm, customizable background colors (default: #EDE9DE - warm beige)
- Flexible grid line options (default: #D8D2C2 - muted brown)
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
**Design philosophy:** Clean and minimal theme focused on clarity and readability

**Key features:**
- Light gray background for subtle contrast (default: #f8f8f8)
- Very subtle grid lines for unobtrusive data focus (default: #e0e0e0)
- Right-positioned legend with bold text
- No subtitle or caption for maximum simplicity
- Gray axis text and titles for reduced visual weight

**Parameters:**
- `base_size`: Base font size (default: 11)
- `base_family`: Base font family (default: "")
- `grid_color`: Color of grid lines (default: "#e0e0e0")
- `background_color`: Panel background color (default: "#f8f8f8")
- `title_size`: Title font size multiplier (default: 1.3)
- `axis_title_size`: Axis title size multiplier (default: 1)
- `show_grid_major`: Show major grid lines (default: TRUE)
- `show_grid_minor`: Show minor grid lines (default: FALSE)

### theme_more_light_03
**Design philosophy:** Bold and impactful theme for presentations and single-series visualizations

**Key features:**
- No axis titles or legend by default for self-evident data
- Distinctive two-tone axis text styling (bold dark x-axis, gray y-axis)
- Extra large, bold titles for maximum impact (default: 164% of base)
- Medium gray grid lines on light background (default: #d0d0d0 on #f5f5f5)
- Equal margins for balanced appearance

**Parameters:**
- `base_size`: Base font size (default: 11)
- `base_family`: Base font family (default: "")
- `grid_color`: Color of grid lines (default: "#d0d0d0")
- `background_color`: Panel background color (default: "#f5f5f5")
- `title_size`: Title font size multiplier (default: 1.6)
- `axis_title_size`: Axis title size multiplier (default: 0 - hidden)
- `show_grid_major`: Show major grid lines (default: TRUE)
- `show_grid_minor`: Show minor grid lines (default: FALSE)

## Contributing
Feel free to submit issues, fork the repository, and create pull requests to add more themes!

## License
MIT License
