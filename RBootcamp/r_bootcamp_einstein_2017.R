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


# Installing and Loading packages

# SECTION 2 - <- 