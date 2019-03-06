### Reasonable solutions

This is a nice, concise, efficient solution:

```{r}
… (input = "you")  
  paste0("One for ", input, ", one for me.")
```

Using a default value for the variable (rather than an `if` & `<- 'you'` in the function body) is one of the learning goals.


### Common suggestions

- "puzzling" together the string like this is fine here, but [`sprintf`](https://trinkerrstuff.wordpress.com/2013/09/15/paste-paste0-and-sprintf-2/), [`glue`](https://glue.tidyverse.org/) or other placeholder-based variants will format longer strings more elegantly, because literals & variables don't need to be intermingled: `sprintf("One for %s, one for me.", input)`.


### Talking points

- Point learners whose code shows inconstistent formatting to [this StackOverflow thread about automatic code styling in R(Studio)](https://stackoverflow.com/a/46012908/4341322). This should prevent issues for both them and us in future, more complex exercises.
