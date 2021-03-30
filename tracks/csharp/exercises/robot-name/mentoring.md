# Mentoring

The exercise aims to teach three concepts: randomness, classes and strings. 

### Common suggestions

- When creating a robot there is no need to name it until necessary.  Some solutions will generate the name within a constructor.  This should be avoided as randomly generating name could take a while if there are a lot of collisions in the name generation process.  Instead generate the name the first time a name is requested.

### Talking points

- When resetting a robot, the generation of a new name can be delayed until the name is requested again.

### Advanced Talking Points

If the mentee is comfortable exploring some concepts beyond the basics of the lesson you can make some of the following suggestions.

- While using Random works when generating a name it can quickly become ineffective.  Generating the first 400,000 names using `Random` and checking for a collision is pretty quick.  Getting to 500,000 names using this method is very expensive in time as it generates a lot of collisions. Getting to the maximum number of names of 676,000 is effectively impossible.
- An alternative to avoid the `Random` collision issue above 400,000 is to generate all possible combinations of names and then randomly select one from the list of available names.  Removing the name from the list when used and adding it back when reset.

