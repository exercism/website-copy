# prefer side effect free date

Use [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime)
and [`new Date(value)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date#Syntax),
which takes a number of milliseconds as `value` and constructs a _new_ date.
This ensures the _input_ is not modified when calling `gigasecond`, which
also means that there are no unintended side-effects.

In general, [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time),
as provided by `Date#getTime`, is preferred when dealing with dates, as it is
not affected by _interpretation_ or locale (such as timezones), and it allows
for date manipulation without needing to rely on _roll-over_ (as `setSeconds`
rolls over anything above 60 to the next minute and so forth).
