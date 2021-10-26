# Mentoring

## Phone Number

The problem asks you to write a `PhoneNumber` class.
The constructor takes an input string that may or may not contain a valid number.
The constructor needs to validate the number.
The `pretty()` method needs to return a formatted number.

## Reasonable Solution

```python
class Phone:
    """Phone number validator."""

    def __init__(self, number: str):
        """Load and clean a number, validating it."""
        # Ignore all non-digits.
        digits = ''.join(i for i in number if i.isdigit())

        # For an 11-digit with country code, drop the country code.
        if len(digits) == 11 and digits.startswith('1'):
            digits = digits[1:]

        if len(digits) != 10:
            raise ValueError('Invalid number')

        self.number = digits
        self.area_code = digits[0:3]
        self.exchange = digits[3:6]
        self.subscriber = digits[6:10]

        for invalid in ('0', '1'):
            for check in (self.area_code, self.exchange):
                if check.startswith(invalid):
                    raise ValueError('Invalid number')

    def pretty(self) -> str:
        """Return a pretty string of the number."""
        return f'({self.area_code}) {self.exchange}-{self.subscriber}'
```

## Talking Points

### Transforming the number

Transforming 11-digit numbers with a "1" country code to a 10-digit number without the leading "1" makes the logic much simpler.
The sooner the country code is removed, the simpler the rest of the validation logic.

### Regular Expressions

Non-digits can be removed using a regular expression: `"".join(re.findall(r"[0-9]", number))`.
However, using a regular expression is overkill for this; strings have all the methods you need to remove non-digits.
`digits = ''.join(i for i in number if i.isdigit())`
