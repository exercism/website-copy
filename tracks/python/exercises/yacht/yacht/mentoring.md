# Mentoring
## Resonable solutions
### Using if structure
```python
import collections

YACHT = 0
ONES = 1
TWOS = 2
THREES = 3
FOURS = 4
FIVES = 5
SIXES = 6
FULL_HOUSE = 7
FOUR_OF_A_KIND = 8
LITTLE_STRAIGHT = 9
BIG_STRAIGHT = 10
CHOICE = 11

def score(dice, category):
    if category == YACHT and len(set(dice)) == 1:
            return 50
            
    elif category in (ONES, TWOS, THREES, FOURS, FIVES, SIXES):
        return dice.count(category) * category
    
    elif category == FULL_HOUSE:
        dice_values = collections.Counter(dice).values()
        if set(dice_values) == {2, 3}:
            return sum(dice)
        
    elif category == FOUR_OF_A_KIND:
        common_value, common_count = collections.Counter(dice).most_common(1)[0]
        if common_count >= 4:
            return 4 * common_value
    
    elif category == LITTLE_STRAIGHT and set(dice) == {1, 2, 3, 4, 5}:
            return 30
            
    elif category == BIG_STRAIGHT and set(dice) == {2, 3, 4, 5, 6}:
            return 30
            
    elif category == CHOICE:
        return sum(dice)

    return 0
```
### Using functions
Thanks to [safwansamsudeen](https://exercism.org/profiles/safwansamsudeen), author of code
```python
def digits(num):
    return lambda dice: dice.count(num) * num
YACHT = lambda dice: 50 if dice.count(dice[0]) == len(dice) else 0
ONES = digits(1)
TWOS = digits(2)
THREES = digits(3)
FOURS = digits(4)
FIVES = digits(5)
SIXES = digits(6)
FULL_HOUSE = lambda dice: sum(dice) if len(set(dice)) == 2 and dice.count(dice[0]) in [2, 3] else 0
FOUR_OF_A_KIND = lambda dice: 4 * dice[1] if dice[0] == dice[3] or dice[1] == dice[4] else 0
LITTLE_STRAIGHT = lambda dice: 30 if sorted(dice) == [1, 2, 3, 4, 5] else 0
BIG_STRAIGHT = lambda dice: 30 if sorted(dice) == [2, 3, 4, 5, 6] else 0
CHOICE = sum
def score(dice, category):
    return category(dice)
```
## Common suggestions
* Suggest using numbers as categories if student used strings
* Suggest using category like ```if category == ONES``` instead of ```if category == 1```
* Sugges using buit-in functions for example ```set()``` in ```STRAIGHTS```
* Suggest writing from ```ONES``` to ```SIXES``` as one function
## Talking points
* Why it's better to use ```int``` istead of ```str``` as a category?
* Sets are faster than list but you need to convert list to set few times. Which one type is better?
* Why [magic strings](https://en.wikipedia.org/wiki/Magic_string) are bad as a category name?
## Changelog
* 2024 Feb - Created file following CoC and isogram
