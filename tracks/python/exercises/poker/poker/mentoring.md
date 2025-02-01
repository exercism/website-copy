# Mentor’s Guide to Supporting Students on Poker Hand Evaluation

This guide is designed to help mentors support current students as they work on the problem of evaluating and comparing poker hands. It emphasizes core concepts, principles, and problem-solving approaches—including parsing input, evaluating a hand, ranking hands, and selecting the best hand

---

## 1. Reasonable Solution(s)

### Parsing and evaluating and returning the best hand(s)

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

---

## 2. Common Suggestions

- **Using frequency counts to simplify evaluation** rather than iterating multiple times.
- **Sorting values upfront** to make straight detection simpler.
- **Using tuples for ranking** to take advantage of built-in tuple comparison.
- **Using a dictionary to store card frequencies** instead of repeatedly counting occurrences.

---

## 3. Talking Points

- **Why is frequency counting effective?**
- **How does tuple comparison simplify ranking comparisons?**
- **What are the best ways to handle edge cases like ********************************`"10"`******************************** vs ********************************`"T"`********************************?**
- **How should students approach debugging when rankings appear incorrect?**
- **What are the trade-offs between different data structures for storing hands?**
- **Does an object oriented approach for cards or hands make sense here? Why or why not**

---

## 4. Change Guide

- **2024 January** - Initial version of the mentor guide created.

