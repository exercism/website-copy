# avoid printing and logging

Avoid printing and logging via `stdout` and `stderr`.

Usually it is not a good idea to output something to `stdout` or `stderr` in lower level packages.
That is done in higher level or the `main` package, that have the necessary context to know what to do with an error.
Using `log.Println` or `fmt.Println` in a lower level package can not be overwritten from the outside.
Printing and logging are useful for debugging, but should be removed before submitting an exercise, or releasing a package.

Sometimes it looks like the function signature should be changed to return an error.
In contrast to the real world, the function signature is pre-determined in these exercises.
There's room for discussion: to return an error might not be necessary after all or the exercise might need to be adjusted.
