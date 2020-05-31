## Mentoring notes

The main point of this exercise is to learn about mutable structs and to reinforce the idea of writing methods for your own types.
But there's also some trickyness in the problem, too.

Julia things to get right

- fields should have explicit types (structs with `Any` fields are slower, ref Julia performance guide)

Solutions should ideally give an error if they run out of names (instead of looping forever or issuing duplicate names).

There are broadly three ways of solving this (in ascending goodness):

1. Generate a random name, but don't worry about collision at all
2. Generate a random names until you get one that you haven't seen before
3. Generate a random names until you get one that you haven't seen before, but give up if there are no names left to find
4. Generate and shuffle the names in advance, then just iterate that collection

Solutions that store previously issued names in a collection should probably use an efficient collection.
If you're looking for a string, then searching a vector of strings is pretty slow, so prefer `Set()`.

Option 4 uses a lot of memory if you store them in a vector of strings (1x 64 bit pointer and a 5 byte string + String overhead for each name).
You can cut that significantly by storing integers instead (1x 32bit int per name) or by storing one long string and indexing into it (40 bits per name).

Options 2 and 3 need special consideration to make them not take a very long time as names run out, encourage the student to think about this, if they don't seem to have already.
There's some basic stats you can do:

    Probability of finding last name with N guesses =
      1 - ((676000 - 1) / 676000)^N


## Example code

````
```julia
# Scott P Jones' solution as reinterpreted by Colin Caine

using Random: shuffle!

# Use Int32 to save some bits because this is quite a big vector.
const names = shuffle!(Int32[0:26^2 * 10^3 - 1;])

mutable struct Robot
    # Robots are comfortable with integer names ;)
    id::Int32
    Robot() = new(mint_id())
end

function mint_id()
    isempty(names) ? error("No unique identifiers left!") : pop!(names)
end

"Convert an integer name to a human-friendly name"
function id2name(id)
    id, c1 = divrem(id, 26)
    id, c2 = divrem(id, 26)
    id, d1 = divrem(id, 10)
    id, d2 = divrem(id, 10)
    d3 = id
    return join((Char('A' + c1),
                 Char('A' + c2),
                 string.((d1, d2, d3))...))
end

function reset!(instance::Robot)
    instance.id = mint_id()
    instance
end

function name(instance::Robot)
    id2name(instance.id)
end
```
````
