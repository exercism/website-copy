# Mentoring

## Reasonable solutions

This exercise can be solved in different ways. We will use two of them. 
Show both of them to get them, to get them to know more dart concepts.
Map class will be used for both solutions.

### Solution 1: using fold method ***_recommended_***
```dart
int score([String word]) {
  var values = {
    'A': 1, 'B': 3, 'C': 3, 'D': 2,
    'E': 1, 'F': 4, 'G': 2, 'H': 4,
    'I': 1, 'J': 8, 'K': 5, 'L': 1,
    'M': 3, 'N': 1, 'O': 1, 'P': 3,
    'Q': 10, 'R': 1, 'S': 1, 'T': 1,
    'U': 1, 'V': 4, 'W': 4, 'X': 8,
    'Y': 4, 'Z': 10,
  };

  return word.toUpperCase().split("").fold(0, (prev, curr) => prev + values[curr]);
}
```

### Solution 2: using map and reduce methods
```dart
int score([String word]) {
  var values = {
    'A': 1, 'B': 3, 'C': 3, 'D': 2,
    'E': 1, 'F': 4, 'G': 2, 'H': 4,
    'I': 1, 'J': 8, 'K': 5, 'L': 1,
    'M': 3, 'N': 1, 'O': 1, 'P': 3,
    'Q': 10, 'R': 1, 'S': 1, 'T': 1,
    'U': 1, 'V': 4, 'W': 4, 'X': 8,
    'Y': 4, 'Z': 10,
  };

  return word.toUpperCase().split("").map((e) => values[e.toString()]).reduce((prev,curr) => prev + curr);
}
```

## Common suggestions
- Students need to know how [Map][reference-map-class] works, because they need it for both of the solutions
- Solution 1 is more important than Solution 2. They need the [fold-method][reference-fold-method] for future exercises

[reference-map-class]: https://api.dart.dev/stable/2.10.4/dart-core/Map-class.html
[reference-fold-method]: https://api.dart.dev/stable/1.10.1/dart-core/List/fold.html
[reference-map-method]: https://api.dart.dev/stable/2.9.1/dart-core/Iterable/map.html
[reference-reduce-method]: https://api.dart.dev/stable/2.14.4/dart-core/Iterable/reduce.html

## Solution Video

Step by step [video][youtube-video] guide solution for this exercise

[youtube-video]: https://www.youtube.com/watch?v=myMQCtk7U30
