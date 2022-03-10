#' ---
#' title: "Class 05 Data Visualization"
#' author: "Seong Tae Gwon (PID: A12364788)"
#' ---

# Week 5 Data visualization Lab

# Section 5: Creating Scatter Plots
# install.package("ggplot2")
library(ggplot2)

# Input data set
cars
View(cars)

# A quick base R plot
plot(cars)

# Specifying a dataset with ggplot()
ggplot(cars)

# Specifying aesthetic mappings with aes()
ggplot(cars) +
  aes(x=speed, y=dist)

# First geom_point() plot of cars data
ggplot(cars) +
  aes(x=speed, y=dist) +
  geom_point()

# Q1: Which geometric layer should be used to create scatter plots in ggplot2?
# A: geom_point()

# Q2:scatter plot using ggplot
ggplot(cars) +
  aes(x=speed, y=dist) +
  geom_point() +
  geom_smooth()

# Q3: scatter plot with added various label annotations
ggplot(cars) + 
  aes(x=speed, y=dist) +
  geom_point() +
  labs(title="Speed and Stopping Distances of Cars",
       x="Speed (MPH)", 
       y="Stopping Distance (ft)",
       subtitle = "Your informative subtitle text here",
       caption="Dataset: 'cars'") +
  geom_smooth(method="lm", se=FALSE) +
  theme_bw()

# Adding more plot aesthetics through aes()
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

# Q4: Use the nrow() function to find out how many genes are in this dataset. What is your answer? 
nrow(genes)
# A: 5196

# Q5: Use the colnames() function and the ncol() function on the genes data frame to find out what the column names are (we will need these later) and how many columns there are. How many columns did you find?
colnames(genes)
ncol(genes)
# A: 4

# Q6: Use the table() function on the State column of this data.frame to find out how many ‘up’ regulated genes there are. What is your answer
table(genes$State)
# A: 127

# Q7: Using your values above and 2 significant figures. What fraction of total genes is up-regulated in this dataset?
round( table(genes$State)/nrow(genes) * 100, 2 )
# A: 2.44

# Q8: Produce a scatter plot using Condition 1 for x and Condition 2 for y 
ggplot(genes) + 
  aes(x=Condition1, y=Condition2) +
  geom_point()

# Mapping "State" column to point color 
p <- ggplot(genes) + 
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()
p

p + scale_colour_manual( values=c("blue","gray","red") )

# Q9: Produce a scatter plot using Control for x and Drug Treatment for y with some plot annotation
p + scale_colour_manual(values=c("blue","gray","red")) +
  labs(title="Gene Expresion Changes Upon Drug Treatment",
       x="Control (no drug) ",
       y="Drug Treatment")

# Section 6: Optional: Going Further
#install.packages("gapminder")
library(gapminder)

# File location online
url <- "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"

gapminder <- read.delim(url)

#install.packages("dplyr")
library(dplyr)

gapminder_2007 <- gapminder %>% filter(year==2007)

# Q1
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp) +
  geom_point()

ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp) +
  geom_point(alpha=0.5)

ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) +
  geom_point(alpha=0.5)

ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = pop) +
  geom_point(alpha=0.8)

ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, size = pop) +
  geom_point(alpha=0.5)

ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop), alpha=0.5) + 
  scale_size_area(max_size = 10)

# Q2
gapminder_1957 <- gapminder %>% filter(year==1957)

ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color=continent,
      size = pop) +
  geom_point(alpha=0.7) + 
  scale_size_area(max_size = 10) 

# Q3
gapminder_1957 <- gapminder %>% filter(year==1957 | year==2007)

ggplot(gapminder_1957) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, color=continent,
                 size = pop), alpha=0.7) + 
  scale_size_area(max_size = 10) +
  facet_wrap(~year)

# Section 7: Optional: Bar Charts
gapminder_top5 <- gapminder %>% 
  filter(year==2007) %>% 
  arrange(desc(pop)) %>% 
  top_n(5, pop)

gapminder_top5

ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop))

ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = continent))

ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = lifeExp))

ggplot(gapminder_top5) +
  aes(x=country, y=pop, fill=gdpPercap) +
  geom_col()

ggplot(gapminder_top5) +
  aes(x=reorder(country, -pop), y=pop, fill=gdpPercap) +
  geom_col()

ggplot(gapminder_top5) +
  aes(x=reorder(country, -pop), y=pop, fill=country) +
  geom_col(col="gray30") +
  guides(fill=FALSE)

USArrests

head(USArrests)

USArrests$State <- rownames(USArrests)
ggplot(USArrests) +
  aes(x=reorder(State,Murder), y=Murder) +
  geom_col() +
  coord_flip()

ggplot(USArrests) +
  aes(x=reorder(State,Murder), y=Murder) +
  geom_point() +
  geom_segment(aes(x=State, 
                   xend=State, 
                   y=0, 
                   yend=Murder), color="blue") +
  coord_flip()

# Section 8: Advanced: Plot Animation
#install.packages("gifski")
#install.packages("gganimate")

library(gapminder)
library(gganimate)

# Animated plot

# # Setup nice regular ggplot of the gapminder data
# ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
#   geom_point(alpha = 0.7, show.legend = FALSE) +
#   scale_colour_manual(values = country_colors) +
#   scale_size(range = c(2, 12)) +
#   scale_x_log10() +
#   # Facet by continent
#   facet_wrap(~continent) +
#   # Here comes the gganimate specific bits
#   labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
#   transition_time(year) +
#   shadow_wake(wake_length = 0.1, alpha = FALSE)

# Section 9: Combining plots
#install.packages("patchwork")
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) /
  p4
