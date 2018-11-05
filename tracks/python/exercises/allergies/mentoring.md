### Reasonable Solutions

A `list`-based solution optimizes for `Allergies.lst` access, but sacrifices the speed of `Allergies.is_allergic_to` lookups.

```python
class Allergies:
    allergens = [
        "eggs",
        "peanuts",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats",
    ]

    def __init__(self, score):
        self.score = score
        self._items = [item
                       for ind, item in enumerate(self.allergens)
                       if score & (1 << ind)]

    def is_allergic_to(self, item):
        return item in self._items

    @property
    def lst(self):
        return self._items
```

A `dict`-based solution optimizes for `Allergies.is_allergic_to` lookups, but sacrifices the speed of `Allergies.lst` access.
The `Allergies.lst` cost is greater if maintaining sort order in Python versions < 3.7 is important.

```python
class Allergies:
    allergens = {
        "eggs":         1,
        "peanuts":      2,
        "shellfish":     4,
        "strawberries": 8,
        "tomatoes":     16,
        "chocolate":    32,
        "pollen":       64,
        "cats":         128,
    }

    def __init__(self, score):
        self.score = score
        self._items = {k: v for k, v in self.allergens.items() if score & v}

    def is_allergic_to(self, item):
        return item in self._items

    @property
    def lst(self):
        return sorted(self._items, key=self.allergens.get)
```

A hybrid solution seeks decent performance from both access methods.

```python
class Allergies:
    allergens = {
        "eggs":         1,
        "peanuts":      2,
        "shellfish":     4,
        "strawberries": 8,
        "tomatoes":     16,
        "chocolate":    32,
        "pollen":       64,
        "cats":         128,
    }

    def __init__(self, score):
        self.score = score
        self._items = [item for item in self.allergens if self.is_allergic_to(item)]
        self._items.sort(key=self.allergens.get)

    def is_allergic_to(self, item):
        return self.allergens.get(item, 0) & self.score != 0

    @property
    def lst(self):
        return self._items
```

Lastly, an `enum.Flag`-based solution sacrifices some overall performance in exchange for readability.

```python
from enum import Flag, auto

class Allergens(Flag):
    EGGS = auto()
    PEANUTS = auto()
    SHELLFISH = auto()
    STRAWBERRIES = auto()
    TOMATOES = auto()
    CHOCOLATE = auto()
    POLLEN = auto()
    CATS = auto()

class Allergies:
    def __init__(self, score):
        self.score = Allergens(score & sum(a.value for a in Allergens))
        self._items = [a.name.lower() for a in Allergens if a in self.score]
    
    def is_allergic_to(self, item):
        try:
            return Allergens[item.upper()] in self.score
        except KeyError:
            return False

    @property
    def lst(self):
       return self._items
```

### Common Suggestions

#### The Binary Representation of Integers and Bitwise Operators Can Help

*Note: This suggestion was written up for a student that was struggling with this exercise, so it's probably quite a bit more wordy than it needs to be for an average submission.*

---

An approach that makes the logic more intuitive is to leverage the _binary representation_ of integers and the _bitwise operators_ that Python provides to work with them.

Recall that, from the computer's perspective, _all_ integers are stored as binary data; when you work with the decimal (aka base 10) integers (ie 0 - 10), you're really just interacting with the _decimal representation_ of the underlying binary data. The computer simply defaults to decimal because it is the most familiar and easily understood representations for humans. There are other _useful_ representations, including _octal_ (base 8) and _hexidecimal_ (base 16), but from Python's perspective an integer value in any one representation is _exactly_ the same as the same value in any other representation.

```
0b01100100 == 0o144 == 100 == 0x64  # notice they're all the same value...
# => True

0b01100100 is 0o144 is 100 is 0x64  # but also all the same actual object in memory
# => True
```

For most purposes there's no reason not work in the familiar decimal world, but some problems benefit from working with the binary representation directly. Any time you see powers of 2, it's a good idea to at least consider whether or not the binary representation and bitwise operators can help you out. When you see exclusively unique powers of 2 being summed, especially, it's an indicator you might be working with, or may want to implement, a _bit flag_.

First, let's look at how the smaller powers of 2 look in their 8-bit binary representation:

```
2**0       1       0b00000001
2**1       2       0b00000010
2**2       4       0b00000100
2**3       8       0b00001000
2**4      16       0b00010000
2**5      32       0b00100000
2**6      64       0b01000000
2**7     128       0b10000000
```

Notice how each power of 2 is really just a single 1 in a unique column? And that moving the 1 a column to the left doubles the value? That's what allows you to multiply by 2 using the _bitwise left shift_ (`<<`) operator, and divide by 2 using the _bitwise right shift_ (`>>`) operator:

```python
24 << 1
# => 48

100 >> 2
# => 25

1 << 7  # ie 1 x 2^7
# => 128
```

Incidentally, the `bin` function is a helpful way to quickly check the binary representation of a given value, but notice that it does strip off any leading 0s.

```
bin(1)
# => '0b1'

bin(128)
# => '0b10000000'
```

Ok, but how is all of this useful to the problem at hand? Well, notice what happens to the binary representation of the result when you exclusively sum unique powers of 2 (ie, no individual power of 2 ever contributes to the sum more than once).

```
    0b00000001  # 1
    0b01000000  # 64
    0b10000000  # 128
+   __________
    0b11000001  # 193
```

See how the sum has a 1 in every column for which each of the components had a 1? That is the property that allows us to construct a bit flag: all we need to do to check if a given power of 2 contributed to a given sum is to see if they share a 1 in the same column.

But how do we do that?

Well, let's talk about the _bitwise AND_ operator (`&`); this operator takes two numbers and performs an AND of their binary representations, returning the number that has a 1 wherever _both_ inputs had a 1 and 0 anywhere else; so, for instance, `38 & 34` will return `34` because of the columns in which both values share a 1, while `3 & 32` will return `0` because no shared 1 columns exist.

```
    0b00100110 # 38
    0b00100010 # 34
&   __________
    0b00100010 # 34

    0b00000011 # 3
    0b00100000 # 32
&   __________
    0b00000000 # 0
```

So, let's look at 65; the binary representation of 65 is `0b01000001`, so there is a 1 in the 0th power position (furthest right, which is 1) and a 1 in the 6th power position (second from the left, which is 64), which makes it the sum of 1 and 64. You'll note that, even though 65 is larger than 2, 4, 8, 16, and 32, those numbers did not contribute to 65 because there's no 1 in their respective columns. So let's take a look at what happens when we bitwise AND 65 with each power of 2.

```python
65 & 1
# => 1
65 & 2
# => 0
65 & 4
# => 0
65 & 8
# => 0
65 & 16
# => 0
65 & 32
# => 0
65 & 64
# => 64
65 & 128
# => 0
```

See how everything returned zero _except_ for 1 and 64? The nice thing about doing things this way is that it provides a slick way of filtering out the higher powers of 2 (in this case 256, 512, 1024, etc) that we don't care about.

```python
257 & 1
# => 1
257 & 2
# => 0
# ... All of the rest will be zero.
```

Granted, for 257, there will be a 1 in the **eighth** power of 2 place, but for the purposes of this exercise we only care about columns 0-7, so we can ignore that column.

To make that extra clear, let's do 509. Binary for 509 is:

```
0b111111101
# We'll only be checking the rightmost 8 digits:
0b1 | 11111101
```

Let's check each of our allergens:

```python
509 & 1
# => 1
509 & 2
# => 0
509 & 4
# => 4
509 & 8
# => 8
509 & 16
# => 16
509 & 32
# => 32
509 & 64
# => 64
509 & 128
# => 128
```

The only one that came out zero is 2, which, on our list, is peanuts. So anyone with score of 509 would be allergic to everything but peanuts.

### Talking Points

 - Be careful with making overly complex list comprehensions.  Anytime you add an extra loop or a conditional `if`, try to see if there is any way you can make it extra readable.
 - Integers are integers; `0b10000000 == 128 and 0b10000000 is 128`; there's no such thing as a "binary number" or "non-binary number", there are only different representations.
 - Python binary operators work on numbers given in any representation.  `35 & 6` works just as well as `0b100011 & 0b110` or for that matter `0x23 & 0o6`
