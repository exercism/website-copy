# prefer strict equality

In _TypeScript_, always prefer [strict (identity and non-identity) equality](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Identity)
such as `===` and `!==` over the forms that use implicit type coercion,
such as [`==`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Equality)
and [`!=`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Inequality),
unless coercion of the type of one of the two operands is expected.

There are definitely cases where non-strict equality is a _feature_, but that's
not the case in this exercise.
