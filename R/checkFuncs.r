## -------- THIRD COMPONENT -----------------------------
## A set of functions to be used inside the test cases to test something

checkEquals <- function(a, b, msg, tolerance = .Machine$double.eps^0.5)
{
  ##@bdescr
  ## checks if two objects are equal, thin wrapper around 'all.equal'
  ## with tolerance one can adjust to and allow for numerical imprecission

  ##@edescr
  ##@in a         : [ANY] one thing to be compared
  ##@in b         : [ANY] the second object to be compared
  ##@in tolerance : [numeric] directly passed to 'all.equal', see there for further documentation
  ##@in msg : [character|TRUE] an optional message to further identify and document the call



  if(!is.numeric(tolerance)) {
    stop("tolerance has to be a numeric value")
  }
  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$checkNo <<- 1 + .testLogger$checkNo
  }
  res <- all.equal(a,b, tolerance=tolerance)
  if (!identical(res, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$isFailure <<- TRUE
    }
    stop(paste(res, collapse="\n"))
  }
  else {
    return(TRUE)
  }
}

checkEqualsNumeric <- function(a, b, msg, tolerance = .Machine$double.eps^0.5)
{
  ##@bdescr
  ## checks if two objects are equal, thin wrapper around 'all.equal.numeric'
  ## with tolerance one can adjust to and allow for numerical imprecission

  ##@edescr
  ##@in a         : [ANY] one thing to be compared
  ##@in b         : [ANY] the second object to be compared
  ##@in tolerance : [numeric] directly passed to 'all.equal', see there for further documentation
  ##@in msg : [character|TRUE] an optional message to further identify and document the call

  if(!is.numeric(tolerance)) {
    stop("tolerance has to be a numeric value")
  }

  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$checkNo <<- 1 + .testLogger$checkNo
  }
  res <- all.equal.numeric(a,b, tolerance=tolerance)
  if (!identical(res, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$isFailure <<- TRUE
    }
    stop(paste(res, collapse="\n"))
  }
  else {
    return(TRUE)
  }
}



checkTrue <- function(a, msg)
{
  ##@bdescr
  ## checks whether or not something is true
  ##@edescr
  ##@in a   : [expression] the logical expression to be checked to be TRUE
  ##@in msg : [character|TRUE] optional message to further identify and document the call


  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$checkNo <<- 1 + .testLogger$checkNo
  }

  if (!identical(a, TRUE)) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$isFailure <<- TRUE
    }
    stop("Test not TRUE.")
  }
  else {
    return(TRUE)
  }
}

checkException <- function(expr, msg)
{
  ##@bdescr
  ## checks if a function call creates an error. The passed function must be parameterless.
  ## If you want to check a function with arguments, call it like this:
  ## 'checkException(function() func(args...))'
  ##@edescr
  ##@in func : [parameterless function] the function to be checked
  ##@in msg  : [character|TRUE] an optional message to further identify and document the call

  if(exists(".testLogger", envir=.GlobalEnv)) {
    .testLogger$checkNo <<- 1 + .testLogger$checkNo
  }

  if (!inherits(try(eval(expr, envir = parent.frame())), "try-error")) {
    if(exists(".testLogger", envir=.GlobalEnv)) {
      .testLogger$isFailure <<- TRUE
    }
    stop("Error not generated as expected.")
  }
  else {
    return(TRUE)
  }
}



