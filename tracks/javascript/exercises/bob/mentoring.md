# Mentoring

This exercise explores string testing:
- `RegExp`
- `String` index accessor

### Reasonable solutions

This exercise can be approached with regular expressions, using the `String`
prototype, or a combination of both. Below are concise solutions for either but
combinations are valid too, as long as they make sense:

- `isSilence`: Has no letters, digits or punctuation (ignoring whitespace).
- `isShouting`: All letters are uppercase, and there is at least one letter.
- `isAsking`: Ends with a question mark (ignoring whitespace).

#### Regular expressions
```javascript
const isSilence = message => /^\s*$/.test(message)
const isShouting = message => /^[^A-Za-z]*[A-Z]+(?:[^a-z]*)$/.test(message)
const isAsking = message => /\?\s*$/.test(message)
```

#### String prototype
```javascript
const isSilence = message => message.trim() === ''
const isShouting = message => message.toUpperCase() === message && message.toLowerCase() !== message
const isAsking = message => message.trim().endsWith("?")
```

#### Composition
```javascript
export const hey = (message) => {
  if (isSilence(message)) {
    return 'Fine. Be that way!'
  }

  if (isShouting(message)) {
    return isAsking(message)
      ? "Calm down, I know what I'm doing!"
      : 'Whoa, chill out!'
  }

  return isAsking(message)
    ? 'Sure.'
    : 'Whatever.'
}
```

Instead of ternaries, nested if statements are fine, as is a `switch` with each
case the evaluation of the rule. A student may also evaluate `isShouting` and
`isAsking` into a variable and check the result afterwards.

Alternatively a student can compose the rules before and iteratively check them:
```javascript
  const checklist = [{ rule: isSilence, response: 'Fine. Be that way!' }]

  ...

  checklist.forEach((item) => {
    if (item.rule(message)) {
      return item.response
    }
  })

  return 'Whatever'
```

#### Note about earlier versions
The response `"Calm down, I know what I'm doing!"` was added later and earlier
solutions did not require nesting of the tests. The extra response makes it
more interesting in some languages, but in JavaScript it doesn't.

### Common suggestions
- If a student uses the complicated `RegExp` of `isShouting`, discuss its use over a simpler `message.toUpperCase() === message && /A-Z/.test(message)` which checks if there is at least one letter.
- If a student uses the correct `RegExp` but does _not_ use the `^` or `$` boundaries, explain how we're trying to match the entire message and not part of it. The tests won't raise a false positive, but other input might.

### Talking points
- If a student does not use regex, this is a good opportunity to introduce them, but it should not be a requirement for approval. Suggest to simplify solution without regex as much as possible, approve it and then optionally ask the student to try using regex if interested.
