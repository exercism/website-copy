This is the one of the four side exercises unlocked after finishing Resistor Color. The level of understanding is vary from students. Some work on this exercise right after Resistor Color is done, others submit this exercise after solving multiple core exercise.

so you need to teach at least:

- [Logical Operators][ref-logical]

but you might also want to teach according to students' understanding but they'll be taught in future core exercise so you don't need to stick to them.

- [Rest parameters][ref-rest-parameters]
- [Destructuring assignment][refs-destructuring-assignment]
- [Array#every][ref-array-every]
- [Array#some][ref-array-some]


Also, this exercise might be the first time for some students to use class, so you gently teach them about JavaScript class if needed.

### Reasonable Solutions

```javascript
export class Triangle {
  constructor(...sides) {
    this.sides = sides;
  }

  isEquilateral() {
    const [a, b, c] = this.sides;
    return this.isValid() && a == b && b == c && c == a;
  }

  isIsosceles() {
    const [a, b, c] = this.sides;
    return this.isValid() && (a == b || b == c || c == a);
  }

  isScalene() {
    const [a, b, c] = this.sides;
    return this.isValid() && a != b && b != c && c != a;
  }

  isValid(){
    const [a, b, c] = this.sides;
    const sidesArePositive = a > 0 && b > 0 && c > 0;
    const validatesTriangleInequality =
      a + b >=c && b + c >= a && c + a >= b;
    return sidesArePositive && validatesTriangleInequality;
  }
}
```

A wise student might use `.sort` to simplify the Triangle Inequality rule logic.

Also, some students add test cases for degenerate triangles and implement a method to check that.

#### Approvability

Some students would use `Set` to solve Triangle exercise and they're also okay if using properly.

### Common suggestions

- If students nest if statements, introduce them to [Logical Operators][ref-logical] and suggest them to combine expressions using `&&` or `||`.
- If students use ternaries or if statements to return boolean value, then suggest them to return expressions directly instead.
- If students check triangle inequality at multiple places, introduce them to [DRY principle][ref-dry] and suggest to move them into helper methods.
- If students get parameters by a basic way, you may want to introduce [Rest parameters][ref-rest-parameters].
- If students check triangle inequality in a classic way, you may want to introduce [Array#every][ref-array-every] and [Array#some][ref-array-some].
- If students don't submit test cases though they implement for degenerate triangle, teach them how to submit multiple files. You can submit multiple files by `exercism submit file1 file2`.

[ref-rest-parameters]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters
[refs-destructuring-assignment]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment
[ref-logical]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators
[ref-array-every]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every
[ref-array-some]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/some
[ref-dry]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
