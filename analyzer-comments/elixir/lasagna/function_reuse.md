# function reuse

Proper function reuse is crucial to writing maintainable code.

Reuse existing functions:
- `remaining_minutes_in_oven/1` should call `expected_minutes_in_oven/0`
- `total_time_in_minutes/2` should call `preparation_time_in_minutes/1`
