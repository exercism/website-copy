You could make the function more readable by inverting the condition of the `if` statement handling the error case. 
The rest of the function can then be outdented because an `else` branch is not needed. A Go proverb 
says "The happy path is left-aligned", meaning the normal flow of control follows the left-hand margin, and only 
exceptional or error cases are indented.
