### Reasonable Solutions

```python
class Allergies:
    ALLERGENS = [
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
        self.items = [item
                      for ind, item in enumerate(self.ALLERGENS)
                      if score & (1 << ind)]

    def is_allergic_to(self, item):
        return item in self.items

    @property
    def lst(self):
        return self.items
```

### Common Suggestions

#### Binary Can Help

*Note: This suggestion was written up for a student that was struggling with this exercise, so it's probably quite a bit more wordy than it needs to be for an average submission.*

---

A way that I think makes the logic a little more intuitive is to use binary.

Any time you see powers of 2, it's probably a good idea to at least consider whether or not binary can help you out. First, let's look at how the powers of 2 relate to binary:

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

Notice how each power of two is really just a 1 in a different position? That's why you can multiply or divide things by 2 by using the "bit shifting" operators in Python:

```python
24 << 1
# => 48

100 >> 2
# => 25

bin(1)
# => '0b1'

1 << 7
# => 128

bin(128)
# => '0b10000000'
```

Now, let's talk about the "&" operator. The "&" operator takes two numbers, converts them to binary, and AND's them together, so that the result has a 1 wherever both inputs had a 1 and 0 anywhere else:

```
        00100110
        00100010
    &___________
        00100010
```

In Python, this works on regular numbers. Let's look at 65. Binary for 65 is `0b01000001`, so there is a 1 in the 0th power position (furthest right) and a 1 in the 6th power position (second from the left, which is 64). You'll note that, even though 65 is also larger than 2, 4, 8, 16, and 32, those numbers won't show up as allergens, because there's no 1 in those positions. So let's take a look at what happens when we "&" 65 with each power of 2:

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

See how everything returned zero *except* for 1 and 64? The nice thing about doing things this way is that it provides a slick way of filtering out the higher powers of 2 (256, 512, 1024) that we don't care about.

```python
257 & 1
# => 1
257 & 2
# => 0
# ... All of the rest will be zero.
```

Granted, for 257, there will be a 1 in the **eighth** power of 2 place, but we only care about 0-7, so that won't even bother us.

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

The only one that came out zero is 2, which, on our list, is peanuts. 509 would be allergic to everything but peanuts.

### Talking Points

 - Be careful with making overly complex list comprehensions.  Anytime you add an extra loop or a conditional `if`, try to see if there is any way you can make it extra readable.
 - Python binary operators work on non-binary numbers too.  `35 & 6` works just as well as `0b100011 & 0b110`.