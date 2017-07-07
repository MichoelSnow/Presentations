#######################################################
#######################################################
#######################################################
#######################################################
#######################################################
# SECTION 1 - THE BASICS

# Mathemtical and Boolean Operations
-sqrt(25) + (5+3)/4*7 - 2^2
5%/%3 # Integer Division
5%%3 # Modulo (remainder after division)
5 == 6
5 != 6
83 > 25 >= 23
83 > (25 >= 23)
5 > 3 & 3 < 2
5 > 3 | 3 < 2

# Vectors and Sequences
1:4
c(5,3,2,1) # Creates a list
c(12,1:4,6)
seq(from = 1, t= 10, by = 2) # Creates a vector with the given paramters
seq(1,10,2) # creates the same vector without naming the paramters
seq(1,10) # R uses the default values for any empty parameters
seq(to = 10, by = 2)
seq(by = 2, to = 10)
seq(from = 20, by = 2)
c(seq(1,10,2), 25, 10)
c(seq(1,10,2), 25, 10) > 12
c(seq(1,10,2), 25, 10) * 2

# Help function
?seq # opens the Documentation for the function
??seq # searches the help documentation for the queried string


# Variables and Assignment
x = 5+3
(x = 5+3)
x <- 5+3
(x <- 5+3)
y <- x
x <- 5+3 > 2
x <- seq(172,23,-13)

# Indexing - R starts at 1
x[1]    
x[c(1,3)] 
x[2:4] 
x[4:2] 
x[]
x[-1]
x[-c(1,3)]
x[x%%2==0]
y <- x[x%%2==0]
y[9] <- 10


# Built in Functions
x <-  1:100
mean(x)
max(x)
min(x)
length(x)
range(x)
prod(x)
var(x)
log(x)
sqrt(x)

# Installing and Loading packages
# install.packages(c("nycflights13", "gapminder", "Lahman"))
install.packages("tidyverse") # only needs to be done once
library(tidyverse) # needs to be loaded every session you want to use it

# QUESTIONS
# 1. Create a vector of 2 through 8 squared:
# 4, 9, 16, 25, 36, 49, 64

# 2. Create a vector of the square roots of the sum of sqaures of every pair of digits of 1 to 100
# sqrt(1^2+2^2), sqrt(3^2+4^2), sqrt(5^2+6^2), ... , sqrt(99^2+100^2)

# 3. Create a vector of the numbers 1 to 100 not divisible by 3 or 5
# 1, 2, 4, 7, 8, 11, 13, 14, 16, 17, ... , 97, 98


# ANSWERS
# 1. c(2:8)^2 
# 1. c(4,9,16,25,36,49,64)
# 2. sqrt(seq(1,100,2)^2+seq(2,100,2)^2)
# 3. x <- 1:100
#    x[x%%3!=0 & x%%5!=0]

#######################################################
#######################################################
#######################################################
#######################################################
#######################################################
# SECTION 2 - DATA VISUALISATIONS 

# The Grammar of graphics or ggplot
# See http://vita.had.co.nz/papers/layered-grammar.pdf for an in-depth discussion


# Graphics in ggplot are built in layers
mpg # dataset built in to ggplot
summary(mpg) 
mpg$model

# The ggplot command begins a plot to which you can add layers
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data=mpg) +
  geom_smooth(aes(displ, hwy)) + geom_point(aes(displ,hwy))

# by inserting x and y into ggplot all layers will use those parameters unless otherwise specified
ggplot(mpg, aes(displ,hwy)) + geom_smooth() + geom_point()

ggplot(mpg, aes(displ,hwy)) + geom_smooth() + geom_point() +
  geom_smooth(aes(displ,cty),color = "red")



# Note: if you want to plot a variable to a feature like color or size, it must go in 
#   the aes() term, if you just want to set them at a certain value they go outside the aes
ggplot(mpg, aes(displ,hwy)) + geom_smooth(color = "green") + geom_point(aes(color=class)) 


# You can also split the plot into subplots based on a varible
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(.~cyl)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(cyl~.)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_wrap(~cyl)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(cyl~class)














# Working with data
state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
           "qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
           "sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
           "sa", "act", "nsw", "vic", "vic", "act")
statef <- factor(state)
levels(statef)
incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
             61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
             59, 46, 58, 43)
incmeans <- tapply(incomes, statef, mean)
