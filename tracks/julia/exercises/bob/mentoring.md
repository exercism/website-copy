# Mentoring notes

## Example solutions

There are a few solutions to this problem.
It is probably clearest to separate the checks for silence, yelling, and questioning out and give them descriptive names.

````

[4d47's very readable solution](https://exercism.io/tracks/julia/exercises/bob/solutions/bad626f50f3d46999305e1db5d6c8c78)

```julia
function bob(stimulus)
    s = strip(stimulus)
    silence = isempty(s)
    question = endswith(s, '?')
    yelling = s == uppercase(s) && any(isuppercase, s)

    if yelling && question
        "Calm down, I know what I'm doing!"
    elseif yelling
        "Whoa, chill out!"
    elseif question
        "Sure."
    elseif silence
        "Fine. Be that way!"
    else
        "Whatever."
    end
end
```

[cmcaine's solution](https://exercism.io/tracks/julia/exercises/bob/solutions/3f88ebf58eca47fe98c2bc5f20823e45)

```julia
"""
    bob(stimulus)

Bob's lackadaisical response to `stimulus`.

"""
function bob(stimulus)
    is_silence() = all(isspace, stimulus)
    is_yelling() = !any(islowercase, stimulus) && any(isuppercase, stimulus)
    is_question() = last(rstrip(stimulus)) == '?'

    if is_silence()
        "Fine. Be that way!"
    elseif is_yelling()
        if is_question()
            "Calm down, I know what I'm doing!"
        else
            "Whoa, chill out!"
        end
    elseif is_question()
        "Sure."
    else
        "Whatever."
    end
end
```

The author says:

Some work can be repeated (`isspace` will be called by both `is_silence` and `rstrip`, and `is_question()` can be called twice), but I like how the work is clearly split into three simple predicates and that there are no intermediate variables.

This function avoids copying the string at any point, too, which is nice for performance.
````
