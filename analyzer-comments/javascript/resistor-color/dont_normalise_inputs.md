# dont normalise inputs

Remove the call to `.toLowerCase`. The tests only provide the inputs in
lowercase, and the colors should be defined in lower case. There is no need to
manually normalize the inputs.