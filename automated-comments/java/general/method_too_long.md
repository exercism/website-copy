At least one method in this solution is getting long.
This might be acceptable, but it could be an indication that the method is doing too much work directly and should be delegating some of that work to other methods.
A general rule is to try to keep everything inside a constructor or method at one level of abstraction.
For example, iterating through the elements of a loop could be in one method while manipulating each individual element could be in another.

Consider breaking down the methods into calls to other semantically meaningful methods.