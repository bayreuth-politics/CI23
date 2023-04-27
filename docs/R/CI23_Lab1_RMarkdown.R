################################################
########### Week 1: R + Markdown ###############
################################################


## The Building Blocs in R: Vectors and Dataframes ##

# In  data analysis, we normally work with variables taking a series 
# of values across a number of observations rather than a single quantity.
# R handles these sequences as *vectors*, and you can create your own 
# vectors using the `c()` function (combine):

prime_numbers <- c(2,3,5,7,11)
zero_to_ten <- c(0,1,2,3,4,5,6,7,8,9,10)
friends <- c("Rachel", "Monica", "Joey", "Chandler", "Ross", "Phoebe") 

# Some other ways to create vectors:

one_to_onehundred <- 1:100
#creates a vector with all integers between 1 and 100

the_decimals <- seq(0, 1, by = 0.1) 
#creates a vector with all numbers from 0 to 1 by intervals of 0.1

ones <- rep(1, 100) 
#creates a vector repeating the first argument (1), n times, 
#where n is the second argument (100).

lots_of_friends <- rep(friends, 5) 
#as above but here the first argument is the vector "friends". 

# You can pass mathematical functions and operations to 
# the whole sequences. The function is applied to each element of the 
# original vector, and R will compile a vector with the sequence of results:

squares_of_primes <- prime_numbers^2
ten_to_twenty <- zero_to_ten+10

# Other functions return a single value computed from all the elements 
# in the vector:

length(zero_to_ten) #returns the number of items in a vector
sum(zero_to_ten) #returns the sum of elements of the vector
mean(zero_to_ten) #returns the mean of elements of the vector
median(zero_to_ten) #returns the median of elements of the vector
max(zero_to_ten) #returns the maximum value in the vector
min(zero_to_ten, na.rm=TRUE) #returns the minimum value in the vector

# You can also ask R to evaluate each element of a vector 
# according to a logical expression. This will return a vector of logical 
# values TRUE/FALSE. *Stick a pin on this because it will be very useful 
# when we index and subset dataframe variables later in the lab.* For instance:

zero_to_ten > 6 #is the element larger than six?
zero_to_ten >= 4 #is the element larger or equal than four?
zero_to_ten == 1 #is the element a one? 

# Finally, you can use the `unique()` function to get a vector of the 
# unique elements occurring in a vector, and the `table()` function to 
# see how many times a value occurs. 

fruit <- c("apple", "pear", "pear", "orange", 
           "banana", "apple", "pear", "banana",
           "pear", "apple", "apple", "banana")

unique(fruit)
table(fruit)

# The output of table() is not a vector, but a different class of object, a table.

# Just like vectors are collections of objects, we can create collections of 
# vectors: *data frames*. You can do so by passing your vectors in the 
# `data.frame()` function: By default, your vectors will be treated as columns, 
# and the vector names will become column names. 

zero_to_ten
squares <- zero_to_ten^2
my_dataframe <- data.frame(zero_to_ten, squares)

# Visualise my_dataframe in the console simply by calling:
my_dataframe

# Visualise my_dataframe in a viewer window:
View(my_dataframe)

# You can pass as many arguments to data.frame() as you want:
roots <- sqrt(zero_to_ten)
my_dataframe <- data.frame(zero_to_ten, squares, roots)

# You can give your dataframe columns name within the data.frame() function:
my_dataframe <- data.frame(zero_to_ten, cubes = zero_to_ten^3)

# Be careful when using the `data.frame()` function with the length of 
# your vectors. If the vectors are *not* the same length of each other 
# *but one is a multiple of the other*, the smaller vector will be 
# replicated (or "looped") when you bind them. If the two vector 
# lengths are *not even multiples of each other*, you will not be 
# able to bind them into a dataframe: 

length(fruit) #what's the length of my vector?

data.frame(fruit, binary_variable = c(0,1)) 
#the second vector is of length 2, which is a divisor of 12, so it gets replicated.

data.frame(fruit, binary_variable = c(0,1,0,0,1)) 
#the second vector is of length 5, which is *not* a divisor of 12, so you get an error.  

# Dataframes can take text, numerical and logical vectors. As long as 
# they're the same length, you're good to go:

students <- c("Student A", "Student B", 
              "Student C", "Student D")
grade <- c(1.0, 5.0, 2.3, 1.7)
pass <- grade <= 4.0

data.frame(students, grade, pass)




### CAUSAL INFERENCE INTRO ###

# 1. Create a folder called "causal_inference". There, 
#    create a folder named 'lab1'.

# 2. Download the data (you can use the button on 
#    the website, or read csv files directly from github).

# 3. Open an R script (or Markdown file) and save  
#    it in our “lab1” folder.

# 4. Set your working directory using the 
#    setwd() function or by clicking on “More“. 
#    For example *setwd("~/Desktop/causal_inference/Lab1")*


#### Let's load the data and save it to an object called 'elbe_flooding'

elbe_flooding <- read.csv("elbe_flooding.csv")

elbe_flooding <- read.csv("C:/Users/bt308095/Downloads/elbe_flooding.csv")


# The data we use is from Bechtel/Hainmueller's 2011 paper:
# "How Lasting Is Voter Gratitude? An Analysis of the Short- 
# and Long-Term Electoral Returns to Beneficial Policy"



### Let's now explore the data

# Let's check variable names

names(elbe_flooding)

# And the first 6 observations of the data frame

head(elbe_flooding)

# We can also display the full data frame:

View(elbe_flooding)

### Let's have a look at individual columns (= variables)

elbe_flooding$year

# This is not very helpful, is it? Let's display a summary table.

table(elbe_flooding$year)

# We can also look at unique observations and length of the variables

unique(elbe_flooding$year)
length(elbe_flooding$year)

# Ok, let's now look at more interesting variables. 'spd_z_vs' is the second vote's
# share of the SPD. 

summary(elbe_flooding$spd_z_vs)

# We can also look at the mean directly:

mean(elbe_flooding$spd_z_vs)

# We know the data comprise two elections. Let's look at how the vote share changed

mean(elbe_flooding$spd_z_vs[elbe_flooding$year==1998])

# And the same for 2000

mean(elbe_flooding$spd_z_vs[elbe_flooding$year==2002])

# Let's save the average vote share's as objects.

avg_SPD_98 <- mean(elbe_flooding$spd_z_vs[elbe_flooding$year==1998])
avg_SPD_02 <- mean(elbe_flooding$spd_z_vs[elbe_flooding$year==2002])

# And compute the difference

diff_spd <- avg_SPD_02 - avg_SPD_98
diff_spd

# Let's subset the data so we only consider cross-sectional comparisons

elbe_98 <- elbe_flooding[elbe_flooding$year==1998,]

# Note that the comma is crucial -  this way we indicate we subset by row.


################################

# Let's analyse the 98 election

# What was the difference between areas where the PDS received 5%+?

elbe_98$pds_dummy <-NA
elbe_98$pds_dummy[elbe_98$pds_z_vs>=5] <- 1
elbe_98$pds_dummy[elbe_98$pds_z_vs<5] <- 0

mean(elbe_98$spd_z_vs[elbe_98$pds_dummy==1]) - mean(elbe_98$spd_z_vs[elbe_98$pds_dummy==0]) 

# Was SPD vote share related to population density?

cor(elbe_98$spd_z_vs, elbe_98$popdensity)

# Is this significant?

cor.test(elbe_98$spd_z_vs, elbe_98$popdensity)

# Let's run a bivariate OLS now

OLS <-  lm(spd_z_vs ~ popdensity, data=elbe_98)
summary(OLS)

# Let's plot this to get a better idea

plot(elbe_98$popdensity, elbe_98$spd_z_vs, main = "Correlation",
  ylab = "SPD Vote Share 98",
  xlab = "Population Density") 

# Ok, but let's add a line of best fit

plot(elbe_98$popdensity, elbe_98$spd_z_vs, main = "Correlation",
     ylab = "SPD Vote Share 98",
     xlab = "Population Density") +
  abline(lm(elbe_98$spd_z_vs ~ elbe_98$popdensity))

# R's basic plots are ok - but 'ggplot' is a very powerful (and widespread)
# package that produces better looking plots

install.packages("ggplot2")
library(ggplot2)

ggplot(elbe_98, aes(x= popdensity, y=spd_z_vs)) +
  geom_point() +
  geom_smooth(method=lm, se=TRUE, col='red') + 
  theme_bw() + 
  ylab("SPD Vote Share") + 
  xlab("Population Density") + 
  ggtitle("Correlation")


## Let's install a few packages we'll need for Markdown


install.packages('rmarkdown')
install.packages("tinytex")

install.packages("stargazer")

install.packages("Rtools")
tinytex::install_tinytex()


#### EXERCISES #####

# - Which one of the three parties show the strongest correlation
#   between first and second votes?

# - Plot the correlation between CDU and SPD vote share

# - Run a multivariate regression with either CDU/SPD/PDS vote share as DV.
#   Justify your choice of variables

# - Which district saw the largest absolute drop in SPD vote share
#   between 98 and 02?

# => Produce a single PDF file that contains all of your code, output
#    and brief answers to the questions above.

