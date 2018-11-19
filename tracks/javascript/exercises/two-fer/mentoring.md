The point of this exercise is to get them going after the "hello-world" exercise, create a file (by checking the test) and figuring out how to work the `.spec` files.

### Reasonable Solutions
There are many reasonable solutions, here are a few:

- Solution using "falsy" and string interpolation:
  ```javascript
  export const twoFer = (name) => `One for ${name || 'you'}, one for me.`
  ```

- Solution using re-assignment
  ```javascript
  export function twoFer(name) {
    if (name == '') {
      name = 'you'
    }

    return 'One for ' + name + ' one for me.'
  }
  ```

### Common suggestions
* String interpolation using backtick (\`) strings
* Variable re-assignment if the student doesn't construct the result

### Talking points
* There are no test cases specifically handling `undefined` or `null`, so you don't need to instruct them to handle the input as being falsy/truthy. It is common for a student to not know how this works in JavaScript.
* There are no test cases around handling other types than strings, but you can point it out if they use `==` instead of `===`. At this moment in the track it's common for a student to not know the difference.
