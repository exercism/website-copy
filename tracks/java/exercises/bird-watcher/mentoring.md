# Mentoring

## Common suggestions

- Since the exercise is about using arrays, for loops and for-each loops, nudge them towards solutions that match the exemplar.
- In particular, although this exercise *could* be solved using Streams, the purpose here is to use for loops.

## Talking points

### IndexOutOfBoundsException

At least one of the methods checks for edge cases or they will get this exception.
This is a good chance to talk about what happens if you try to select data from outside of the array's bounds.
In fact, there is a second method that also has this problem, but does not require them to handle it to pass tests: `incrementTodaysCount`.

### Helpful Java libraries

This can be a good time to bring up the fact that there are many helpful Java libraries, for example: `Math.min`.
Obviously this is only for their benefit to learn more about the types of libraries that Java has to offer.
Linking them to the Javadoc can also be useful: [`Math.min`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Math.html#min(int,int))

### Defensive copying

In general, we want to use defensive copies to protect the encapsulation of our mutable state.
Currently, the exercise does not follow this practice, but it is something we can discuss with students.
