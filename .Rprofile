source("renv/activate.R")

setHook('rstudio.sessionInit', function(newSession) {
 if (newSession)
  {
    renv::restore(prompt = FALSE)
  }
}, action = 'append')



setHook('rstudio.sessionInit', function(newSession) {
 if (newSession)
  {
    rstudioapi::navigateToFile('/home/onyxia/work/WP9_S1_PL_TOURISM/index.qmd')
  }
}, action = 'append')


