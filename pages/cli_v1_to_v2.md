The new website relies on a metadata file that the old website did not provide.
If you don't have this file, you will not be able to submit the exercise.

The easiest way to ensure that you have the file is to copy your old solution somewhere, call `exercism download` for the exercise again, and then copy your solution back in.

    exercism download --exercise=THE_EXERCISE --track=THE_TRACK

Then you will be able call `exercism submit` with the solution file(s).

    exercism submit path/to/file1 [path/to/file2 ...]
