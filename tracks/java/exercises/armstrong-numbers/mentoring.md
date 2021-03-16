# Mentoring

## Reasonable solutions

Loop-based solution (using `%10`):
```java
class ArmstrongNumbers {

    boolean isArmstrongNumber(int numberToCheck) {
        int number = numberToCheck;
        int calculation = 0;
        int length = String.valueOf(number).length();

        while (number > 0) {
            calculation += Math.pow((number % 10), length);
            number = number / 10;
        }
        return numberToCheck == calculation;
    }
}
```

Loop-based solution (using `charAt`):
```java
class ArmstrongNumbers {

    boolean isArmstrongNumber(int numberToCheck) {
        String numbers = Integer.toString(numberToCheck);
        int powerOf = numbers.length();
        int total = 0;
        for (int i = 0; i < powerOf; i++) {
            int val = Character.getNumericValue(numbers.charAt(i));
            total += Math.pow(val, powerOf);
        }
        return total == numberToCheck;

    }
}
```

Java8 `IntStream`-based solution:
```java
class ArmstrongNumbers {

    boolean isArmstrongNumber(int numberToCheck) {
        String digits = Integer.toString(numberToCheck);
        return numberToCheck == digits.chars()
                .parallel()
                .map(d -> (int) Math.pow(Character.getNumericValue(d), digits.length()))
                .sum();
    }
}
```
