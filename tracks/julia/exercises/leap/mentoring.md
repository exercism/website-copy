### Mentor guidance

We don't need to bikeshed on this too long. Just prompt them to improve their code if they do something needlessly convoluted. `if` statements are okay, but consider prompting them with the first or third suggestions.


### Common suggestions

(Formatted so you can copy and paste easily)

- Whenever you have an expression like ``if condition; return true; else; return false``, you can rewrite it as ``return condition``.
- Obviously you can do as you please, but it is conventional to have one space either side of each operator: ``year % 400 == 0``.
- Consider writing a truth table for this exercise and see if you can work out what the simplest predicates are and how they could be combined with ``&&`` and ``||``


### Talking points

- You might be interested to see the Julia standard library's solution: ``using Dates; @edit isleapyear(4)``
