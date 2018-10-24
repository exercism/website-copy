### Intro

This exercise is about re-implementing a common library function.

### Reasonable solutions

```clojure
(ns reverse-string)

(defn reverse-string [s]
  (apply str (reduce conj '() s)))
```

### Common suggestions

### Talking points
- How lists naturally expand on the left side -> `conj`
- `(reduce conj '() s)` vs. `(reduce #(str %2 %1) "" s))`

### Mentoring notes
- Redirecting to `clojure.string/reverse` probably shouldn't be accepted as a
  valid solution.
