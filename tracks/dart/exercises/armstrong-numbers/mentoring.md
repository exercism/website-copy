# Mentoring

## Reasonable solutions

Let them know that the most important thing to do here is not to try to code first, but to know how the maths behind this exercise is and how to solve it on paper.
You can use this [website][reference-math-website] to explain it.
Next they can go ahead and take what they wrote down and try to put it in a coding logic.
Lastly, they can go and put their written solution to a code now. 

They should always use this approach before start to code, so coding become only a tool for the solution.

```dart
import 'dart:math';
class ArmstrongNumbers{
    bool isArmstrongNumber(int number)  => number == number.toString()
                                                           .split("")
                                                           .fold(0,(prev,curr)=> prev + pow(int.parse(curr),number.toString().length));
    }
```

[reference-math-website]: https://mathworld.wolfram.com/NarcissisticNumber.html

## Common suggestions

- they already know about [fold-method][reference-fold-method] and how to use it
- math library should be imported here so they can use the [pow-method][reference-pow-method]
- they need to convert String to Integer using the [parse-method][reference-parse-method]

[reference-fold-method]: https://api.dart.dev/stable/1.10.1/dart-core/List/fold.html
[reference-pow-method]: https://api.dart.dev/stable/2.10.5/dart-math/pow.html
[reference-parse-method]: https://api.flutter.dev/flutter/dart-core/int/parse.html

## Solution Video

Step by step [video][youtube-video] guide solution for this exercise

[youtube-video]: https://www.youtube.com/watch?v=0DfS3jM4pLA&t=757s
