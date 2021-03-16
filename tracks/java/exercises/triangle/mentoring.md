# Mentoring

## Reasonable solutions

__Simple solution:__

```java
class Triangle {
    private final double sideA;
    private final double sideB;
    private final double sideC;

    Triangle(double side1, double side2, double side3) throws TriangleException {
        if (side1 <= 0 || side2 <= 0 || side3 <= 0)
            throw new TriangleException();

        if (side1 + side2 <= side3 ||
            side2 + side3 <= side1 ||
            side3 + side1 <= side2) {
            throw new TriangleException();
        }

        sideA = side1;
        sideB = side2;
        sideC = side3;
    }

    boolean isEquilateral() {
        return (sideA == sideB && sideA == sideC);
    }

    boolean isIsosceles() {
        return (sideA == sideB ||
                sideB == sideC ||
                sideC == sideA );
    }

    boolean isScalene() {
        return (sideA != sideB &&
                sideB != sideC &&
                sideC != sideA);
    }

}
```

__More advanced solution:__

```java
import static java.lang.Math.max;

import java.util.stream.Stream;

class Triangle {

   private final long distinctSides;

   Triangle(double side1, double side2, double side3) throws TriangleException {
      final double max = max(side1, max(side2, side3));
      if (max * 2 >= side1 + side2 + side3) {
         throw new TriangleException();
      }

      distinctSides = Stream.of(side1, side2, side3).distinct().count();
   }

   boolean isEquilateral() {
      return distinctSides == 1;
   }

   boolean isIsosceles() {
      return distinctSides <= 2;
   }

   boolean isScalene() {
      return distinctSides == 3;
   }
}
```



## Common suggestions

- Count the number of unique sides and save it in a field, then use it in the `is` methods. 
That will make them shorter and easier to understand.
- A simple way to check if the triangle is sane is to see if the longest side times two is 
less than the sum of all sides. If it is not, throw an exception. 
