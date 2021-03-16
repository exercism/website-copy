# Mentoring

## Mentor guidance

We don't need to bikeshed on this too long. Just prompt them to improve their code if they do something needlessly convoluted. `if` statements are okay, but consider prompting them with the first or third suggestions.


## Common suggestions

(Formatted so you can copy and paste easily)

- Whenever you have an expression like \`if condition; return true; else; return false\`, you can rewrite it as \`return condition\`.
- Obviously you can do as you please, but it is conventional to have one space either side of each operator: \`year % 400 == 0\`.
- Consider writing a truth table for this exercise and see if you can work out what the simplest predicates are and how they could be combined with \`&&\` and \`||\`
- Prefer \`&&\` and \`||\` over \`&\` and \`|\` to benefit from \[short-circuiting\](https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation). Julia will not evaluate the whole expression but only the expressions that are necessary to determine the result of the entire chain.

Example truth table:

```
Let:

p = year % 4 == 0
q = year % 100 == 0
r = year % 400 == 0

o = is the desired output

p q r | o
0 0 0 | 0
1 0 0 | 1
...
1 1 1 | 1

```

The idea is that you 1) work out what predicates you need and 2) notice that you can construct the output with p && !q || r.

## Talking points

- You might be interested to see the Julia standard library's solution: \`using Dates; @edit isleapyear(4)\`

## Analyser

If you want to, you can use the following function in the REPL to run a semi-automatic analyser:

```julia
function analyse_leap(s)
	comment = ""
	if any(occursin.(["true", "false"], s))
		comment *= "Whenever you have an expression like `if condition; return true; else; return false`, you can rewrite it as `return condition`.\n\n"
	end
	if occursin("r%4", s)
		comment *= "Obviously you can do as you please, but it is conventional to have one space either side of each operator: `year % 400 == 0`.\n\n"
	end
	if any(occursin.(["if", "elseif"], s))
		comment *= "Consider writing a truth table for this exercise and see if you can work out what the simplest predicates are and how they could be combined with `&&` and `||`.\n\n"
	end
	if isempty(comment)
		# all good
		return "Hi 👋 Welcome to the Julia Track!\n\nWell done!\n\nYou might be interested to see the Julia standard library's solution: `using Dates; @edit isleapyear(4)`"
	else
		return "Hi 👋 Welcome to the Julia Track!\n\nGood job on solving the problem! Some tips to improve your solution:\n\n" * comment
	end
end
```

It can then be called by copying the solution, and running `clipboard() |> analyse_leap |> clipboard`.

**Make sure to adjust the comment as necessary. This is meant as a starting point, not a fully automatic pastable comment!**.
