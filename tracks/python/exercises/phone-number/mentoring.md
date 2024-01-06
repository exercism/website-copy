# Mentoring

## Phone Number

The problem asks you to write a `PhoneNumber` class.
The constructor takes an input string that may or may not contain a valid number.
The constructor needs to validate the number.
The `pretty()` method needs to return a formatted number.

## Reasonable Solution

```python
import re

class PhoneNumber:
    def __init__(self, input_number_str: str):
        self.number = self._clean_nanp(input_number_str)
        self.area_code = self.number[:3]

    def pretty(self) -> str:
        """Return phone number in the format (XXX)-XXX-XXXX"""
        return f"({self.area_code})-{self.number[3:6]}-{self.number[6:]}"

    def _clean_nanp(self, number_str: str) -> str:
        number_str = re.sub(r'[^\d]', '', number_str)  # Remove all non-digit characters

        def check_length(number_str):
            if len(number_str) < 10:
                raise ValueError("Number must not be fewer than 10 digits")
            if len(number_str) == 11 and number_str[0] != '1':
                raise ValueError("11 digits must start with 1")
            if len(number_str) > 11:
                raise ValueError("Number must not be greater than 11 digits")

        def check_start_chars(number_str):
            if number_str[0] in ('0', '1'):
                raise ValueError("Area code cannot start with 0 or 1")
            if number_str[3] in ('0', '1'):
                raise ValueError("Exchange code cannot start with 0 or 1")

        # Validation checks
        if re.search(r'\D', number_str):
            raise ValueError("Letters and punctuations not permitted")
        check_length(number_str)
        check_start_chars(number_str)

        return number_str
```

## Talking Points

### Transforming the number

Transforming 11-digit numbers with a "1" country code to a 10-digit number without the leading "1" makes the logic much simpler.
The sooner the country code is removed, the simpler the rest of the validation logic.

### Regular Expressions

Non-digits can be removed using a regular expression: `"".join(re.findall(r"\d", number))`.
However, using a regular expression is overkill for this; strings have all the methods you need to remove non-digits.
`digits = ''.join(i for i in number if i.isdigit())`
