# Clock

Clock introduces students to the concept of **value objects** and **[modular
arithmetic](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic)**.

**Note:** This exercise changes a lot depending on which version the person has solved.

## Reasonable solutions

```ruby
class Clock
  MINUTES_PER_HOUR = 60
  MINUTES_PER_DAY = 1440

  def initialize(hour: 0, minute: 0)
    @time = ((hour * MINUTES_PER_HOUR) + minute) % MINUTES_PER_DAY
  end

  def to_s
    "%02d:%02d" % time.divmod(MINUTES_PER_HOUR)
  end

  def +(other)
    self.class.new(minute: time + other.time)
  end

  def -(other)
    self.class.new(minute: time - other.time)
  end

  def ==(other)
    time == other.time
  end
  alias eql? ==

  def hash
    [self.class, self.time].hash
  end

  protected

  attr_reader :time
end
```

A good solution should have the following:

* Store a single quantity
* Implement [value-object semantics](https://www.sitepoint.com/value-objects-explained-with-ruby/) (immutability, `==`/`hash`/`eql?` by value)
* Not store more than a day's worth of time
* Use `protected` to allow access to another instance’s `time` in `==` without making the attributes public.
- Use constants instead of [magic numbers](https://refactoring.guru/replace-magic-number-with-symbolic-constant).

## Mentoring flow

1. Discuss single vs double quantity in more depth modeling
2. Discuss immutability
3. Discuss guaranteeing that you store less than a days worth of time (this is
   easier if you've got immutable objects because validation can be done once in
   the constructor)
4. Discuss hash/eql?
5. Teach `divmod()`
5. Final round discussing style

## Common suggestions

### Modeling objects with a single quantity versus separate minutes and hours

This makes the math easier. Storing hours and minutes separately is effectively
caching a calculation. It's usually done because the student is modeling human
groupings directly. Help student realize that "time elapsed since midnight" is a
single quantity, even though humans represent it as two quantities for ease of
reading.

### Return new instances from `+` and `-`

In general, value objects should never change and instead return new instances.
This prevents tricky bugs in client code. More on this in the talking points
below.

### Implement `#hash` and `#eql?`

Objects that re-implement `#==` usually also want to re-implement `#hash` and
`#eql?` so that objects that are considered the "same" are still considered
"same" when used as hash keys. It's normal to define these methods when creating
value objects.

### Don't store more than a day's worth of time

A `Clock` represents the time elapsed since midnight _this morning_. This number
cannot be greater than than 1439 minutes (23:59). Anything over is greater than
a day violates the expectation of what a `Clock` represents. The student should
use modulo to roll over to the next day in the constructor.

Doing this allows students to remove any code that does division by 24 or
conditionally checks for time greater than one day sprinkled in other parts of
their code.

### Don't manually check for negative numbers

The output of a modulo operation will _always_ be positive:

Modulo operations on negative numbers just move backwards on the clock. This
means you don't need extra logic to check for negative numbers.

See the discussion on modulo vs remainder in the talking points below.

### Use named constants instead of using numbers directly

Using constants instead of numbers like 60, 24, 1440 directly helps with
readability. A good guideline is that all numbers other than 1 and 0 should used
via a constant rather than directly inline.

## Talking points

### Storing 1 vs 2 quantities

**What is a Clock?**

Think about what a `Clock` represents. It's a time-of-day, a value between 00:00
and 23:59. A time-of-day is effectively a big counter that starts at 0 and
resets after one day.

**Human vs Computer**

Humans break up large numbers into different size units to make them easier to
understand. _"10 hours and 40 minutes"_ makes more sense (to an English speaker)
than _"640 minutes"_. We do the same with other quantities too (e.g. _"5 feet
and 6 inches"_ instead of _"66 inches"_).

Computers on the other hand don't care. In software, these sorts of counters are
usually implemented as a single number in whatever the smaller unit is (e.g.
milliseconds for time or cents for US currency). This makes the math easier and
you can easily convert to human readable formats when it's time to render.

**Prior Art**

Times and dates in particular are usually defined this way. You define some zero
point (sometimes called the _epoch_) and store a single counter since then. Some
examples of this approach include:

* [UNIX timestamps](http://unixtimestamp.50x.eu/about.php) measure date-times as
  the number of milliseconds since midnight on January 1st 1970.
* [Postgres time-of-day](https://www.postgresql.org/docs/current/static/datatype-datetime.html)
stores the number of microseconds since midnight (very similar problem to
`Clock` but with higher precision)

**Math**

Adding is now easy because it's just ... adding. No need to re-balance
hours/minutes every time you add minutes.

Getting the human-readable values is easy too. To get hours and minutes you
either divide or modulo by the number of minutes per hour (60)

```ruby
def hours
  @total / 60
end

def minutes
  @total % 60
end
```

However, it's easier to use the `divmod` method which does both things at once.

**Storing Two Values**

Storing two values is a form of eagerly caching that calculation of minutes to
hours and minutes. Every time you do a math operation on the two clocks, you
have to go through and re-adjust the hours and minutes even if you never need to
convert to a human-readable format.

The advantage you get with this approach though is that if you're rendering the
human readable version very frequently you aren't calculating every time but can
rely on the cached value.

### Immutability

Students will often mutate in `+` and `-` instead of returning a new instance of
`Clock`. While this passes the tests, it can easily lead to bugs in client code
like:

```ruby
start_time = Clock.new(hour: 10, minute: 30)
duration = Clock.new(hour: 1, minute: 30)

# one hour and thirty minutes later...
end_time = start_time + duration

puts "Event duration: #{start_time.to_s} - #{end_time.to_s}"
```

mutable clock returns

> Event duration: 12:00 - 12:00

immutable clock returns

> Event duration: 10:30 - 12:00

[Value objects](https://www.sitepoint.com/value-objects-explained-with-ruby/)
like `Clock` should almost always be immutable to prevent this sort of bug.
Bonus points if you `#freeze` in the constructor.

### modulo vs remainder

**modulo (%)** is a sort of circular math. Doing modulo with a negative number can
be thought of as moving backwards on a clock with `n` ticks on it. The value
returned will _always_ be positive.

**remainder** is the classic "do integer division and give me what's left that
didn't divide cleanly". This number _can_ be negative if one of the inputs is
negative.

```ruby
# modulo
  57 % 60 # => 57
 117 % 60 # => 57
 -57 % 60 # => 3
-117 % 60 # => 3

# remainder
  57.remainder 60 # =>  57
 117.remainder 60 # =>  57
 -57.remainder 60 # => -57
-117.remainder 60 # => -57
```

### Invalid states

Clocks represent a "time of day" value which should always be less than a day's
worth of time. Discuss why storing more time should be invalid. Discuss what it
means to allow invalid states. What are the consequences? Why is it bad? How can
we avoid it?

### Method visibility

Discuss `public` vs `protected` vs `private`. Value objects often expose their
internal values as protected attributes.

### Human vs computer representations

Often it's easier to do operations on data in one form but easier for humans to
read it in a different form. The following pattern:

1. Take input in human form, convert it to internal representation
2. Do operations on internal representation
3. Convert to human-friendly form when displaying result

is very common in software. Discuss the difference between human representation
of data and data that is easy to work with.

