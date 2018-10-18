




function(x){
  return(length(x) <= 50)
}


fruits <- c("apple", "orange", "banana")
gsub("a", c("A", "aa", "o"), fruits)
#will only apply the first one


#apply accross a vector with a custom function  
sapply(c("A", "aa", "o"),
       function(x) gsub("a", x, fruits))

#will create a 2d array


#using mapply
mypattern <- c("an", "or", "pp")
myreplacement <- c("AN", "OR", "PP")

#aply accross multiple vectors
mapply(function(x, y) gsub(x, y, fruits),
       mypattern, myreplacement)

#first part of gsub is parttern, second part is replacement


#tapply
msiyield <- read.csv("Miscanthus_sinensis_yield.csv")
myindex <- msiyield$Genetic.group

tapply(msiyield$Plant.height, myindex, mean, na.rm = TRUE)


# by
# get snp_mat form last week
myfile <- "GG_SNPs.csv"
snp_mat <- as.matrix(read.csv(myfile, header = TRUE, row.names = 1))
#msi groups from week 3
mygrps <- read.csv("Msi_groups_and_phenotypes.csv")
dim(snp_mat)

#the files do not match so we have to do extra
# get matching names between snp matrix and table
mygrps_samples <- as.character(mygrps$Sample_name)
mymatch <- mygrps_samples[mygrps_samples %in% rownames(snp_mat)]
snp_mat2 <- snp_mat[mymatch,]
dim(snp_mat2)

match_groups <- mygrps$DAPC_group[match(mymatch, mygrps_samples)]
length(match_groups)
match_groups[1:20]


#mini exercise 1
mycolMeans <- by(snp_mat2, match_groups, colMeans, na.rm = TRUE)
str(mycolMeans)
mycolMeans$`N Japan`

myfreqs <- by(snp_mat2, match_groups, 
              function(x) colMeans(x, na.rm = TRUE)/2)
myfreqs[[1]]

### environments and namespaces
a <- 1:5
tracemem(a)
b <- a
tracemem(b)

b[2] <- 6
tracemem(b)

#called copy-on-modify
#when you change b, a does not change

myfun <- function(x){
  x <- x-1
  cat(tracemem(x))
  return(x+1)
} 

myfun(a)

search() #where does R look for variable names

#overlaps between namespaces

round <- function(x){
  return(x %/% 1)
}

round(6,7)
round(6,7, digits = 3)
base::round(6,7,digits = 3)

#mini exercise 2
#function within a function
fun1 <- function(x){
  fun2 <- function(y){
    return(y^2)
  }
  return(fun2(x) +1)
}

fun1(3)


##  classes

class(fun1)
typeof(fun1)

#error
fun1[2]

class(a)
typeof(a)

class(b)
typeof(b)

class(snp_mat)
typeof(snp_mat)

#data frame
class(mygrps)
typeof(mygrps)

#class is more of how you can maninipulate the data
#typeof is more of how r sees it


is.integer(a)
is.integer(b)
is.numeric(b)
is.numeric(a)
is.double(a)
is.double(b)

class(a) == "numeric"
class(b) == "numeric"

is.integer(snp_mat)
#our matrix stores integers

#setting up empty vectors
integer(5)
numeric(5)
character(5)
logical(5)

#different classes of NAs
test <- rep(NA, 5)
class(test)test
test <- rep(NA_integer_, 5)
class(test)
test
?NA

##   methods
summary(snp_mat)
summary(a)
summary(mymatch)
?summary.Date
#function.class

?mean
?mean.Date
?mean.default

#mini exercise
methods(as.Date)
?as.Date


#using dots in function definitions
minusTenLog <- function(x, ...){
  return(-10 * log(x, ...))
}

minusTenLog(0.05)
minusTenLog(0.05, base = 10)  
# the base command passes to the second set of dots

## integer vs numeric
some_numbers <- 1:100
class(some_numbers)
object.size(some_numbers)  # 4 bytes per value

some_numeric <- as.numeric(some_numbers)
some_numeric
class(some_sumeric)
object.size(some_numeric) # 8 bytes per value

is.integer(10L)
is.integer(10)

0.3 - 0.2 - 0.1
print(0.3, digits = 18)

#mini exercise
#anything ending in .0 or .5 are exact
#.11 .22 .99 are exact


#mini exercise
print(0.11, digits = 18)
print(.2, digits = 18)
print(.3, digits = 18)
print(.4, digits = 18)


## integer vs floating point math
389 + 57

3.5 * 10^8 + 2.2 * 10^6

x <- 1L + 1
class(x)
# integer + floating point = floating point
#integer + integer = integer











