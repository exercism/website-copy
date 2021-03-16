# Mentoring

## Mentoring notes

The main point of this exercise is to learn about mutable structs and to reinforce the idea of writing methods for your own types.
But there's also some trickyness in the problem, too.

Julia things to get right

- fields should have explicit types (structs with `Any` fields are slower, ref [Julia performance guide](https://docs.julialang.org/en/v1/manual/performance-tips/index.html))

Solutions should ideally give an error if they run out of names (instead of looping forever or issuing duplicate names).

There are broadly four ways of solving this (in ascending goodness):

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

# We shuffle all possible robot names in advance so that we can issue them in
# constant time.
#
# Robot names are expressed as integers because there's quite a lot of them and
# this saves over 100 bits per name compared to storing a pointer (64 bits) to
# a 5 character string (40 bits + length metadata).
const names = shuffle!(Int32[0:26^2 * 10^3 - 1;])

mutable struct Robot
    id::Int32

    """
        Robot()

    Construct a robot with a unique name within its class.
    """
    Robot() = new(mint_id!())
end


"""
    mint_id!()

Return a unique robot id. If there are none left, error.
"""
function mint_id!()
    isempty(names) ? error("No unique identifiers left!") : pop!(names)
end


"""
    reset!(instance::Robot)

Factory-reset this robot, assigning it a new unique name.
"""
function reset!(instance::Robot)
    instance.id = mint_id!()
    instance
end


"""
    id2name(id)

Convert an integer name to a human-friendly name.
"""
function id2name(id)
    id, c1 = divrem(id, 26)
    id, c2 = divrem(id, 26)
    id, d1 = divrem(id, 10)
    d3, d2 = divrem(id, 10)
    return join(('A' + c1,
                 'A' + c2,
                 d1, d2, d3))
end


"""
    name(instance::Robot)

Return this robot's name.
"""
function name(instance::Robot)
    id2name(instance.id)
end
```
````

The solution above generates the names and shuffles them in advance,
which is the key concept for a constant-time solution.
One issue with this technique is that the pregenerated names use quite a lot of memory if you encode them as strings,
fortunately, we can reduce the memory footprint by encoding the names differently.

While this particular technique probably won't transfer to many other problems,
it is often useful to consider the tradeoffs of different ways of representing information.

Converting names to integers and back again might seem tricky at first.
A decent intuition is that the names are a number, but in an inconsistent base.
Just as 153 is 3 + 5 * 10 + 1 * 100,
"AC5" could be interpreted as a number with two digits in base 26 and one in base 10:
0 + 2 * 26 + 5 * 26 * 10
(I'm interpreting 'A' as 0 here, and I'm treating the number as little-endian, both are arbitrary choices).

Worked example:

````
```julia
name = "AB123"
tup = (0, 1, 1, 2, 3)
int = 0 +
      1 * 26 +
      1 * 26^2 +
      2 * 26^2 * 10 +
      3 * 26^2 * 10^2
```
````

You can convert the integers back into a name by repeated division:

````
```julia
"""
    id2name(id)

Convert an integer name to a human-friendly name.
"""
function id2name(id)
    id, c1 = divrem(id, 26)
    id, c2 = divrem(id, 26)
    id, d1 = divrem(id, 10)
    d3, d2 = divrem(id, 10)
    return join(('A' + c1,
                 'A' + c2,
                 d1, d2, d3))
end

# and the inverse
function name2id(name)
    id = name[1] - 'A'
    id += (name[2] - 'A') * 26
    id += parse(Int, name[3]) * 26^2
    id += parse(Int, name[4]) * 26^2 * 10
    id += parse(Int, name[5]) * 26^2 * 10^2
    id
end
```
````
