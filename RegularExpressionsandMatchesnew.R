

# Matching Patterns with Regular Expressions

library(tidyverse)
library(stringr)
library(dplyr)

# More Strings !!

# Another String function  str_detect
# To determine if a s character vector matches a pattern, use
# str_detect().  It returns a logical vector the same length as the 
# input:

c("apple", "banana", "pear") -> x
x

str_detect(x, "e")

words

# Find all words that start with t from the words data source.
(str_detect(words, "^t"))

# If you want to actually see the words, use str_subset

str_subset(words, "^t")


# How many common words start with t ?

sum(str_detect(words, "^t"))

# What proportion of the words data source start with t ?
mean(str_detect(words,  "^t"))  # about 7%

# What proportion of the words data source end with a vowel ?
mean(str_detect(words,  "[aeiou]$"))   # about 28%

# code for the logical indicators for words that end with a vowel.
(str_detect(words,  "[aeiou]$"))

# What percentage of words do not end with a vowel ?  Be careful !!
mean(str_detect(words,  "[^aeiou]$"))  # note the placement of the carat.


# Using str_detect()  

words[str_detect(words,  "x$")]

# Let's locate these words !!

df <- tibble(word = words,
             i = seq_along(word)
)
df
df %>%
  filter(str_detect(words, "x$"))


# We will use str_view() and str_view_all() in order to match string 
# patterns with regular expressions.

# Example 1  
# Let us determine where the matches occur for a regular expression 
# and the following collection of strings;  "apple" , "banana" , and  
# "pear"

str_view(c("apple" , "banana" , "pear")  ,  "an")
str_view_all(c("apple" , "banana" , "pear")  ,  "an")

# Note that the pattern  an  is highlighted

# Example 2
# Here is a special case;  The ordinary  period  (.)  will match any
# character

# Lets use the same vector in Example 1 and find a match for b and the
# next character to the right of b , hence we are matching  b.

str_view(c("apple" , "banana" , "pear")  ,  "b.")


# Again, use the same vector in Example 1 and find a match for a and 
# any immediate character to the right of a and any immediate
# character to the left of  a , hence we are matching  .a.

str_view(c("apple" , "banana" , "pear")  ,  ".a.")


# If the period will match any character, How do we match a period?
# We do this by using the backslash symbol  \   The \ will escape a
# period and another backslash.

# In the next example, lets match the pattern a.b  In order for the
# period to be escaped, we need a \ , hence we need the expression \.
# to escape the period.  We use strings however to represent regular
# expressions so we will need to first escape the \ that is inside
# of the string.

# We are trying to match the pattern a.b, note that we get an error for
# the following

str_view(c( "a.b",  "ab" , "abc") ,  "a\.b") 


# We need to escape the \ also, so we will need another backslash. 
# Now consider and run the following code

str_view(c( "a.b",  "ab" , "abc") ,  "a\\.b") 

# of course the following matching construction works also


str_view(c( "a.b",  "ab" , "abc") ,  "a.b") 


# Note:  Strings are enclosed by double quotes.  Regular Expressions
# are not enclosed by double quotes.

#  Sting ->  "\\'"
#  Regular Expression ->  \\"

# create a string that will force a match for 
# the regular expression one backslash   \  
#  "\\"
# confirm your answer by using writeLines
writeLines("\\")

# create a string that will force a match for the 
# regular expression  two backslashes   \\
# "\\\\"

# confirm your answer using writeLines
writeLines("\\\\")

# create a string that will release a period   .
#  "."

# confirm by using writeLines
writeLines(".")


# create a string that will force a match for the regular 
# expression of a backslash and then a period   \.

# "\\."

# confirm by using writeLines
writeLines("\\.")



# Example: Produce a string that will force a match for the
# regular expression \""

# Solution:  We need to escape three symbols with backslashes.
# So between the double quotes we have:
# "\\\"\""


# We now use the function writeLines to confirm that our code is
# correct
writeLines("\\\"\"")

# Note that the output is indeed  \""



# Anchors Away  (The symbols ^ an $ are called anchors)
 
# We will use the carrot ^ to match a regular expression to the start
# of a string.
# Example: for the vector of strings, c("apple", "banana", "pear"),
# use a regular expression that will match a string that starts with 
# an a.

x<-c("apple", "banana", "pear")
x
str_view(x,  "^a")


# We will use the dollar sign $ to match a regular expression to the end
# of a string.

# Example: for the vector of strings, c("apple", "banana", "pear"),
# use a regular expression that will match a string that ends with 
# an r.

x<-c("apple", "banana", "pear")
x
str_view(x,  "r$")

 
# To force a regular expression to only match a complete string,
# anchor it with both ^ and $. Consider the following example for
# which we want to match the pattern Boston only.

str_view(c("Boston Celtics", "Boston Bruins", "Boston"), "^Boston$")

# Without the anchors all patterns of Boston in every string will be
# highlighted

str_view(c("Boston Celtics", "Boston Bruins", "Boston"), "Boston")


#Repetition

#You can control how many times a pattern matches with the 
# repetition operators:

# ?: 0 or 1.
# +: 1 or more.
# *: 0 or more.

# We will use the stringr function str_extract for these procedures


x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
x
# Extract the pattern CC from MDCCCLXXXVIII
str_extract(x, "CC?")
# Extract the pattern XVII from MDCCCLXXXVIII
str_extract(x, 'XVII')
# Extract the maximum number of X's from MDCCCLXXXVIII
str_extract(x, "X+")
# Extract a C and the maximum number of L's and X's from 
# MDCCCLXXXVIII
str_extract(x, 'C[LX]+')

# You can also specify the number of matches precisely:
  
# {n}: exactly n
# {n,}: n or more
# {n,m}: between n and m

str_extract(x, "C{2}") # Extract 2 C's

str_extract(x, "C{2,}") # Extract 2 or more C's

# note that the same result can be obtained using previous coding
str_extract(x, "CC+")

str_extract(x, "I{1,4}") # Extract between 1 and 4 I's

# Grouping and Backreferences

# Parentheses define groups, and coupled with backreferences (\1, \2
# etc allow for interesting matches)

# Example
# Let's find a regular expression that will match words with a
# repeated pair of letters.

# We want a pair of letters,   (..)  examples:  abab, xyxy
# We want to repeat the pair once,   \1
# We need to escape the backslash so the sting will have \\1
# Now our string we will use to match is;   "(..)\\1"

# We will confirm our solution by considering the following 
# vector; y = c("papa", "chocolate", "cucumber", 'cabbage").

str_view(c("papa", "chocolate", "cucumber", "cabbage"),
         "(..)\\1" , match = TRUE)
# Note that only the words that have a repeated pair of 
# letters are displayed

# Another example;
# Let's create a regular expression that matches patterns whereby 
# the order of the first letter and the second letter are switched 
# in the pattern.  For example;  abba
# Solution
# Two individual letters   (.)(.)
# There is an order switch,  so instead of  \1\2 we have  \2\1,
# Now remember we have to escape the backslashes, so the string will
# have \\2\\1
# Our string that we will use to force a match is "(.)(.)\\2\\1"

# We now test and confirm our solution by forcing a match for the 
# following vector;  c("maple", "boob", "cece")

str_view(c("maple", "boob", "cece") , "(.)(.)\\2\\1")

# Note that the only pattern with the stated characteristic , boob,
# is highlighted.


# Produce a pattern that will match the word church for the 
# following vector of strings

# Solution 1 (specific solution)
str_view(c("church", "calling", "crab", "cookie") , "church")

# What is special about the word church ?

# Solution 2  (general solution)
str_view(c("church", "calling", "crab", "cookie") , "(..)..\\1")  
# think about this solution !!



# Another example: Use a general solution regular expression to 
# match the string that starts and ends with the same letter


str_view(c("lion","anaconda", "zebra", "eagle", "bear"),
         "(.).*\\1") 
str_view(c("lion","anaconda", "zebra", "eagle", "bear"),
         "(.).*\\1.") 


# Last example: Use a general solution regular expression to 
# match the string that has four consecutive identical letters

str_view(c("aaaa","aaba", "abba", "bbba"),  "(.)\\1\\1\\1") 

stringr :: sentences

length(sentences)

head(sentences)

colors <- c("red", "orange", "yellow", "green", "blue", "puple")
colors

stringr : words

words[str_detect(words,  "x$")]

df <- tibble(word = words,
             i = seq_along(word)
             )
df %>%
  filter(str_detect(words, "x$"))




q()
y







