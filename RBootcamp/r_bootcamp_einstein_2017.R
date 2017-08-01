#######################################################
#######################################################
#######################################################
#######################################################
#######################################################

# SECTION 1 - The Basics

## Installing R
### Download R: https://cran.r-project.org/
### R studio: https://www.rstudio.com/products/rstudio/download/

## Resources for R
### R for data science http://r4ds.had.co.nz
### R Programming for Data Science <https://bookdown.org/rdpeng/rprogdatascience/>
### R Bootcamp <https://www.jaredknowles.com/r-bootcamp/>

## Installing and Loading packages
install.packages("tidyverse")
library(tidyverse)

#######################################################
#######################################################
#######################################################
#######################################################
#######################################################
# SECTION 2 - Data Visualisations 


## Graphics in ggplot are built in layers
### mpg is a ggplot dataset of fuel economy data from 1999 and 2008 for 38 popular models of car
mpg
summary(mpg) 
mpg$drv

## The ggplot command begins a plot to which you can add layers
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
  ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = hwy))
  
  

## By inserting x and y into ggplot, all layers will use those parameters unless otherwise specified
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth() + geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth() + geom_point() +
  geom_smooth(mapping = aes(x = displ,y = cty),color = "red")


## if you want to plot a variable to a feature like color or size, it must go in the aes() term, 
## 		If you just want to set them at a certain value they go outside the aes
ggplot(mpg, aes(displ,hwy)) + geom_smooth(color = "green") + 
  geom_point(aes(color=class),size=2)


## You can also split the plot into subplots based on a varible using `facet`
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(.~cyl)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(cyl~.)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_wrap(~cyl)
ggplot(mpg, aes(displ,hwy))  + geom_point() + facet_grid(cyl~class)


## Graphics and Statistical Transformations
### This time we will be using the `diamonds` dataset
summary(diamonds)
ggplot(diamonds,aes(cut)) + geom_bar()
ggplot(diamonds,aes(price)) + geom_histogram(bins=100)

## Computed Variables {.scrollable} 

## Bar charts, histograms and the other plots in the one variable section of the ggplot2 cheat sheet bin your data based on a single variable 
## 		You can determine the computed variables of a graphic by using the help function:
##    		Computed variables  
##				count  
##					Number of points in bin
##				prop  
##					Groupwise proportion

ggplot(diamonds) + geom_bar(aes(x=cut,y=..prop..,group=1))


## Position adjustments
ggplot(diamonds) + geom_bar(aes(x = color, fill = cut), position = "dodge")
ggplot(diamonds) + geom_bar(aes(x = color, fill = cut), position = "fill")
ggplot(diamonds) + geom_bar(aes(x = color, color = cut), position = "stack",fill=NA)

## Example Plots
### plots from http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html

ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
  labs(subtitle="Area Vs Population", y="Population", x="Area", title="Scatterplot", caption = "Source: midwest")


mtcars$`car name` <- rownames(mtcars)  # create new column for car names
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)  # compute normalized mpg
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")  # above / below avg flag
mtcars <- mtcars[order(mtcars$mpg_z), ]  # sort
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)  # convert to factor to retain sorted order in plot.

ggplot(mtcars, aes(x=`car name`, y=mpg_z, label=mpg_z)) + 
  geom_bar(stat='identity', aes(fill=mpg_type), width=.5)  +
  scale_fill_manual(name="Mileage", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  labs(subtitle="Normalised mileage from 'mtcars'", title= "Diverging Bars") + 
  coord_flip()



# prep data
df <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/gdppercap.csv")
colnames(df) <- c("continent", "1952", "1957")
left_label <- paste(df$continent, round(df$`1952`),sep=", ")
right_label <- paste(df$continent, round(df$`1957`),sep=", ")
df$class <- ifelse((df$`1957` - df$`1952`) < 0, "red", "green")

ggplot(df) + geom_segment(aes(x=1, xend=2, y=`1952`, yend=`1957`, col=class), size=.75, show.legend=F) + 
  geom_vline(xintercept=1, linetype="dashed", size=.1) + 
  geom_vline(xintercept=2, linetype="dashed", size=.1) +
  scale_color_manual(labels = c("Up", "Down"), 
                     values = c("green"="#00ba38", "red"="#f8766d")) +  # color of lines
  labs(x="", y="Mean GdpPerCap") +  # Axis labels
  xlim(.5, 2.5) + ylim(0,(1.1*(max(df$`1952`, df$`1957`)))) + # X and Y axis limits
  geom_text(label=left_label, y=df$`1952`, x=rep(1, NROW(df)), hjust=1.1, size=3.5) + 
  geom_text(label=right_label, y=df$`1957`, x=rep(2, NROW(df)), hjust=-0.1, size=3.5) + 
  geom_text(label="Time 1", x=1, y=1.1*(max(df$`1952`, df$`1957`)), hjust=1.2, size=5) +  # title
  geom_text(label="Time 2", x=2, y=1.1*(max(df$`1952`, df$`1957`)), hjust=-0.1, size=5) + # title
  theme(panel.background = element_blank(),panel.grid = element_blank(),axis.ticks = element_blank(),
          axis.text.x = element_blank(),panel.border = element_blank(),plot.margin = unit(c(1,2,1,2), "cm"))


ggplot(mpg, aes(cty)) + 
  geom_density(aes(fill=factor(cyl)), alpha=0.8) + 
  labs(title="Density plot", 
       subtitle="City Mileage Grouped by Number of cylinders",
       caption="Source: mpg",
       x="City Mileage",
       fill="# Cylinders")


ggplot(mpg, aes(class, cty)) +
  geom_violin() + 
  labs(title="Violin plot", 
       subtitle="City Mileage vs Class of vehicle",
       caption="Source: mpg",
       x="Class of Vehicle",
       y="City Mileage")


theme_set(theme_classic())
df <- as.data.frame(table(mpg$class))
colnames(df) <- c("class", "freq")
ggplot(df, aes(x = "", y=freq, fill = factor(class))) + 
  geom_bar(width = 1, stat = "identity") +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill="class", 
       x=NULL, 
       y=NULL, 
       title="Pie Chart of class", 
       caption="Source: mpg") +
  coord_polar(theta = "y", start=0)


EncSz  <-  25
SynPermCon  <-  0.5
PtPrcnt <- 0.75
SPSmpSz <- round(EncSz^2*PtPrcnt) 
ENC <- rep(.3,EncSz^2)
ENC[c(19:83,200:250,353:420,497:585)] <- 1
SPEncBoxes <- tibble(x = rep(c(1:EncSz),EncSz), y = sort(rep(c(1:EncSz),EncSz)))
j <- rep(NA,EncSz^2)
j[sample(EncSz^2,SPSmpSz)] <- rnorm(SPSmpSz,mean=.9*SynPermCon,sd=SynPermCon/5)
j2 <- rep(NA,EncSz^2)
j2[j>0.5] <- 1
j2[j>0.5 & ENC ==1] <- 2
j2[is.na(j)] <- NA
EncAct <- rep(0.1,EncSz^2)
EncAct[j>SynPermCon] <- 1
j <- cut(j,breaks = c(-Inf,seq(0.4,0.6,0.025),Inf))
BlnkGrph = theme(axis.line=element_blank(), axis.text.x=element_blank(), axis.text.y=element_blank(), axis.ticks=element_blank(), axis.title.x=element_blank(),
                 axis.title.y=element_blank(), legend.position="none", panel.background=element_blank(), panel.border=element_blank(), panel.grid.major=element_blank(),
                 panel.grid.minor=element_blank(), plot.background=element_blank(),plot.margin=grid::unit(c(0,0,0,0), "mm"))
SPEncBoxes %>% ggplot(aes(x,y,fill = factor(round(ENC)))) + 
  geom_tile(color = "gray",show.legend=FALSE) + BlnkGrph + coord_fixed() + 
  geom_point(aes(x,y, color = factor(j2)),shape = 16,na.rm=TRUE, size = 3) +
  scale_fill_manual(values = c("white","blue")) + scale_shape_identity() +
  scale_color_manual(values = c("black","green"))
SPEncBoxes %>% ggplot(aes(x,y,fill = j, color = EncAct)) + 
  geom_tile(show.legend=FALSE, size = 0.2,alpha=EncAct) + BlnkGrph + coord_fixed() + 
  scale_color_gradient(low="gray",high ="black") +
  scale_fill_manual(values = c("red","red","red","red","orangered", "orange","yellow","lightgreen","green1","green1"),na.value="white")


## Spend some time playing with ggplot {.scrollable}
##	 See http://ggplot2.tidyverse.org/reference/ for a full list of functions in ggplot
##	 Here are a list of the datasets built into ggplot (use ?"dataset name" to find out more about the individual datasets)
##		 diamonds
##			 Prices of 50,000 round cut diamonds
##		 economics
##			 US economic time series
##		 faithfuld
##			 2d density estimate of Old Faithful data
##		 midwest
##			 Midwest demographics
##		 mpg
##			 Fuel economy data from 1999 and 2008 for 38 popular models of car
##		 msleep
##			 An updated and expanded version of the mammals sleep dataset
##		 presidential
##			 Terms of 11 presidents from Eisenhower to Obama
##		 seals
##			 Vector field of seal movements
##		 txhousing
##			 Housing sales in TX
##		 luv_colours
##			 colors() in Luv space


#######################################################
#######################################################
#######################################################
#######################################################
#######################################################
# SECTION 3 - Data Manipulation


## Mathematical and Boolean Operators
-sqrt(25) + (5+3)/4*7 - 2^2
5%/%3 # Integer Division
5%%3 # Modulo (remainder after division)
5 == 6
5 != 6
83 > (25 >= 23)
5 > 3 & 3 < 2
5 > 3 | 3 < 2


## Vectors and Sequences
1:4
c(5,3,2,1) # Creates a vector via concatenation (hence the c)
c(12,1:4,6)
seq(from = 1, t= 10, by = 2) # Creates a vector with the given paramters
seq(1,10,2) # creates the same vector without naming the paramters
seq(1,10) # R uses the default values for any empty parameters
seq(to = 10, by = 2)
seq(by = 2, to = 10)
c(seq(1,10,2), 25, 10)
c(seq(1,10,2), 25, 10) > 12
c(seq(1,10,2), 25, 10) * 2


## Variables and Assignment
x = 5+3
(x = 5+3)
x <- 5+3
(x <- 5+3)
y <- x
y
x <- 5+3 > 2
x
x <- seq(172,23,-13)
x


## Indexing 
### R starts at 1
x <- seq(172,23,-13)
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
y

## Built in Functions
x <-  1:20
mean(x)
max(x)
min(x)
length(x)
range(x)
prod(x)
var(x)
log(x)
sqrt(x)


## Exercises
### 1. Create a vector of 2 through 8 squared:  
###		 4, 9, 16, 25, 36, 49, 64

### 2. Create a vector of the square roots of the sum of sqaures of every pair of digits of 1 to 100:  
###		 sqrt(1^2 + 2^2), sqrt(3^2 + 4^2), sqrt(5^2 + 6^2), ... , sqrt(99^2 + 100^2)

###3. Create a vector of the numbers 1 to 100 not divisible by 3 or 5:  
###		 1, 2, 4, 7, 8, 11, 13, 14, 16, 17, ... , 97, 98


## Data frames
### When you have data consisting of multiple observations of multiple variables, i.e., a data set, this is most conveniently stored as a dataframe
iris # Famous iris data set which gives the measurements for 50 flowers from each of 3 species of iris
summary(iris) # Very useful function, which gives summaries of each variable


## Matching 
### You can call a single variable fo a dataframe using any of the following formats 
###    - `dataset$variablename`
###    - `dataset['variablename']`
###    - `dataset[variable column position]`
names(iris)
iris$Sepal.Length
iris['Sepal.Length']
iris[1]


## Indexing
### - To call specific elements from the data set you can use either
###    - Variable indexing using the `$` identifier, then using brackets after the variable name to indicate specific position(s)      
###    - Two element indexing, where the first element is the row and the second element is the column (name or position)
iris$Sepal.Length[25:30]
iris[25:30,'Sepal.Length']
iris[25:30,1]
iris[c(25:30,17,1),c(1,4)]


## Tibbles
### While the dataframes built into R are very useful, they are lacking in certain features
### Tibbles are a type of data frame that are lazy (they don't change variable names or types) and surly (e.g., they complain when a variable does not exist)  
### Tibbles differ from traditional data frames in two key ways, printing and subsetting
iris 
as_tibble(iris) # shows only a few rows as well as the type of data in each row


## Tibbles - Partial Matching
iris$Spec
as_tibble(iris)$Spec


## Tibbles - Subsetting
iris[1]
iris[,1]
as_tibble(iris)[1] 
as_tibble(iris)[,1]
as_tibble(iris)[[1]]



## dplyr and the 5 + 1 verbs of data manipulation {.scrollable}
### dplyr is one of the packages in tidyverse which provides a consistent set of data manipulation verbs.  
### 1. filter
###     - Select based on values
### 2. arrange
###     - reorder
### 3. select & rename
###     - select based on names
### 4. mutate & transmute
###     - add new variables that are functions of existing variables
### 5. summarise
###     - condense multiple values to a single value
### 6. group by
###     - perform any operation by group

## dplyr syntax
### - The structure of the verbs is the same regardless of which one you use
###     - verb(data frame, variable1/argument1, variable2/argument2, ...)
###     - The result is a new data frame
filter(iris,Sepal.Length>4, Petal.Width==0.1) # Note that the variable names do not have quotes, '', around them


## Flights dataset
### - On-time data for all flights that departed NYC (i.e. JFK, LGA or EWR) in 2013  
install.packages("nycflights13")
library(nycflights13)
flights 
summary(flights)


## Data Types
### - `int` integers
### - `dbl` doubles or real numbers
### - `chr` character vectors (strings)
### - `dttm` date-time
### - `date` date
### - `lgl` logical (TRUE or FALSE)
### - `fctr` factors (catgeorical variables with fixed possible values, e.g., dropdown list)
### - `list` like a vector but can contain different types of elements
flights[c("dep_time","tailnum","air_time","time_hour")]



## filter
### use `filter()` to find rows/cases where conditions are true
#### Find all flights which went from JFK to Fort Lauderdale in the first week of January
filter(flights, origin == 'JFK', dest == 'FLL', month==1, day <=7)  
filter(flights, (origin == 'JFK' | dest == 'FLL'), month==1, day <=7) # , is the same as AND and | is the same as OR

##### Find all flights going to Fort Lauderdale, Atlanta or O'Hare
filter(flights, dest == "FLL" | dest == "ATL" | dest == "ORD")
filter(flights, dest %in% c("FLL", "ATL","ORD")) # use %in% to search for multiple values in a single variable

#### Find all flights that have values for their departure delays
filter(flights, is.na(dep_delay)) # show all the rows with NA (missing values)
filter(flights, !is.na(dep_delay)) # show only the rows without missing values


## arrange
### use `arrange()` to sort the data based on one or more variables
#### Sort the flights based on their scheduled departure time
arrange(flights,sched_dep_time)
#### Sort the flights based on their scheduled departure time, and break ties using their actual departure time
arrange(flights,sched_dep_time,dep_time)
#### Sort the flights by those scheduled to depart latest, and break ties in that group by those who left earliest
arrange(flights,desc(sched_dep_time),dep_time)


#### - The problems is I forgot about flights which were delayed so left the next morning
#### - Since dep_time is day agnostic, this does not give me the data I am looking for  
#### - I can try and figure out which flights left that day and which left the next or just use a different variable as my metric of the late evening flights which left earliest.
arrange(flights,desc(sched_dep_time),dep_delay) 


## select & rename
### use `select()` and `rename()` to pick variables based on their names 
#### Select the year, month, day, dep_times, and sched_dep_time columns
select(flights,year,month,day,dep_time,sched_dep_time)
select(flights,year:sched_dep_time)
select(flights,1:5)
select(flights,-(dep_delay:time_hour)) # more useful when removing only a few columns

### `rename` lets you change the name of a variable while still keeping the full data set
rename(flights, sun_cycles = year)
flights # Note that we are not assigning any of these outputs, so if you call the original dataset, it hasn't changed

### The `everything()` helper lets you use `select` to rearrange the order of the variables
select(flights, distance, air_time, everything())


## mutate & transmute
### `mutate` adds new variables, while `transmute` drops existing variables
#### create a subset of the full dataset so that you can see new variables being added
flights_sml <- select(flights, dep_time,arr_time, air_time, distance) 
flights_sml
mutate(flights_sml, avg_speed = distance/air_time, dep_hr = dep_time %/% 100, dep_min = dep_time %% 100)
transmute(flights_sml, avg_speed = distance/air_time, dep_hr = dep_time %/% 100, dep_min = dep_time %% 100)


### - There are lots of useful functions which can be applied within mutate/transmute, use `?mutate` for the full suggested list 
###     - `lead()` and `lag()` find the next and previous values in a vector, respectively.  
###     - `cumsum()`, `cummean()`, and others (see help doc) take running sums, means and other properties

#### How much time is there between each flight and the next?
mutate(flights_sml,dep_time_offset = lag(dep_time), dep_time_lag = dep_time - lag(dep_time))
mutate(flights_sml,dep_time_offset = lead(dep_time), dep_time_lead = lead(dep_time) - dep_time)
mutate(flights_sml, total_dist = cumsum(distance))


## summarise & group by
### Summarise reduces multiple values to a single summary metric
summarise(flights, delay = mean(dep_delay))


### - Why does this give us `NA`?
### - In R, missing values are represented by the symbol `NA` (not available)
###     - This is not to be confused with `NaN` (not a number), which refers to impossible values, e.g., dividing by zero
### - When you try to do any operation that includes `NA` values, the output will always be `NA`
###     - Think of `NA`'s as being any possible value, as a result any summary metric will result in an unknown quantity as the uknown `NA` value could have significantly impacted the results
### - To solve this problem most R functions have the option to ignore `NA` value
###     - Usually it is of the form `na.rm=TRUE`
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

### - By itself `summarise` isn't that useful as we rarely want to reduce all our data down to a single metric
### - `summarise` is much more useful when combined with the other expressions
###     - For example, determining the average departure delay of all flights in January
jan_delay <- filter(flights,month==1)
summarise(jan_delay,delay = mean(dep_delay,na.rm = TRUE))

### - However, the real power of `summarise` is seen when coupled with `group_by`
### - `group_by` takes an existing tibble and converts it into a grouped tibble where operations are performed "by group"
###     - by itself `group_by` does not change how the data looks, instead it changes how it interacts with the other verbs, most notably `summarise`
flights_month <- group_by(flights,month)
flights_month
summarise(flights_month,delay=mean(dep_delay,na.rm = TRUE)) 

### Also it's good practice when grouping to add a counts column using `n()`
summarise(flights_month,delay=mean(dep_delay,na.rm = TRUE),count = n()) 


## Pipes
### Often you will need to string multiple actions together which can get somewhat messy
#### On average which hour of the day has the most delayed american airline flights 
flights_mut <- mutate(flights, hr = sched_dep_time%/% 100)
flights_filt <- filter(flights_mut, carrier == 'AA', complete.cases(flights_mut))
flights_sel <- select(flights_filt, dep_time, hr, sched_dep_time, dep_delay)
flights_sel # print out to confirm that you are selecting what you intend
flights_gb <- group_by(flights_sel,hr)
flights_sum <- summarise(flights_gb, mean_delay = mean(dep_delay),count = n())
flights_arr <- arrange(flights_sum, desc(mean_delay))
print(flights_arr,n=24)

### The pipe `%>%` (from the magrittr package which is included in tidyverse) allows you to do the same set of actions in a much simpler manner
flights %>% 
  mutate(hr = sched_dep_time%/% 100) %>% 
  filter(carrier == 'AA', complete.cases(flights_mut)) %>% 
  select(dep_time, hr, sched_dep_time, dep_delay) %>% 
  group_by(hr) %>% 
  summarise(mean_delay = mean(dep_delay),count = n()) %>% 
  arrange(desc(mean_delay))

  
### - Pipes can be thought of as the phrase "and then", so the above code would be read as:
###     1. Take flights and then
###     2. mutate it and then
###     3. filter it and then 
###     4. select it and then ...
### - Pipes are useful when  
###     - There is only a single input and you don't need to combine inputs
###     - You only want a single ouptut and don't care about the outputs from the intermediate steps
### - But remember that without an assignment, the output is not saved to a variable



## Exercises 


### Using the babynames dataset from the babynames package:
#### 1. How popular was your name in the US in the year you were born, i.e. how many other babies were given the same name?
#### 2. Which are the overall most popular girl and boy baby names as measured by count? How many times more popular are they then the next most popular names?
#### 3. Since 1990 how many girls have been named "Michael"
#### 4. What was the 8th most popular year for the name "Michael" as measured by counts?  
#### 5. Which girl's name had the biggest increase in consecutive years, in what years was it, and why?


## Combining Data Manipulation and Visualization 

#### 1. Plot the popularity of the boy's name Brittany since 1950.
#### 2. Using the 5 most popular girl's name from 2015 (based on counts), plot their counts over all the years recorded, using different color for each name. Now plot the same names using the prop value instead.
#### 3. Plot the number of names which have a significant share of the total names, i.e., > 1%, over all years recorded




#######################################################
#######################################################
#######################################################
#######################################################
#######################################################
# SECTION 4 - Data Visualisations 

## Found vs Generated Data 
###   Most of the time in your research you will be using data that you or someone you know generated
###     This will often result in tidy and clean data or if not at least someone you can complain to about why the data is so messy
###   But what about when you have to use 3rd party data, e.g., weather information
###     First you have to find the data (a topic we will not be covering)
###     Then you have to import the data
###     Then you have to clean and tidy the data (not covered today)
###   Dataset formats
###     Columns are variables separated by a delimeter, such as a comma (.csv), semicolon (.csv2), tab (.tsv)
###     Rows are entries and their values form the index column of the data
###     Usually the values in the first row are the names of the columns

## Example csv file
### Trip Duration,Start Time,Stop Time,Start Station ID,Start Station Name 
### 1893,2017-03-01 00:00:32,2017-03-01 00:32:06,2009,Catherine St & Monroe St  
### 223,2017-03-01 00:01:09,2017-03-01 00:04:53,127,Barrow St & Hudson St  
### 1665,2017-03-01 00:01:27,2017-03-01 00:29:12,174,E 25 St & 1 Ave  
### 100,2017-03-01 00:01:29,2017-03-01 00:03:10,316,Fulton St & William St  
### 1229,2017-03-01 00:01:33,2017-03-01 00:22:02,536,1 Ave & E 30 St  
### 613,2017-03-01 00:01:57,2017-03-01 00:12:11,259,South St & Whitehall St  
### 157,2017-03-01 00:02:12,2017-03-01 00:04:49,3329,Degraw St & Smith St  


## Citibike Dataset
### Download the citibike csv files from the citibike_data directory where you downloaded the R file
###   The RBootcamp folder in <https://github.com/mseinstein/Presentations> 
### This dataset is publicly available online from citibike and contains every ride for an entire month
### R has a built in function for reading csv files `read.csv()` which reads the data into a dataframe, but instead we will be using the tidyverse package readr, which uses the slightly different `read_csv()`
###   Feel free to compare the documentation for the two functions if you want to know how they differ
###   Since the `read_csv` function is powerful and versatile it's good to look at its default options before using it

## Import the data
citibike <- read_csv('./citibike_data/201701-citibike-tripdata.csv') # Make sure to change the directory to match where you extracted the file
citibiki_nrw <- citibike %>% select(-c(`Start Station Latitude`,`Start Station Longitude`,`End Station Latitude`,`End Station Longitude`))
write_csv(citibiki_nrw,"test.csv")
























































































































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
