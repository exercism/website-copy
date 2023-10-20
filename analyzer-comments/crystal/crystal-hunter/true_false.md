# do not compare boolean values to true or false

Comparing boolean values to true or false is redundant.
Using `==` will generate a boolean value, so it is unnecessary to compare it to another hardcoded boolean value.
If wanting to flip the boolean value, use the `!` operator.

```crystal
# Rather than:
some_bool == true
some_bool == false

# Consider:
some_bool
!some_bool
```
