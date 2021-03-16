# Mentoring

## Intro
This is one of the first larger scale exercises.

## Reasonable solutions

```clojure
(ns bob)

(defn question? [s] (clojure.string/ends-with? s "?"))

(defn yelling? [s]
  (let [letters (filter #(Character/isLetter %) s)]
    (and (every? #(Character/isUpperCase %) letters) (seq letters))))

(defn get-response [s]
  (cond
    (empty? s) "Fine. Be that way!"
    (and (question? s) (yelling? s)) "Calm down, I know what I'm doing!"
    (question? s) "Sure."
    (yelling? s) "Whoa, chill out!"
    :else "Whatever."))

(defn response-for [s]
  (get-response (clojure.string/trim s)))
```

## Common suggestions
- Ensure that solutions do not use a large amount of nested ifs. Instead, suggest looking into the `cond` macro to help simplify their code.
- Splitting the checking of `yelling?` and `question?` is usually a good place to introduce auxilliary functions.
- The function that checks for yelling should ensure that every letter is capitalized. Yet, when there are no letters in the list, this should not be counted as capitlized. To do this, suggest the use of `filter`, checking that this list is not empty, and then checking that every letter in it is capitalized.

## Talking points
- The use of auxilliary functions in Clojure.

## Mentoring notes
