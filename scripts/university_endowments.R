# Load packages
library(dplyr)  # cleaning
library(glue)  # concatenating
library(treemapify)  # treemap plotting
library(ggplot2)  # plotting
library(showtext)  # fonts

# Load data
endowment_raw <- read.csv("data/endowment_data.csv")

# Add fonts
font_add_google("Roboto")
showtext_auto()

# Create plot
plot_endowment <- endowment_raw %>% 
  ggplot(mapping = aes(area = year_2021, subgroup = subgroup, fill = hex, label = glue("{institution_short}\n{label_text}"))) +
  theme_classic() +
  theme(
    text = element_text(family = "Roboto"),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.title = element_text(size = 18, face = "bold", hjust = 0, margin = margin(b = 10)),
    plot.caption = element_text(size = 9, face = "italic", hjust = 0, margin = margin(t = 10)),
    legend.position = "none"
  ) +
  labs(
    title = "Top 20 University Endowments", 
    caption = c("Data: nces.ed.gov; FY 2021\nViz: Tim Fulton, PhD")
  ) +
  geom_treemap(
    start = "topleft",
    size = 2,
    color = "white"
  ) +
  geom_treemap_subgroup_border(
    color = "white",
    size = 7,
    start = "topleft"
  ) +
  geom_treemap_subgroup_text(
    start = "topleft",
    place = "center", 
    grow = T, 
    alpha = 0.4, 
    color = "black", 
    fontface = "italic"
  ) +
  geom_treemap_text(
    start = "topleft",
    color = "white",
    place = "topleft",
    size = 12,
    padding.x = grid::unit(2, "mm"),
    padding.y = grid::unit(2, "mm"),
  ) + 
  scale_fill_identity()

# Save plot
ggsave("plots/endowments.png", 
       plot = plot_endowment, 
       width = 8, 
       height = 5, 
       dpi = 600,
       units = "in")
