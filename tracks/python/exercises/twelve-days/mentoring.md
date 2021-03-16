# Mentoring

### Problem and challenges

You are asked to print portions of the Christmas Carol
"The Twelve Days of Christmas", a recursive song like
"Chad Gadya" or the poem "The House the Jack Built".

There are three challenges

* Producing the ordinal names (first, second) and gifts.
* Adapting the text for the first day
* Pasting things together in the right order

### Reasonable solutions

```python
days = [None, 'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
        'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth']

text = ["Bucket of coal",
        "and a Partridge in a Pear Tree.",
        "two Turtle Doves, ",
        "three French Hens, ",
        "four Calling Birds, ",
        "five Gold Rings, ",
        "six Geese-a-Laying, ",
        "seven Swans-a-Swimming, ",
        "eight Maids-a-Milking, ",
        "nine Ladies Dancing, ",
        "ten Lords-a-Leaping, ",
        "eleven Pipers Piping, ",
        "twelve Drummers Drumming, "]


def one_verse(days, text, start: int) -> str:
    format_string = "On the {} day of Christmas my true love gave to me: "

    result = [format_string.format(days[start])]

    # The first time we need to trim the "and " in a Partridge
    if start == 1:
        gifts = [text[1][4:]]
    else:
        gifts = [text[day] for day in range(1, start + 1)]

    return ''.join(result + gifts[::-1])


def recite(start: int, finish: int) -> list:
    return [one_verse(days, text, i) for i in range(start, finish+1)]
```

This solution uses a list of strings representing the numbers.
To avoid the need to compute the spot, we include a dummy entry
for days[0] and verse[0].

The gifts are listed in reverse order, which is handled by
reversing the list above.

One way of dealing with the "and " in the Pear Tree is
to hand it off to the Turtle Doves:

```python
def recite(start_verse, end_verse):
    days = ['twelve Drummers Drumming,','eleven Pipers Piping,',
            ...
            'two Turtle Doves, and',
            'a Partridge in a Pear Tree.']
```

This is clever, but too opaque to recommend.

Another attempt to deal with this uses surgery:

```python
    if start_verse != 1 and end_verse != 1:
        verses[0][1] = 'and ' + verses[0][1]
```

This works until you want to recite the first verse again.  
And and and and it leads to an excess of additions.  

#### Choice of Data Structures

You can create a dictionary to hold the names, like this:

```python
ordinals = { 1: 'first', 2: 'second', ... }
```

The Dictionary is a great data structure when you need it.
However, it uses a lot of memory, and it is no faster
than a simple list at finding the nth entry.

You will see solutions that use a list for the gifts and a dictionary
for the numbers: they know how to use a list, 
but revert to the familiar solution for translation.

#### Precooked Solutions

Some solutions simply use a precooked list.

```python
def getLyricsFromFile(fileName = 'lyrics.txt'):
    with open(fileName) as lyricsFile:
        verses = [line.rstrip('\n') for line in lyricsFile]
    return verses

def recite(start_verse, end_verse):
    start_verse -= 1
    verses = getLyricsFromFile()
    song = []
    for i in range (start_verse, end_verse):
        song.append(verses[i])
    return song
```

This depends upon having a file with
12 lines with the assembled text. While it solves the
problem, it avoids all the difficulties mentioned in
the introduction.

Encourage the student to address the challenges of
dealing with the raw material.
You can point out that they are storing the Pear Tree
twelve times, and challenge them to store it only once.

The next solution also prepares everything, but 
solves all the difficulties mentioned, while working
a bit too hard.

```python
    result = list()
    gifts = list()
    for index, day_gift in enumerate(days_gifts, 1):
        day, gift = day_gift

        # Insert the current gift to the beginning of the list
        gifts.insert(0, gift)

        # Include the "and" to the first gift (last from the list)
        if len(gifts) == 2:
            gifts[-1] = 'and ' + gifts[-1]

        # Only append the verse which is between the start and end
        if start_verse <= index <= end_verse:
            result.append(verse.format(day, ', '.join(gifts)))

    return result
```

This solution builds all twelve verses each time, and hands back
those that are needed.
Point out the inefficiency.


#### String Addition

Programming is the universal language!
This one uses string addition.

```python
def recite(start_verse , end_verse):

    lista = []

    for dia in range(start_verse - 1, end_verse):
        textoDos = " "
        if dia:
            textoDos += ", ".join(texto[len(texto) - dia:]) + ", and "
        lista.append(
            f"On the {dias[dia]} day of Christmas my true love gave to me:"
            f"{textoDos}a Partridge in a Pear Tree.")
    return lista
```

As usual, request a solution that appends to a list and calls join().

#### Too Clever By Half

```python
PLAIN_GIFTS = [
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
]

GIFTS = [f'{x}, ' for x in PLAIN_GIFTS]
```

The solution stores the gifts twice: the initial
copy saves space by leaving off a ', ' per entry.

While uncommon, it is an example of the kind of
false economy that should be nipped in the bud.

#### Talking Points

List Comprehension, delegation of concerns.
