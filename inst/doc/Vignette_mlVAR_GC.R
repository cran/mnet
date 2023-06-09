## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = ">"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
# library(devtools)
# install_github("jmbh/mnet")
library(mnet)

## -----------------------------------------------------------------------------
data("ExampleData")

dim(ExampleData)
head(ExampleData)


## -----------------------------------------------------------------------------
set.seed(1) # reproducibility

timer <- proc.time()[3]

output <- mlVAR_GC(data = ExampleData, 
                   vars = c("V1", "V2", "V3"), 
                   idvar = "id",
                   groups = "group",
                   nCores = 1, # choose cores available on your machine
                   nP = 5, # Should be much more in practice, see preprint!
                   pbar = FALSE)

proc.time()[3] - timer

## -----------------------------------------------------------------------------
output$EmpDiffs

## -----------------------------------------------------------------------------
output$Pval

## ---- fig.align="center", fig.width=7, fig.height=5---------------------------
hist(output$SampDist$Lagged_fixed[1,2,], 
     xlim=c(-.5, .5), main="", xlab="Parameter Value")
abline(v=output$EmpDiffs$Lagged_fixed[1,2,], col="orange")
legend("topright", legend="Test-statistic", text.col="orange", bty="n")

