# Mentoring

Hamming is composed of two sub-problems: how to **iterate** through two collections, and how to **count** based on a condition.

The `Enumerable` module contains fantastic tools to solve these problems.
This is a great exercise to introduce students to some of its features.

## Reasonable Solutions

There are three strategies for the **iteration**.
In descending order of popularity with mentors:

Hybrid approach

1. Iterating through both strings simultaneously via `Enumerable#zip`;
2. Iterating explicit indices using a `Range`, `Integer#upto`, or `Integer#times`;
3. A hybrid approach with `Enumerable#each_with_index`, iterating over one of the strings while also tracking the index to find the equivalent character in the other string.
   Uses `Enumerable#each_with_index`.
   (See notes below on `chars` vs `each_char`.)

A counting approach on the other hand really only has one good solution:

1. using `Enumerable#count` with a block.

Note how the English instructions:

> … counting how many of the nucleotides are different from their equivalent in the other string.

translate almost directly into the Ruby code:

```ruby
.count { |char1, char2| char1 != char2 }
```

It is worthwhile pointing this out to students who use `#count` in their solutions.
It is one of the things that is really nice about Ruby!

## Examples

Strategy 1: `zip`

```ruby
class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError unless strand1.length == strand2.length

    strand1.chars.zip(strand2.chars).count { |char1, char2| char1 != char2 }
  end
end
```

Pros: avoids indices entirely
Cons: needs to convert the string to an array

Strategy 2: String Power

```ruby
    (0...strand1.length).count { |i| strand1[i] != strand2[i] }
```

Pros: uses string directly; no array conversion needed;
Cons: requires indices.

Strategy 3: Each char and with index

```ruby
    strand1.each_char.with_index.count {|letter, index| letter != strand2[index] }
```

Pros: more intuitive? (students seem to pick this often);
Cons: requires indices.

## Mentoring flow

Most students start at either steps 1 or 2.

1. If student used `#each`, `for`, `while`, or `until`, challenge them to
   eliminate the manual index management (using one of the iteration strategies
   outlined above)
2. If student is iterating without a manual index, but still using a manual
   counter, challenge them to eliminate it (likely via `#reduce`/`#inject` or
   `#count`)
3. If the student is counting via `#reduce`/`#inject`, point them towards
   `#count`
4. Quick round of style/idiomatic suggestions such as using `String#chars`
5. (Optional) if the student is already doing all this, challenge them to solve
   without indices at all (with the optimal solution: `#zip`)

More details on particular pieces of feedback and good conversations to have in
the _Common Suggestions_ and _Talking Points_ sections below.

## Common Suggestions

- By far the most common feedback revolves around eliminating the use of manually managed intermediate counter and index variables.
  In Ruby you should almost never need to manually increment an index or counter.
  We have other constructs available that will automatically manage these for us.
- I try to focus on one big thing in the first round of feedback and this is almost always it.
  I leave style and minor improvement suggestions for a quick final round at the end.
- No matter how important _Naming Things_ is, Hamming is not the best place to discuss the naming of the arguments, because there is no solution that seems to satisfy everyone, while a lot of people have strong opinions on it.
  Another reason is that Hamming is a generic algorithm, used for much more than only genetics.
- The following few core exercises offer plenty of opportunities to discuss naming.

## Too weak Enumerable

Many students will use `Array#each` to do the looping but have manual counter and index variables

```ruby
index = 0
counter = 0
strand1.chars.each do |char|
  counter += 1 if char != strand2[index]
  index += 1
end

return counter
```

There is a variation on this that uses `Enumerable#each_with_index` to eliminate the manual index management (good job!) but still keeps the counter.

This is almost always a sign that they need a more powerful `Enumerable` method.
I commonly leave a response that looks like this:

```md
If you look at the main logic, you will see the following pattern:

1. Initialize an empty variable
2. Iterate over items in a collection, conditionally modifying the variable in each iteration
3. After iteration is complete, return the current value of the variable

When you see this pattern in Ruby, it is usually a sign that you should instead be using one of the more powerful methods from `Enumerable`.
Can you think of a way to eliminate the need for the intermediate variable `count`?

You may find [this article on refactoring with Enumerable][refactoring-with-enumerable] helpful.
Also it is worth scanning through the [`Enumerable` docs][enumerable-docs].
```

## Primitive looping

This one is similar to the "too weak enumerable" but uses a primitive construct like `for`, `while`, or `until` to do the looping.
These are generally considered non-idiomatic in Ruby.

I have found that focusing on the use of manually managed intermediate variables (just like with the "too weak enumerable case") is a better tactic than starting a conversation on what is considered an idiomatic looping construct.
In order to eliminate the intermediate variables the student will naturally move away from the primitive constructs.

## Reducing _+1_

Many students will try to use `Enumerable#reduce`/`Enumerable#inject` to count the elements that do not match.
While this is a good approach, reducing a conditional +1 like:

```ruby
reduce(0) { |total, element| total + 1 if some_condition? }
```

is such a common operation that there is a dedicated method for it: `Enumerable#count`.

## String splitting

Students commonly try to turn a string into characters using `String#split` and either an empty string or empty regex.
It turns out there is already a built-in method for splitting a string into its characters: `String#chars`.

_You do not need to `split` the string into characters to iterate over it though._
That may be why Ruby also provides `String#each_char` (which returns an `Enumerator`, or a `String`, not an
Array).

## Talking points

### Signal v noise

Code is a form of communication with both humans and computers.
It is often a balancing act to write something the computer can execute but that humans can easily read.
Because there are often multiple ways of writing a solution, human readability often relies on picking the one with the higher signal-to-noise ratio.

_Can the student think of some ways to eliminate noise in their solution and focus on the signal?_

Manually managed intermediate counter and index variables are one form of noise.
They are only there for the computer but add nothing for the human reading the code.

Indexing into `Arrays`/`Strings` can often fall into this category, too.

I like linking to ThoughtBot's [iteration as an anti pattern][iteration-as-an-anti-pattern] when discussing iteration and intermediate variables.

### Class methods

Students will occasionally ask why the code exists at the class level rather than as an instance.
This most often comes up when the student is trying to break out a private class method.
Hamming does not really need to break out any methods (the ideal solution is a one-liner) so this is probably a sign their attempted solution is too complex.
Points for thinking about method visibility though!

While possibly overkill for hamming, it is worth suggesting moving logic to the instance level.
It is a common pattern in Ruby to write code like:

```ruby
class Hamming
  def self.compute(strand1, strand2)
    new(strand1, strand2).compute
  end

  def initialize(strand1, strand2)
    @strand1 = strand1
    @strand2 = strand2
  end

  def compute
    # implementation here
  end
end
```

I like linking to Code Climate's classic [class methods resist refactoring][class-methods-resist-refactoring] article and ThoughtBot's [meditations on a class method][medititations-on-a-class].

### Reduce specializations

`Enumerable#count` is a specialization of reduce.
Specifically reducing `total + 1`.
If you have a conversation about reduce and count, it can be worth highlighting that there are other common reducing operations that have dedicated methods too:

- Reducing `+` is `Enumerable#sum`
- Reducing `||` is `Enumerable#any?`
- Reducing `&&` is `Enumerable#all?`

### zipping

While the `Enumerable#zip` is my favorite solution, I usually do not push it because students have already learned some big new concepts on this exercise.
However, for students that have a good (index-based) solution on the first submission, I will often give them the optional challenge to solve the problem without indexes (I try not to give away the answer).

If they choose to try, make sure to compare and contrast the two solutions.
Do indexes make the code less readable?
More readable?
Is `zip` a dense and obscure method?
How does this fit in a signal/noise analysis of the code?
Does one's computing language background affect what one considers "readable"?

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)

[class-methods-resist-refactoring]: https://codeclimate.com/blog/why-ruby-class-methods-resist-refactoring/
[refactoring-with-enumerable]: https://robots.thoughtbot.com/iteration-as-an-anti-pattern
[enumerable-docs]: https://ruby-doc.org/core-2.5.1/Enumerable.html
[iteration-as-an-anti-pattern]: https://robots.thoughtbot.com/iteration-as-an-anti-pattern
[medititations-on-a-class]: https://robots.thoughtbot.com/meditations-on-a-class-method
