At least one constructor in this solution is getting long.
This might be acceptable, but it could be an indication that the constructor is doing too much work directly and should be delegating some of that work to other methods.
A general rule is to try to keep everything inside a constructor or method at one level of abstraction.
For example, input validation can be delegated to another method so that the constructor can focus on storing variables.

Consider breaking down the constructor into calls to other semantically meaningful methods.