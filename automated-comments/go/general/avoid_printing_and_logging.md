Usually it is not a good idea to output something to `stdout` or `stderr` in lower level packages.
That is done in higher level or the `main` package, that have the necessary context to for example know what to do with an error.
Using `log.Println` or `fmt.Println` in a lower level package can not be overwritten from the outside.
Best avoid them in the exercises here. They are useful for debugging but should be removed before submitting.

It might be that you feel like an error should be returned by a function but there is no error return value in the function signature.
In the real world you could change this, but in these exercises the function signature is pre-determined.
Best discuss this with your mentor. An exception might not be necessary after all or the exercise might need to be adjusted.
