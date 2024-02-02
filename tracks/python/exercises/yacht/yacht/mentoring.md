# Mentoring
## score categories
They should be stored in variables at the start of a file and used in if statement like below.
```python
ONES = 1
TWOS = 2
...
def score(dice, category):
  if category == ONES:
    ...
```
## categories ONES to SIXES
Good solution is 
```python
return sum(value for value in dive if value == X)
```
where X is number corresponding to category.
But better solution with less code repetition is
```python
if category in (ONES, ..., SIXES):
    return dice.count(category) * category
```
but you must make proper score categories
## FULL_HOUSE
Ideal solution is with using collections and Counter
```python
dice_values = collections.Counter(dice).values()
# 'dict' with items quantity
if set(dice_values) == {2, 3}: 
    # set is sorted, unique elements
    # three of one number and two of another 
    return sum(dice)
```
## LITTLE_STRAIGHT and BIG_STRAIGHT
```python
set(dice) == {1, 2, 3, 4, 5} # little
set(dice) == {2, 3, 4, 5, 6} # big
# set will return sorted, unique values
```
## CHOICE
```python
sum(dice) # it's sum of the dice
```
## YACHT
```python
len(set(dice)) == 1
"""
if every item in dice is the same set will be
one element
"""
```
## FOUR_OF_A_KIND
```python
value, count = collections.Counter(dice)\
.most_common(1)[0]
"""
most_common(limit) return array with given limit
length with tuples of item and quantity
...[0] give us first (and only) tuple from list
value, count unpack tuple to variables
"""
if count >= 4:
    return 4 * value
```

## End case
Only as a last return student should write
```python
return 0
```
