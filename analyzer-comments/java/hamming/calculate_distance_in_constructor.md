# calculate distance in constructor

Consider calculating the Hamming distance inside the constructor and storing the result in a member variable which can be returned inside `getHammingDistance()`.
This solution seems to be calculating the Hamming distance inside the `getHammingDistance()` method.
This means that the calculation might be done again, unless the result is stored and retrieved (in which case you can ignore this recommendation).
