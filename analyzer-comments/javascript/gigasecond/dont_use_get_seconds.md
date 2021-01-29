Use [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime)
to get the number of milliseconds the _entire_ `Date` represents, instead of
getting the `seconds` component of the `Date`. In general, [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time),
as provided by `Date#getTime`, is preferred when dealing with dates, as it is
not affected by _interpretation_ or locale (such as timezones), and it allows
for date manipulation without needing to rely on roll-over, which, for example, occurs when the seconds components is larger than 60, and adds one to the minute component.
