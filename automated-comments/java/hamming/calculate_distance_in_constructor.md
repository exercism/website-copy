This solution seems to be calculating the Hamming distance inside the `getHammingDistance()` method.
While this is acceptable, it means that the calculation might be done again if you did not use lazy initialization.
Consider calculating the Hamming distance inside the constructor and storing the result in a member variable which can be returned inside `getHammingDistance()`.