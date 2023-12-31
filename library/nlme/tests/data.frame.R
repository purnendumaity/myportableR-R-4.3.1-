stopifnot(!any("package:nlme" == search())) # nlme *not* attached

ll <- LETTERS[1:10]
subs <- rep(ll, rep(3,10))
set.seed(101)# make reproducible
resp <- rnorm(30)

## 'nlme' not in search() :
op <- options(warn = 2)  # there should be no (deprecation) warning
(gd <- nlme::groupedData(resp ~ 1|subs))
options(op)
## failed in nlme < 3.1-129 (or previous to 2017-01-17)
stopifnot(inherits(gd, "groupedData"),
	  identical(dim(gd), c(30L, 2L)),
	  inherits(gs <- gd[,"subs"], "ordered"),
	  identical(sort(levels(gs)), ll),
	  identical(sort.list(levels(gs)),
		    c(5L, 9L, 8L, 4L, 10L, 2L, 1L, 6L, 7L, 3L)))

## PR#18177 -- <groupedData>[j] should give a data frame
require(nlme)
stopifnot(is.data.frame(Meat[2]) # had 'drop=TRUE'
	  , identical(Meat[,1, drop=FALSE], Meat[1])
	  ) # gave vector in nlme < 3.1-153
