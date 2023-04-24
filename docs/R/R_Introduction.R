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
install.packages('tinytex')

install.packages("stargazer")


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






