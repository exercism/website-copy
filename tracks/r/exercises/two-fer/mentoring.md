# Mentoring

## Reasonable solution

This is a nice, concise, efficient solution:

```r
two_fer <- function(input = 'you') {
  paste0('One for ', input, ', one for me.')
}
```

Using a default value for the variable (rather than an `if` & `<- "you"` in the function body) is one of the learning goals.

## Common suggestions

- "Puzzling" together the string like this is fine here, but [`sprintf`](https://trinkerrstuff.wordpress.com/2013/09/15/paste-paste0-and-sprintf-2/), [`glue`](https://glue.tidyverse.org/) or other placeholder-based variants will format longer strings more elegantly, because literals and variables don't need to be intermingled: `sprintf("One for %s, one for me.", input)`.

## Talking points

Point learners whose code shows inconsistent formatting to resources about automatic code styling in R(Studio); e.g., to [this StackOverflow thread](https://stackoverflow.com/a/46012908/4341322). This should prevent issues in more complex exercises for both them and us in future.
