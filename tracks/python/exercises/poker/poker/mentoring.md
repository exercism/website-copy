# Mentoring  

## Problem Summary and Challenges  
This problem asks students to Pick the best hand(s) from a list of poker hands. This problem requires that students be familiar with strings, lists, tuples, dictionaries, and sorting techniques in Python. In particular:

- String manipulation
- List and tuple operations
- Dictionaries and frequency counting
- Sorting and filtering strategies
- Edge case handling
    
## Reasonable Solutions
### Tuple based scoring 
```python
import collections

# Mapping for card ranks.
RANKS = {
    "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
    "T": 10, "J": 11, "Q": 12, "K": 13, "A": 14
}

def parse_hand(hand_string):
    """Parses a poker hand into numeric rank and suit pairs."""
    list_of_cards = hand_string.split(" ")
    parsed_cards = []
    for card in list_of_cards:
        if card.startswith("10"):
            rank_part = "10"
            suit = card[2]
        else:
            rank_part = card[0]
            suit = card[1]
        numeric_rank = RANKS[rank_part]
        parsed_cards.append((numeric_rank, suit))
    return parsed_cards

def evaluate_hand(parsed_cards):
    """Evaluates a parsed hand and returns a tuple representing the rank."""
    values = sorted([card[0] for card in parsed_cards])
    suits = [card[1] for card in parsed_cards]
    frequency = collections.Counter(values)
    freq_sorted = sorted(frequency.items(), key=lambda x: (x[1], x[0]), reverse=True)
    flush = len(set(suits)) == 1
    straight = values == list(range(values[0], values[0] + 5)) or values == [2, 3, 4, 5, 14]
    
    if straight and flush:
        return (8, values[-1])
    if freq_sorted[0][1] == 4:
        quad = freq_sorted[0][0]
        kicker = [v for v in values if v != quad][0]
        return (7, quad, kicker)
    if freq_sorted[0][1] == 3 and freq_sorted[1][1] == 2:
        return (6, freq_sorted[0][0], freq_sorted[1][0])
    if flush:
        return (5, sorted(values, reverse=True))
    if straight:
        return (4, values[-1])
    if freq_sorted[0][1] == 3:
        kickers = sorted([v for v in values if v != freq_sorted[0][0]], reverse=True)
        return (3, freq_sorted[0][0], kickers)
    if freq_sorted[0][1] == 2 and freq_sorted[1][1] == 2:
        return (2, sorted([freq_sorted[0][0], freq_sorted[1][0]], reverse=True), [v for v in values if v not in [freq_sorted[0][0], freq_sorted[1][0]]][0])
    if freq_sorted[0][1] == 2:
        kickers = sorted([v for v in values if v != freq_sorted[0][0]], reverse=True)
        return (1, freq_sorted[0][0], kickers)
    return (0, sorted(values, reverse=True))

def best_hands(hands):
    """Determines the best hand(s) from a list of poker hands."""
    best = []
    best_rank = None
    for hand in hands:
        parsed_cards = parse_hand(hand)
        current_rank = evaluate_hand(parsed_cards)
        if best_rank is None or current_rank > best_rank:
            best_rank = current_rank
            best = [hand]
        elif current_rank == best_rank:
            best.append(hand)
    return best
```
 ### An object-oriented approach 
---
``` python
import collections

class Card:
    RANKS = {
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "10": 10,
        "T": 10,
        "J": 11,
        "Q": 12,
        "K": 13,
        "A": 14,
    }

    def __init__(self, card_str):
        self.rank = card_str[:-1] if card_str.startswith("10") else card_str[0]
        self.suit = card_str[-1]
        self.value = self.RANKS[self.rank]

    def __lt__(self, other):
        return self.value < other.value

    def __repr__(self):
        return f"{self.rank}{self.suit}"


class Hand:
    def __init__(self, hand_str):
        self.cards = sorted([Card(card) for card in hand_str.split()], reverse=True)

    def hand_rank(self):
        values = [card.value for card in self.cards]
        suits = [card.suit for card in self.cards]
        freq = collections.Counter(values)
        freq_sorted = sorted(freq.items(), key=lambda x: (x[1], x[0]), reverse=True)

        flush = len(set(suits)) == 1
        straight = self.is_straight(values)

        if straight and flush:
            top_value = 5 if values == [14, 5, 4, 3, 2] else max(values)
            return (8, top_value)
        elif freq_sorted[0][1] == 4:
            quad = freq_sorted[0][0]
            kicker = [v for v in values if v != quad][0]
            return (7, quad, kicker)
        elif freq_sorted[0][1] == 3 and len(freq_sorted) > 1 and freq_sorted[1][1] == 2:
            triple = freq_sorted[0][0]
            pair = freq_sorted[1][0]
            return (6, triple, pair)
        elif flush:
            return (5, sorted(values, reverse=True))
        elif straight:
            top_value = 5 if values == [14, 5, 4, 3, 2] else max(values)
            return (4, top_value)
        elif freq_sorted[0][1] == 3:
            triple = freq_sorted[0][0]
            kickers = sorted([v for v in values if v != triple], reverse=True)
            return (3, triple, kickers)
        elif freq_sorted[0][1] == 2 and len(freq_sorted) >= 2 and freq_sorted[1][1] == 2:
            pair1 = freq_sorted[0][0]
            pair2 = freq_sorted[1][0]
            kicker = [v for v in values if v != pair1 and v != pair2][0]
            return (2, sorted([pair1, pair2], reverse=True), kicker)
        elif freq_sorted[0][1] == 2:
            pair = freq_sorted[0][0]
            kickers = sorted([v for v in values if v != pair], reverse=True)
            return (1, pair, kickers)
        else:
            return (0, sorted(values, reverse=True))

    def is_straight(self, values):
        if values == [14, 5, 4, 3, 2]:
            return True
        for i in range(4):
            if values[i] - values[i+1] != 1:
                return False
        return True



def best_hands(hands):
    best = []
    best_rank = None
    for hand in hands:
        current_rank = Hand(hand).hand_rank()
        if best_rank is None or current_rank > best_rank:
            best_rank = current_rank
            best = [hand]
        elif current_rank == best_rank:
            best.append(hand)
    return best
```


## Common Suggestions  

- Using frequency counts to simplify evaluation rather than iterating multiple times.
- **Sorting** values upfront to make straight detection simpler.
- **Using tuples for ranking** to take advantage of built-in tuple comparison.
- Using a **dictionary** to store card frequencies instead of repeatedly counting occurrences.
- Consider including **14** in a low straight scenario to account for **Aces**



## Talking Points

- Why is **frequency counting** effective?
- How does **tuple comparison** simplify ranking comparisons?
- What are the best ways to handle edge cases like ********************************`"10"`******************************** vs ********************************`"T"`********************************?**
- How should students approach **debugging** when rankings appear incorrect?
- What are the trade-offs between different **data structures** for storing hands?**
- Does an **object oriented** approach for cards or hands make sense here? Why or why not?  



### Resources

#### Links to Python 3 Documentation
- [Data Structures in Python](https://docs.python.org/3/tutorial/datastructures.html). Describes list object methods, uses for lists, and comprehensions.
(including [Dictionaries in Python](https://docs.python.org/3/tutorial/datastructures.html#dictionaries))
- [Modules in Python](https://docs.python.org/3/tutorial/modules.html)  - Definitions and statements

#### Blogs and Tutorials
- [**Lists and Tuples in Python**](https://realpython.com/python-lists-tuples/#python-lists) from John Sturtz at Real Python. Indexing, slicing and all things list and tuple.
- [**Python's Built in Data Types**](https://realpython.com/ref/builtin-types/)  an overview of the key built-in data types in Python
- [**Tuple Comparison in Python**](https://www.geeksforgeeks.org/python-compare-tuples/) Sometimes we can have a problem in which we need to check if each element of one tuple is greater/smaller than it’s corresponding index in other.     

#### Helpful Concepts 
- Python [Frequency](https://www.geeksforgeeks.org/python-frequency-of-elements-from-other-list/) from elements other than a list
- Python [Classes and Objects](https://www.w3schools.com/python/python_classes.asp) - object-oriented principals
- Python [Intro to Data Structures](https://www.geeksforgeeks.org/python-data-structures/)
