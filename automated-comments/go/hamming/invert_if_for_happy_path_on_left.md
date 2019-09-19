To simplify, invert the `if` condition handling the error case, 
then get rid of the `else` branch by returning within the `if`.
A Go proverb says "[The happy path is left-aligned](https://medium.com/@matryer/line-of-sight-in-code-186dd7cdea88)",
meaning the normal flow of control follows the left-hand margin, 
and only exceptional or error cases are indented.
