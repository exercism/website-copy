# Mentoring

## Problem and challenges
	
The Luhn problem asks the student to filter a string 
of digits, and then perform a checksum. 
Challenges include turning characters into ints, 
and then transforming every other digit.
	
## Reasonable solutions
	
The tests require the solution to filter the string.
	
The algorithm requires that the sting be turned into
digits, and every other digit be transformed. 
The length of the string is not fixed, and we must 
count positions from the right, rather than the left.
It is simplest to reverse the string before traversing.
	
```python
class Luhn(object):
  
    def __init__(self, card_num):
        self.card_num = card_num
	
    def is_valid(self):
        card_num = self.card_num.replace(' ', '')
        card_num = card_num[::-1]
	
        if not card_num.isdigit() or len(card_num) < 2:
            return False
        else:
            num_sum = 0
            for i in range(len(card_num)):
                num = int(card_num[i])
                if i % 2:
                    num = num * 2
                    if num > 9:
                        num = num - 9
                num_sum += num
	
            return (num_sum % 10) == 0
```
	
## Common Suggestions
	
The loop above would be clearer rewritten with enumerate().
	
	
```python
for counter, ch in enumerate(card_num):
    num = int(ch)
    if counter % 2:
        num = num * 2
        if (num  > 9):
            num = num - 9
    num_sum = num_sum + num
```
	
Essentially, we are looking for something like the unzip function to pull the string into two subsequences. 
The solution above is typical, but you can construct
subarrays of the odd and even digits, as below
	
```python
nums = list(map(int, self.card_num))
doubled_sum = sum(map(self.double, nums[-2::-2]))
normal_nums_sum = sum(nums[-1::-2])
return (doubled_sum + normal_nums_sum) % 10 == 0
```
	
## Talking points
	
### The doubling transformation
	
The transformation is almost (num  * 2) % 9, except that
9 maps to 9 rather than 0. The transformation is
one-to-one, and could be implemented with a dictionary or a maketrans() table,
though it might take more effort to assemble it than it would save.
	
Here is a version seen in the wild: this singles out 9 as a special case, and handles everthing else with the formula above. It does call int() twice on many characters, but that could be fixed. 
	
While this may be a bit faster, it seems further from the problem description, and may just be too clever by half.
	
```python
for n in self.card_num[-2::-2]:
    if int(n) == 9:
        every_other_num.append(9)
    else:
        every_other_num.append((int(n)*2) % 9)
```

Here is an example that uses a tuple of values to hold the mapping. 
While the table was passed in as a default parameter, 
it would probably be clearer to include it as a local variable.

```python
def luhn_lookup(index, digit, luhn_table=(0, 2, 4, 6, 8, 1, 3, 5, 7, 9)):
    if index % 2 != 1:
        return digit
    else:
        return luhn_table[digit]
```
	
### Summing via reduce()
	
You will see solutions that use reduce() rather than sum(). While this works, it is more complex than needed.
	
```python
from functools import reduce
	
class Luhn(object):
    def __init__(self, card_num):
        self.cc = card_num
	
    def is_valid(self):
        try:
            digits = [int(d) for d in self.cc.replace(" ","")[::-1]]
        except:
            return False
        return len(digits) > 1 and (reduce(lambda x, y: x+y, digits[0::2], 0) + \
            reduce(lambda x, y: x + (2*y if 2*y < 10 else 2*y -9), digits[1::2], 0)) % 10 == 0
```
