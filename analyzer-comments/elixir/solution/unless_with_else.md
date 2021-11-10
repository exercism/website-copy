# unless having else block

Avoid using `unless` expressions with an `else` block. Use an `if` expression instead.

The reason for this is not technical but human. The `else` in this
case will be executed when the condition is met, which is the opposite of
what the wording suggests.
