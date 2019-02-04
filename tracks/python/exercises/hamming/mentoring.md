### Problem and challenges

The solution needs to raise an exception if the lengths are different

Otherwise, the task is to find the number of differences between two strings of the same size.

### Reasonable solutions
	
	We check the lengths, and then look for differences
	
	```python
    def distance(strand_a, strand_b):
        if (len(strand_a) != len(strand_b)):
            raise ValueError('Strands must have the same length')

        strand_a = strand_a.lower()
        strand_b = strand_b.lower()
        count = 0
        for i in range(len(strand_a)):
            if strand_a[i] != strand_b[i]:
                count = count + 1

        return count
	```

    This works, but needs to use an index variable to walk the two strings.

### Introducing zip()

    We can use the zip function to pair up the two strands

	```python
    def distance(strand_a, strand_b):
        if (len(strand_a) != len(strand_b)):
            raise ValueError('Strands must have the same length')

        count = 0
        for ch1, ch2 in zip(strand_a.lower(), strand_b.lower())
            if ch1 != ch2:
                count = count + 1

        return count
	```
### List Comprehensions
	
	The solution below uses a List Comprehension to provide a more terse approach:
	
	```python
    def distance(strand_a, strand_b):
        if len(strand_a) != len(strand_b):
            raise ValueError("strands length are not the same")
        return len([(a, b) for (a, b) in zip(strand_a, strand_b) if a != b])
	```
	
### Common Suggestions

    A List Comprehension can be suggested, but isn't an obvious win.
	 
### Talking points

    Running time is not a concern here.  It is hard to make this worse than O(N).
