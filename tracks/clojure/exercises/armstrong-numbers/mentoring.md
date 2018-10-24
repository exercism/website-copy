### Intro
This is the first core exercise.

### Reasonable solutions

```clojure
(ns armstrong-numbers)

(defn expt [num pow]
  (reduce * (repeat pow num)))

(defn digits [n]
  (->> n
       (iterate #(quot % 10))
       (take-while pos?)
       (map #(rem % 10))))

(defn armstrong? [num]
  (let [d (digits num)
        dcnt (count d)]
    (->> d
         (map #(expt % dcnt))
         (reduce +)
         (= num))))
```

### Common suggestions
- Most users seem to split the number into digits by iterating a string and
  parsing characters. Suggest that this can be done arithmetically as well.
- Often people use `Math/pow` which uses floating point arithmetics. Suggest
  using integer arithmetics and discuss the probems of comparing floating
  point values for equality.

### Talking points

### Mentoring notes
- If the user comes to Clojure without experience in functional programming,
  this is the first exercise, that requires him to think non-imperative, and
  probably his first contact with sequences.
