# Mentoring

- prefer `isdigit` to `isnumeric` when you want to match only the western arabic numerals.
- regex is fine
- you can use higher-order-functions like `filter` and `map` on strings

**Example solutions**

A simple procedural solution. We filter the string so that it only contains digits, remove a leading 1 if the string is exactly 11 chars long, then check that the first and fourth digits are in the right range.

```julia
function clean(phone_number)
    x = filter(isdigit, phone_number)
    if length(x) == 11 && x[1] == '1'
        x = x[2:end]
    end
    if length(x) == 10 && x[1] in '2':'9' && x[4] in '2':'9'
        x
    else
        nothing
    end
end
```


And here's a more declarative solution using a regex.
If you can read regex, this is probably easier to understand than the first and easier to prove that it is correct.

```julia
function clean(phone_number)
    m = match(r"^1?([2-9]\d\d[2-9]\d{6})$", filter(isdigit, phone_number))
    m === nothing ? m : m.captures[1]
end
```
