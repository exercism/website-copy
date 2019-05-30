### Possible solution

This solution is very intuitive and follows step-by-step the instructions in the exercise

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

The learning goal here is (I guess) to avoid unnecessary conversion of inputs as strings and to account for inputs that are factors of more than one if-statement (e.g. 15).

### Common suggestions

- avoid a string transformation of the input at the beginning
- go through the task iteratively to account for all possible factors
- for-loops impact the readability here a bit, I think, so one could point learners to alternatives 

### Talking points

- more advanced learners might prefer to avoid several if conditions could be pointed to an alternative with an if-else statement:

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
- or an elegant solution that directly compares the input with its divisors in the paste0() command:

```r
raindrops <- function(number) {
  sounds<-c('Pling', 'Plang', 'Plong')
  divisors<-c(3,5,7)
  
  rain <- paste0(sounds[(number %% divisors) == 0], collapse='')
  
  if(nchar(rain) > 0) rain else as.character(number)
}
```

