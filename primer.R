#### R Workshop, Uppsala University - May 10, 2017
##################################################

### Using R as a Calculator
###########################

## Try inputting the following commands. 
## After typing each line of code, hit the return key to display the results.
2 * 2
(5-7) / 96
sqrt(2014)
2014^2

## Let's take the natural log of 100. 
## Like most things, R gives users at least a couple means to accomplish a task.
log(100, base=10)
log(100, 10)

### Using R to Generate Data
############################

## Let's generate a numeric vector.
c(1, 2, 3, 4)
1:4
seq(1, 4)

## Let's create some more vectors.
-1:2
seq(2, 8, by = 2)
seq(0, 1, length = 5)
seq(0, 42, length = 6)
rep(42, 3)
rep(c(1, 2, 3), 10)

## R allows us to easily manipulate vectors.
c(1, 2, 3, 4)/2
seq(0, 1000, by = 10)/3.14

## Now let's generate some character vectors.
c("Germany", "France", "Spain", "Italy")
rep(rep(c('fish', 'bird'), c(2, 1)), 100)

## Finally, let's create some logical vectors.
c(TRUE, FALSE, TRUE, FALSE)
rep(c(F, T))
as.numeric(c(TRUE, FALSE, TRUE, FALSE))

## By now, you have probably noticed that R commands often take the form 'x()'. 
## These commands are called functions. We will use them a lot. 
## R has built-in help for functions. You can call this help in two ways.
help(rep)
?rep

## Honestly, the built-in help is not that great. 
## When in trouble with R, use google, or post the problem to StackExchange (http://stackoverflow.com/questions/tagged/r)

## Now we know how to create data. We often want to reuse it. 
## So, we need to assign the data to variables. We use '<-' to do that. 
## Some people use '=', but this practice is discouraged.
variable.name <- c(1, 2, 3)
another.variable.name <- rep(c(1, 2), 100)
twos <- rep(2, 100)

## We can call variables by typing their name.
variable.name
twos

## We can also perform operations on variables.
another.variable.name*5
another.variable.name/twos

## We often need to create vectors of random numbers. Let's create some random data.
random.numbers <- rnorm(mean = 0, sd = 1, n = 1000) # what does rnorm do?
random.numbers
summary(random.numbers)
random.numbers.2 <- rbinom(n = 500, trials = 10, prob = 0.3) # what does rbinom do?
table(random.numbers.2)
random.numbers.3 <- runif(min = 0, max = 1, n = 500) # what does runif do?
summary(random.numbers.3)

## You often want to visually inspect variables.
random.numbers
View(random.numbers)

## Sometimes you want to view specific observations.
random.numbers[500]
random.numbers[900:920]

## Sometimes you want to view the beginning of the vector . . .
head(random.numbers)

## . . . or the end of the vector.
tail(random.numbers)

### Using R for Data Management
###############################

## Most often we do not create data in R, but use existing data sources. 
## There are many ways to do this. 
## We first need to begin with some basics regarding directory structure.

## Determine your current working directory (i.e. where you are working in the file system).
getwd()

## List files in that directory.
list.files()

## Change your working directory to your data directory.
setwd("")

## Let's import and view some data - first a .csv file.
data.csv <- read.csv("coxappend.csv", header = TRUE, sep = ",",)
View() 

## How do we view just the beginning of the data?

## Before importing other types of data (i.e. Excel and STATA files). 
## We need to install additional packages for R. Think of packages like add-ons. 
## R comes with many built-in functions, but the packages extend these functions. 

## For importing Excel files, we need the 'gdata' package.
install.packages("gdata")

## For importing STATA files, we need the 'foreign' package.
install.packages("foreign")

## Or we can use 'rio' to import EVERYTHING.
install.packages("rio") # Leeper (http://thomasleeper.com/) does awesome work.

## Now we enable the packages. 
## They are not enabled by default, so we need to enable them for each session we use them.
library(gdata)
library(foreign)
library(rio)

## We are now ready to go back to importing data.
## For instance, we can import an Excel file ...
data.xsl <- read.xls(("coxappend.xls"), sheet = 1, header = FALSE)
View(data.xsl) 

## and a STATA file.
data <- rio("coxappend.dta")
View(data)

## We can even import data directly from the internet.
police <- read.csv("https://raw.githubusercontent.com/BuzzFeedNews/2015-12-fatal-police-shootings/master/guardian.csv")
View(police)

## Or import data from a package. 
library(devtools)
install_github('jalapic/engsoccerdata', username = "jalapic")
library(engsoccerdata)
data(package="engsoccerdata")
data("france")
head(france)

### Managing R's Workspace
##########################

## We have created a lot of variables and data frames. Let's talk about managing them.

## First, let's list all objects in the working environment
ls() 

## That is a lot. Let's remove an object from the working environment.
rm("data.csv")
ls() 

## Say we want to start our session with a clean slate, but we want to save data.dta first.
save(police, file="police.rda")

## Or maybe we want to save everything in the current environment.
save.image(file="everything.rda")

## Then we remove all the objects.
rm(list = ls())
ls() 

## This leaves libraries attached, however. Sometimes you might want to detach libraries.
## One reason for this is because libraries can occassionally conflict.
unloadNamespace("rio")

### Exploring Data in R
#######################

## Let's import some data again.
police <- read.csv("https://raw.githubusercontent.com/BuzzFeedNews/2015-12-fatal-police-shootings/master/guardian.csv")
View(police)

## Or we can import our saved file.
load("police.rda")

## Now let's explore the dataset.
names(police)
dim(police)
nrow(police)
ncol(police)
dim(police)[1]
dim(police)[2]
summary(police)

## We can look at one variable.
police$disposition
table(police$disposition)
summary(police$disposition)

## We can also look at specific rows and columns of data.
police[, 1]
police[1, ]

## Or at individual datum.
police[1,1]

## Or at specific columns and rows of data.
police[5:15,1:10]

## We can also use 'which' to look at specific observations.
police[which(police$uid > 1000), ]
police[which(police$year == 2015), ]
police[which(police$age < 18), ]
nrow(police[which(police$age < 18), ])

## It is sometimes useful to determine how long vectors are.
length(police$disposition)

## Or to figure out the unique number of observations in a vector.
length(unique(police$city))

## Or to order the observations in ascending or descending order.
police[order(police$uid), ]
police[order(police$uid, decreasing=T),]

## Now we will use a new package to retrieve a different set of summary statistics. 
## We want to use the package 'Hmisc' - how do we install and load it?
describe(police)

## Let's get some info about the variables in the dataset.
str(police)

## We can more directly view a variable's class.
class(police$disposition)

## Or levels.
levels(police$disposition)

### Data Manipulation in R
##########################

## Let's create a new variable. 
police$new.age <- police$age * 5

## Of course, this variable does not make any sense. So let's remove it.
names(police)
police <- police[, -34]
## Another way to drop it would be to type 'police$new.age <- NULL'
names(police)

## Let's create a new dummy variable for all cases where police killed victims with a taser.
table(police$classification)
police$taser.dummy <- 0
police$taser.dummy[police$classification == "Taser"] <- 1
sum(police$taser.dummy)

## We can use the subset command to trim the data set as we like.
police.new <- subset(police, select=c(year, age, classification))
dim(police.new)
summary(police.new)

## Maybe we only want data for victims older than 18 . . .
police.new <- subset(police, age > 18, select=c(year, age, classification))
dim(police.new)
summary(police.new)

## We can also exclude columns like this.
police.new <- police[, 2:4]
dim(police.new)
summary(police.new)

### Basic Statistics in R
#########################

## Let's take the mean of a variable.
mean(police$age)
## What's up there?

## We can also calculate other statistics ...
## such as different measures of central tendency ...
median(police$age, na.rm = TRUE)
quantile(police$age, prob = 0.5, na.rm = TRUE)

## or spread.
sd(police$age, na.rm = TRUE)
IQR(police$age, na.rm = TRUE)
min(police$age, na.rm = TRUE)
max(police$age, na.rm = TRUE)
range(police$age, na.rm = TRUE)

## What can we do with qualitative data?
## We can create one-dimensional contigency tables.
table(police$classification)

## Or two-dimensional contigency tables.
table(police$classification, police$disposition)
table(police$armed, police$classification)

## We are often interested in calculating measures of association.
## We can do this by examine the correlation between 2 variables.
data <- rio::import("coxappend.dta")
View(data)
label(data) # Figure out what the variables are.
cor(data$enpv, data$enps, method = c("spearman"))

## Now let's make a correlation matrix of all the variables in the data set.
cor(data)

## Ah - but that doesn't work. Why? Well, the dataset includes a character vector. So let's exclude the first column.
data <- data[, 2:23]

## and try again.
cor(data)

## We can even plot correlations.
install.packages("corrplot")
library(corrplot)
corrplot(cor(data[, 10:15]), method="circle")

### Basic Graphics in R
#######################

## Now let's create some basic graphics by examining data.dta$enps in greater detail
hist(data$enps, col='slategray2', xlab="Effective Legislative Parties", ylab="Frequency", main="Histogram of Effective Legislative Parties", font.main = 1, border = "white")
plot(density(data$enps), col='red', lwd=3, xlab="Effective Legislative Parties", ylab="Density", main="Kernel Density Plot of Effective Legislative Parties", font.main = 1, bty='n')

## What do col, lwd, xlab, ylab, main, font.main, and bty do?

## Let's make a boxplot . . .
boxplot(data$enps)

## and then modify it based on what we just learned . . .
boxplot(data$enps)

## We can also make a boxplot of two variables 
boxplot(data$enps ~ data$year)

## or a scatterplot of two variables.
plot(data$enps, data$enpv)

## This is not that pretty though, so let's improve it a bit . . .
plot(data$enps, data$enpv, pch=21, main="Title", sub="Subtitle")

## This isn't very pretty. Let's use what we learned above and the information here - http://www.endmemo.com/program/R/pchsymbols.php - to improve this plot.

## Sometimes we need to plot categorical data.
mosaicplot(table(police$disposition))

## Or visualize tables of categorical data.
library(datasets)
mosaicplot(Titanic, main = "Survival on the Titanic")

### Basic Estimation in R
#########################

## We have some data, we've examined it, and we've plotted it.
## We might now want to test some hypotheses.
## Let's say that we think that the effective number of legislative parties is a function of whether countries have an SMDP system.
## Given the nature of the dependent variable, we might test this with OLS.
lm(data$enps ~ data$smdp)

## We get some estimates this way, but we are really probably interested in inference here.
## For that, we need SEs.
mod <- lm(enps ~ smdp, data = data)
summary(mod)

## There are several ways to extract information about the model. 
coef(summary(mod))
coef(mod)
sqrt(diag(vcov(mod)))

## Now that we have a model, we might want to put its results in a table.
## If we use LaTeX, we can use the 'stargazer' package to help with this.
## http://jakeruss.com/cheatsheets/stargazer.html contains some great info on the library.
install.packages("stargazer")
library(stargazer)
stargazer(mod)

## But tables are kind of lame. So, let's present the results visually.
install.packages("dotwhisker")
library(dotwhisker)
dwplot(mod)

## We can save the plot as a 'ggplot' object and then make some additional changes.
## For more information about ggplot commands, see https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
## and http://ggplot2.org/book/.
cool.plot <- dwplot(mod)
cool.plot <- cool.plot + theme_bw() + xlab("Coefficient Estimate") + ylab("") +
  geom_vline(xintercept = 0, colour = "grey60", linetype = 2) + 
  ggtitle("Results from Model") + theme(plot.title = element_text(face="bold")) + 
  theme(legend.position="none")
print(cool.plot)

## Let's take a few minutes to estimate a new regression using the Cox data and plot that.

### Errata
##########

## We often want to make sure that our code replicates. One way that we can do this is with the source() command.
source("file_name.r")

## We also can try to format our code well. This can help readability and thereby replication.
install.packages("formatR")
library(formatR)
code <- "fn <- function(x, y) { paste(x, '+', y, '-', x+y) }"
tidy_source(text = code)