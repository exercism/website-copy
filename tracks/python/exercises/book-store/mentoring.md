
Problems and Challenges
=======================

The problem asks the student to find the lowest price attainable for a collection of books given
varying discounts on combinations of unique books.

Solving this problem is mostly about finding the right algorithm, although it does provide the
opportunity to discuss the general task breaking down a problem using the abstractions provided by
the language, and doing so in a 'Pythonic' way. It also brings to light a couple of Python's more
frequently used built-in modules, namely the `itertools` and `functools` modules.


Acceptability
=============

The mentee's code should be correct and efficient enough to pass the test suite within a reasonable
length of time (under one second is an ok threshold). It should follow standard Python idioms, and
not be overly idiosyncratic.


Reasonable Solutions
====================

Algorithmicly is a pretty clear-cut opportunity to use dynamic programming.  There are two
approaches:

-   Recursively solve the problem, caching the results of sub-problems; or

-   Iterate over a table, calculating values based on those previously calculated.


Recursive Approach
------------------

This is essentially a recursive depth-first search. For each combo we could try, we remove that
combination of items from the basket then recursively compute the best price for the remaining
items:

```python
from itertools import combinations

DISCOUNTS = {
    1:  0.0,
    2:  0.05,
    3:  0.1,
    4:  0.2,
    5:  0.25,
}
TITLES = (1, 2, 3, 4, 5)
FULL_PRICE = 800 # cents

def total(basket):
    """Find the best price attainable for the given list of book titles."""
    return best_price_for(count_quantities(basket))

def best_price_for(quantities):
    """Find the best price for the given quantities of titles."""
    if sum(quantities) == 0:
        return 0
    return min(
        combo_price(combo) + best_price_for(remove(quantities, combo))
        for combo_size in DISCOUNTS
        for combo in combinations(TITLES, combo_size)
        if have_enough_for(quantities, combo)
    )
```

Note use of `itertools.combinations`. The itertools module is very useful; encourage the mentee to
have a look at the documentation.


This implementation uses several helper functions:

```python
def count_quantities(book_list):
    return tuple(book_list.count(title) for title in TITLES)

def have_enough_for(quantities, items):
    return all(
        quantity >= items.count(title)
        for (title, quantity) in zip(TITLES, quantities)
    )

def combo_price(combo):
    num_books = len(combo)
    num_titles = len(set(combo))
    assert num_books == num_titles, "combo titles must be unique"
    price_per_book = FULL_PRICE * (1 - DISCOUNTS[len(combo)])
    return num_books * price_per_book

def remove(quantities, items):
    return tuple(
        quantity - items.count(title)
        for (title, quantity) in zip(TITLES, quantities)
    )
```


Why break it up like this?

-   Extensibility - e.g. it would be easy to add different prices by changing the implementation
    of `combo_price`;

-   Code reuse - the same helper functions are used in the iterative solutions below;

-   Testing - we could write unit tests for each of the helper functions;

-   Readability - the encapsulation provided by the helper functions makes the main function more
    declarative;

-   Functional programming - less mutability make the code less taxing to read (i.e. it doesn't
    use as much of your working memory as you don't need to mentally simulate the evolution of the
    state of the program).


What about performance?

-   Currently, this implementation is extremely slow. But, here's an easy optimization: use a cache.

-   Why does this produce such a significant improvement in performance? There are different ways to
    end up at the same point in the search space; it turns tree-search into graph-search. This is
    the essence of dynamic programming.

-   The runtime of the uncached function grows exponentially w.r.t.  `sum(quantities)`; but the
    cached function's cache certainly grows no larger than `product(quantities)`.


You could implement the cache yourself:

```python
def best_price_for(quantities, _cache=dict()):
    """Find the best price for the given quantities of titles."""
    if quantities not in _cache:
        _cache[quantities] = ...
    return _cache[quantities]
```

(Is there something suprising about the behavior of `_cache=dict()`? Here, this behavior is
exploited intentionally, but it can be source of bugs.)


...or you could use the built-in caching decorator:

```python
from functools import lru_cache

@lru_cache(None)
def best_price_for(quantities):
    """Find the best price for the given quantities of titles."""
    ...
```

The latter is preferable for a couple of reasons: it doesn't re-invent the wheel, and it happens to
also be thread-safe (perhaps a topic of discussion for the more advanced mentee).


Here's another easy optimization:

-   To improve any d.p. algorithm, try to reduce the size of the search space.

-   One way to do this is to find classes of states that produce the same result, and represent each
    class with a canonical form.

-   Since prices are all the same, how much we have of which title doesn't matter, so:
        best_price_for(quantities) == best_price_for(tuple(sorted(quantities)))


Put into practice:

```python
@lru_cache(None)
def best_price_for(quantities):
    """Find the best price for the given quantities of titles."""
    canonical = tuple(sorted(quantities))
    if quantities != canonical:
        return best_price_for(canonical)
    ...
```

This more than halves running time of test suite on the author's computer.

It might be interesting to compare the statistics returned by `best_price_for.cache_info()` with and
without this optimization.


Iterative Approach
------------------

The recursive approach seems fine, however there are a couple of reasonable points of concern:

1.  Python is generally not optimized for recursion.

2.  There's a real risk of the maximum recursion depth being exceeded if there is a large number of
    any one title. Running `total([1] * 1000)` on the author's machine cause a `RecursionError` to
    be raised. While perhaps this is unrealistic input, it might be an interesting point to discuss,
    as this sort of thing can be a problem in practice.


The iterative approach mitigates these concerns but can produce somewhat less elegant code. A
straightforward approach is to use a `for` loop for each of the five titles:

```python
def total(basket):
    table = {(0, 0, 0, 0, 0): 0}
    target_quantities = (n1, n2, n3, n4, n5) = count_quantities(basket)
    for i1 in range(n1+1):
        for i2 in range(n2+1):
            for i3 in range(n3+1):
                for i4 in range(n4+1):
                    for i5 in range(n5+1):
                        quantities = (i1, i2, i3, i4, i5)
                        if sum(quantities) == 0:
                            continue
                        table[quantities] = min(
                            combo_price(combo) 
                            + table[remove(quantities, combo)]
                            for combo_size in DISCOUNTS
                            for combo in combinations(TITLES, combo_size)
                            if have_enough_for(quantities, combo)
                        )
    return table[target_quantities]
```

This works, but:

-   It's ugly;

-   It's not very extensible - what if we wanted to increase number of titles?  There's a general
    principle to be learnt: try to avoid hard-coding data into the program.


An alternative is to recur w.r.t. the different items:

```python
def total(basket):
    targets = count_quantities(basket)
    table   = build_table(targets)
    return table[targets]

def build_table(targets, quantities=(), remaining=len(TITLES), table=None):
    table = table or {(0,) * remaining: 0}
    if remaining:
        target = targets[remaining-1]
        for quantity in range(target+1):
            build_table(targets, (quantity,)+quantities, remaining-1, table)
    elif sum(quantities) > 0:
        table[quantities] = min(
            combo_price(combo) + table[remove(quantities, combo)]
            for combo_size in DISCOUNTS
            for combo in combinations(TITLES, combo_size)
            if have_enough_for(quantities, combo)
        )
    return table
```

Here are some thoughts on this implementation:

-   This might be a good compromise. It is recursive, but along a different axis and wont recur too
    deeply (unless list of titles is changed to be very large; but cross that bridge if you ever
    come to it).

-   It's important to understand mutability to interpret how this implementation works --- this can
    be a stumbling block for beginners.  How is the data shared? Only one table is ever created, so
    everyone is putting their data into that same table.

-   As with the recursive approach, this can be optimized with a canonical form.

-   Why use dict of tuples and not a 5-dimensional array? The latter is complicated; the author 
    couldn't figure out how to implement it elegantly.

-   The work done to build up the table is lost between calls to `total`, although the code can be
    modified so that the data is preserved.


Talking Points 
==============

-   It's common to see solutions that first take the naive approach (take the largest combo possible
    until no books remain) and then specifically correct for the fact that a pair of four-book
    combos is better value than a three-book combo plus a five-book combo. This works in as much as
    it passes the test-suite, but is a slighly fragile solution: what if the discounts are changed?
    or more book titles are added?

-   As this is the last exercise in the Python track consider pointing the mentee towards avenues
    for further learning.


Useful Links 
============

```text

[dynamic programming](https://www.geeksforgeeks.org/dynamic-programming/) [canonical
form](https://en.wikipedia.org/wiki/Canonical_form)

[itertools](https://docs.python.org/3/library/itertools.html)
[`itertools.combinations`](https://docs.python.org/3/library/itertools.html#itertools.combinations)
[`functools.lru_cache`](https://docs.python.org/3/library/functools.html#functools.lru_cache)

```
