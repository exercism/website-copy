Make sure the constructor throws if the inputs have different lengths.
The tests indicate that the constructor ought to be throwing `IllegalArgumentExceptions` with specific error messages.

NOTE: An `IllegalArgumentException` is not a checked exception.
It does not need a `throws` statement on the constructor (or any other methods).