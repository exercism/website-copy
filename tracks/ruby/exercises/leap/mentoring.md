_Leap_ is one of the first side exercises, unlocked by _TwoFer_. 

## Reasonable Solutions

```ruby
class Leap
  def self.leap?(year)
    year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  end  
end
```
Variants: `module` instead of `class`; instantiate class.  

It's tempting to extract a method for `year % number == 0`, but we don't want the discussion about avoiding private class methods at this stage in the track. However, if the class is instantiated, extracting such a method is reasonable.    

## Common suggestions
Copied from the Python notes by @yawpitch :
- There are just two cases that return true:
  - a year is a multiple of 4 *and not** 100
  - a year is a multiple of 4, 100, and 400
- _Order of operations_ matter:
  - 75% of all years *cannot* be leap years because they are not multiples of 4; test `year % 4 == 0` first
  - 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 != 0` second
  - 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 == 0` third
- _Order of evaluation_ matters:
  With Ruby's logical operator precedence in `year % 4 == 0 && year % 100 != 0 || year % 400 == 0`, a year that's not evenly divisible by 4 will not be evaluated for `% 100` but will jump to the evaluation of `% 400`.
- Eliminate duplicate work; no year should ever have to be checked multiple times for the same condition

## Talking points
* Parentheses: discuss Ruby's logical operator precedence 
* Logical operators `&&` `||` are more idiomatic than `return ... if ...`. 
* Moreover, solutions with `return... if...` most likely start with evaluating `% 400` first instead of last.
```ruby
return true if 0 == year % 400
return false if 0 == year % 100
return true if 0 == year % 4
false
```


