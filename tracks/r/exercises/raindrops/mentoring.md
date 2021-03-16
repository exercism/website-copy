# Mentoring

### Reasonable solution

This solution is very intuitive and follows step-by-step the instructions in the exercise:

```r
raindrops <- function(number) {
  rain <- ""

  if (number %% 3 == 0)
    rain <- append(rain, "Pling")
  
  if (number %% 5 == 0)
    rain <- append(rain, "Plang")
  
  if (number %% 7 == 0)
    rain <- append(rain, "Plong")
  
  if (rain == "") # alternatively: !(number %% 3 == 0 | number %% 5 == 0 | number %% 7 == 0)
    return(as.character(number))
  
  paste(rain, collapse = "")
}
```

The learning goal here is to avoid unnecessary conversion of inputs as strings and to account for inputs that are factors of more than one if-statement (e.g. 15).

### Common suggestions

- Avoid a string transformation of the input at the beginning.
- For-loops impact the readability here a bit, I think, so one could point learners to alternatives. 

### Talking points

More advanced learners might prefer to avoid several if conditions could be pointed to an alternative with an if-else statement:

```r
raindrops <- function(number) {
  rain <- c("Pling", "Plang", "Plong")
  if (0 %in% (number %% c(3, 5, 7))) {
    paste(rain[which(number %% c(3, 5, 7) == 0)], collapse = "")
  } else {
    paste(number)
  }
}
```

Or an elegant solution that directly compares the input with its divisors in the `paste()` command:

```r
raindrops <- function(number) {
  sounds <- c("Pling", "Plang", "Plong")
  divisors <- c(3, 5, 7)
  
  rain <- paste(sounds[(number %% divisors) == 0], collapse = "")
  
  ifelse(nchar(rain) > 0, yes = rain, no = as.character(number)
}
```

Finally, `n` can be added to the `sounds` vector and it's value is only pasted if all other conditions are `FALSE`.

```r
raindrops <- function(n) {
  boo <- !(n %% c(3, 5, 7))
  boo <- c(boo, all(!boo))
  paste(c("Pling", "Plang", "Plong", n)[boo], collapse = "")
}
```
