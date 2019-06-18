This solution is comparing `bytes`. While is perfectly fine for this exercise (we only have to deal with ascii characters)
this would fail if we were to calculate the `hamming distance` of any two strings including `utf-8` characters.

Try it! You can easily add more tests with special characters and see what happens.
