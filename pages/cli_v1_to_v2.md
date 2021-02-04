# CLI v1 to v2

If you haven't installed the new version of the command-line client (v3.x), please download the [latest release](https://github.com/exercism/cli/releases/latest). We recommend using our [interactive walkthrough](https://exercism.io/cli-walkthrough) to guide you through the installation and configuration process.

The CLI for Windows is broken for versions prior to 3.0.5.

----

The new website relies on a metadata file that the old website did not provide.
If you don't have this file, you will not be able to submit the exercise.

The easiest way to ensure that you have the file is to copy your old solution somewhere, call `exercism download` for the exercise again, and then copy your solution back in.

    exercism download --exercise=THE_EXERCISE --track=THE_TRACK

Example:

    exercism download --exercise=hello-world --track=java

Or:

    exercism d -e hello-world -t java

Then you will be able call `exercism submit` with the solution file(s).

    exercism submit path/to/file1 [path/to/file2 ...]
