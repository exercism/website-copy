Consider breaking down the following constructor(s) into calls to other semantically meaningful methods: `%<constructorNames>s`

The constructor has more lines of code than this exercise generally requires.
This might be acceptable, but it could be an indication that the constructor is doing too much work directly and should be delegating some of that work to other methods.
Try to keep everything inside a constructor or method at one level of abstraction.
For example, input validation can be delegated to another method so that the constructor can focus on storing variables.