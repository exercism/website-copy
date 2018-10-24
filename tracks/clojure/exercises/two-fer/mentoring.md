### Intro
This exercise is about multi-arity functions.

### Reasonable solutions

```clojure
(ns two-fer)

(defn two-fer
  ([] (two-fer "you"))
  ([name] (str "One for " name ", one for me.")))
```

```clojure
(defn two-fer [& [name]]
  (-> (partial format "One for %s, one for me.")
      (fnil "you")
      (as-> f (f name))))
```

### Common suggestions

### Talking points
- Calling `(two-fer "you")` vs. returning the string directly.

### Mentoring notes
- Most users seem to submit exactly the same solution.
