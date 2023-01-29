# signature not optimal

If you look at the tests, the function `value` only receives one parameter
There is no need for a second parameter - its value will always be`undefined`
(or whatever default you've assigned).
