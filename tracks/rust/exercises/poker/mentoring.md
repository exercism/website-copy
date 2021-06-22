### Concepts

- Iterators
- Iterator Methods
- Pattern matching
- Modeling a problem with the type system

### Reasonable Solutions

A reasonable solution should:

- Use iterator whenever possible instead of for loops with conditionals inside
- Not store the string reference given as an argument inside a data structure.
- Represent the problem space extensively with the type system. Using u8 to represent cards is possible but not very readable.
- **_optional_** use pattern matching on slices for the check if a hand is a straight of to check the card counts. The pattern matching on slice was stabilized on 1.42 [ref](https://blog.rust-lang.org/inside-rust/2020/03/04/recent-future-pattern-matching-improvements.html)

### Examples

```rust
use std::cmp::Ordering;
use std::collections::{HashMap, HashSet};

#[derive(Debug, Copy, Clone, Eq, PartialEq, Hash)]
enum Suit {
    Clover,
    Diamond,
    Spade,
    Heart,
}

impl Suit {
    pub fn new(raw: char) -> Suit {
        match raw {
            'C' => Suit::Clover,
            'D' => Suit::Diamond,
            'S' => Suit::Spade,
            'H' => Suit::Heart,
            _ => unreachable!(),
        }
    }
}

#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
enum Rank {
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Jack,
    Queen,
    King,
    Ace,
}

impl Rank {
    pub fn new(raw: char) -> Rank {
        match raw {
            '2' => Rank::Two,
            '3' => Rank::Three,
            '4' => Rank::Four,
            '5' => Rank::Five,
            '6' => Rank::Six,
            '7' => Rank::Seven,
            '8' => Rank::Eight,
            '9' => Rank::Nine,
            'J' => Rank::Jack,
            'Q' => Rank::Queen,
            'K' => Rank::King,
            'A' => Rank::Ace,
            _ => unreachable!(),
        }
    }
}

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
struct Card {
    rank: Rank,
    suit: Suit,
}

impl PartialOrd for Card {
    fn partial_cmp(&self, other: &Card) -> Option<Ordering> {
        Some(self.rank.cmp(&other.rank))
    }
}

impl Ord for Card {
    fn cmp(&self, other: &Card) -> Ordering {
        self.rank.cmp(&other.rank)
    }
}

impl Card {
    pub fn new(raw: &str) -> Card {
        let split: Vec<char> = raw.chars().collect();
        match split.as_slice() {
            [_, _, suit] => Card {
                rank: Rank::Ten,
                suit: Suit::new(*suit),
            },
            [rank, suit] => Card {
                rank: Rank::new(*rank),
                suit: Suit::new(*suit),
            },
            _ => unreachable!(),
        }
    }
}

struct Hand {
    cards: Vec<Card>,
}

impl Hand {
    pub fn new(raw: &str) -> Hand {
        let mut cards: Vec<Card> = raw.split(' ').map(Card::new).collect();
        cards.sort();
        Hand { cards }
    }

    pub fn rank_counts(&self) -> Vec<(u8, Rank)> {
        let mut ranks: HashMap<Rank, u8> = HashMap::new();
        for Card { rank, .. } in self.cards.iter() {
            *ranks.entry(*rank).or_insert(0) += 1;
        }
        let mut rank_counts: Vec<(u8, Rank)> = ranks.iter().map(|(r, c)| (*c, *r)).collect();
        rank_counts.sort();
        rank_counts
    }

    pub fn straight(&self) -> Option<Rank> {
        use crate::Rank::*;
        let cards = self
            .cards
            .iter()
            .map(|Card { rank, .. }| rank)
            .collect::<Vec<_>>();
        match cards.as_slice() {
            [Two, .., Five, Ace] => Some(Five),
            [Two, .., Six] => Some(Six),
            [Three, .., Seven] => Some(Seven),
            [Four, .., Eight] => Some(Eight),
            [Five, .., Nine] => Some(Nine),
            [Six, .., Ten] => Some(Ten),
            [Seven, .., Jack] => Some(Jack),
            [Eight, .., Queen] => Some(Queen),
            [Nine, .., King] => Some(King),
            [Ten, .., Ace] => Some(Ace),
            _ => None,
        }
    }

    pub fn is_flush(&self) -> bool {
        let suits: HashSet<Suit> = self.cards.iter().map(|card| card.suit).collect();
        suits.len() == 1
    }
}

#[derive(Eq, Ord, PartialEq, PartialOrd)]
enum HandRank {
    HighCard(Rank, Rank, Rank, Rank, Rank),
    OnePair(Rank, Rank, Rank, Rank),
    TwoPairs(Rank, Rank, Rank),
    ThreeOfAKind(Rank, Rank, Rank),
    Straight(Rank),
    Flush(Rank, Rank, Rank, Rank, Rank),
    FullHouse(Rank, Rank),
    FourOfAKind(Rank, Rank),
    StraightFlush(Rank),
}

impl HandRank {
    pub fn new(hand: Hand) -> HandRank {
        match hand.rank_counts().as_slice() {
            [(1, single), (4, four)] => HandRank::FourOfAKind(*four, *single),
            [(2, pair), (3, three)] => HandRank::FullHouse(*three, *pair),
            [(1, low), (1, high), (3, three)] => HandRank::ThreeOfAKind(*three, *high, *low),
            [(1, single), (2, low), (2, high)] => HandRank::TwoPairs(*high, *low, *single),
            [(1, low), (1, mid), (1, high), (2, pair)] => {
                HandRank::OnePair(*pair, *high, *mid, *low)
            }
            [(1, l1), (1, l2), (1, m), (1, h1), (1, h2)] => {
                match (hand.straight(), hand.is_flush()) {
                    (None, false) => HandRank::HighCard(*h2, *h1, *m, *l2, *l1),
                    (None, true) => HandRank::Flush(*h2, *h1, *m, *l2, *l1),
                    (Some(high), false) => HandRank::Straight(high),
                    (Some(high), true) => HandRank::StraightFlush(high),
                }
            }
            _ => unreachable!(),
        }
    }
}

/// Given a list of poker hands, return a list of those hands which win.
///
/// Note the type signature: this function should return _the same_ reference to
/// the winning hand(s) as were passed in, not reconstructed strings which happen to be equal.
pub fn winning_hands<'a>(hands: &[&'a str]) -> Option<Vec<&'a str>> {
    if hands.is_empty() {
        return None;
    }
    let best_hand = hands
        .iter()
        .cloned()
        .map(Hand::new)
        .map(HandRank::new)
        .max()
        .unwrap();
    hands
        .iter()
        .filter(|s| HandRank::new(Hand::new(*s)).cmp(&best_hand) == Ordering::Equal)
        .cloned()
        .collect::<Vec<_>>()
        .into()
}
```

### Common suggestions

#### No need to store a reference to the given string

Storing hand_str inside the Hand struct makes an allocation and isn't necessary. Filtering on the given hands argument to return the winning hands will save those string allocations.

#### Using complex logic to determine the hand category

Many students will go into 10-20 lines logic trying to determine the existence and the number of pairs, triples, and quadruple. That logic can usually be replaced with collecting ranks into a `Hashmap` and pattern macthing on it.
