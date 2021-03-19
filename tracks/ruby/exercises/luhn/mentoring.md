# Mentoring

_Luhn_ is the last of the 'mid-level' exercises. It can be solved quite sophisticated; however, the minimal solution for approval is a variant with an instantiated class.

## Minimal Solution for Approval

```ruby
class Luhn
  def self.valid?(candidate)
    new(candidate).valid?
  end

  def initialize(candidate)
    @candidate = candidate.delete(' ')
  end

  def valid?
    return unless valid_format?

    (luhn_sum % 10).zero?
  end

  private
  attr_reader :candidate

  def valid_format?
    candidate.size > 1 && candidate !~ /\D/
  end


  def luhn_sum
    candidate.to_i.digits.each_slice(2).sum do |first, second|
      first + digit_sum_of_doubled(second.to_i)
    end
  end

  def digit_sum_of_doubled(number)
    (number * 2).digits.sum
  end
end
```

## Reasonable variants

Well, this is Ruby, and almost everything can be done in several ways. Make sure to acknowledge the student's own preferences (given that's idiomatic Ruby).
* _guard clause_: variants of `valid_format?(...) && valid_luhn_sum?(...)`
* `chars` in the initializer, `reverse` in the luhn_sum calculation
* `divmod(10).sum` instead of `digits.sum`; I usually save one of those as a final give-away to get rid of a ternary :-)
* _advanced_ Most suitable as a follow up after the instantiated class is thoroughly refactored first. Don't go here except with students who demonstrate advanced Ruby fluency. (TODO: add notes.)

```ruby
# Class with class methods or a Module with extend self or module_function
def self.valid?(candidate)
  return unless valid_format?(candidate.delete(' '))
  candidate.delete(' ')
    .to_i
    .digits
    .yield_self(&method(:luhn_sum))
    .modulo(10)
    .zero?
end

...
```
* _advanced_ Seperate concerns in classes (input format, luhn_sum) (TODO: add notes) This is not the same as adding a LuhnValidator class.

## General

For over 50% of the solutions I have seen, the 'Instantiated Class' variant is _not_ a straightforward solution. Don't underestimate its learning potential.
In the 'Instantiated Class' variant, almost every concept has been addressed in the preceding exercises; putting them all together, and recognizing them in the first place, turns out to be a challenge for the majority of the students. It pays off to involve those earlier exercises in your feedback.

## Mentoring Strategy

_First iteration: start with feedback on general design and pointing to Enumerable for the Luhn Calculation_
* When people start with a Class and one Giant Class Method: start with just a suggestion to instantiate, without going into details.
* When they don't use `each_slice`, I point them to the Series exercise "for inspiration on a similar solution".  I don't give them `each_slice`.
* If both of these ^ points are relevant, I put them both in the first comment. And nothing else.

_Next iterations:_
* First focus on (how to) Instantiating the Class, Organisation with extracted methods, main parts of solving the Luhn calculation.
* Not going into (syntax) details that doesn't affect the main logic.

_When that is finished_
* Smaller refactorings, Ruby sweetness and implementation details


## Common suggestions
* _Instantiating the class from a class method:_ When they don't know how, direct them to their Scrabble Score.
* When people start with a Class and one Giant Class Method: start with a suggestion to instantiate. See Mentoring Strategy.
* (I) Don't give `each_slice` away; I refer to the Series exercise instead "for inspiration on a similar solution".
At this point in the track, a hint should be enough to point them in the right direction. (But no reason to frustrate them;
I do give them the method (or point to the Enumberable#each_* bunch) when they don't find it.)
If they don't get it to work, I invite them to go through their Series together first.
* Pay attention to the concepts that are introduced in the exercises that preceded Luhn;
the value of Luhn is also that it requires students to use the things that they practiced in a much simpler 'environment' before.

## Talking points

* _Extracting methods_, and _the order of methods._ The Minimal Solution above is at the maximum of the acceptable number of extracted methods. In a Luhn class, does the Luhn calculation deserve its own method?
* _Handle spaces_:
  - Spaces in the input are not invalid, they just don't mean anything for validation.
  - How to get rid of them? Be aware of introducing untested behaviour (`gsub(/\s+/, "")`).
* _guard clause_: Why the guard clause should be in the instance method `valid?`, not in the class method `valid?`.
* _String to integers:_ Only if they use `chars.reverse.map(&:to_i)` in one step, point to `Integer#digits`
* _regex:_ anything more complex than `\D`, store it in a (private) Constant.
* `> 9` and `<= 1` and `10`: address the 'magic number's and when to [refactor](https://refactoring.guru/replace-magic-number-with-symbolic-constant). For `9`: it's not about numbers > 9, but rather < 10 (the 9 probably comes from the example for calculating the doubled value in the Instructions).
* `nil.to_i` (for handling `nil * 2` if the second element of the slice is nil). Other solutions possible; but avoid adding an extra check to return `0` for `nil` in a doubling method.
* _Naming things_: Luhn offers a great opportunity to talk about naming things.
  - _parameter_: the class can handle all kind of strings of numbers, not just card_numbers or identification numbers.
  - `checksum` for `luhn_sum`: in the world of Luhn, the checksum is the last number; what do we expect a checksum method to do?
  - `valid_format?` vs `invalid_format?`: When people extract the validation conditionals into a method, it's more often into a method with a negated name like `if invalid_format ...`.
* Monkey Patching: some people implement `evenly_divisible_by` in Integer. Talk about the risks of monkey patching and talk about refinements. [link](https://spin.atomicobject.com/2017/12/29/monkey-patching-refinements)

## Mentor Research Notes

* `String@delete`: `.delete("\s")` does remove the space character `' '`, but not the regex `\s` characters like `\n` etc.

## Changelog

Test data version 1.4.0 : Dec 2018
