# Mentoring

This is a great opportunity to prepare for the track with attention to style conventions.
This is currently the first reviewed problem on the Perl track, and serves to
make sure the student understands unit testing and Test Driven Design.

## Reasonable Solutions

```perl
package TwoFer;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(two_fer);
sub two_fer {
    my $name = shift || "you";
    return "One for $name, one for me.";
}
1;
```

```perl
package TwoFer;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(two_fer);
sub two_fer {
    return "One for " . (shift || "you") . ", one for me.";
}
1;
```

```perl
package TwoFer;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(two_fer);
use experimental qw(signatures);
sub two_fer ($name = 'you') {
    return "One for $name, one for me.";
}
1;
```
But remember TMTOWDI - There's More Than One Way To Do It!

## Common Suggestions

- Suggest using a default value instead of any form of conditionals.
- If the student is using perl 5.2>, suggest using the `experimentals` module but make them aware that they're unlikely to find that particular pattern in the wild.
- If the student is using perl <5.2, suggest upgrading to get new features - but, again, make them aware that not every situation they might walk into is going to be running the latest version
- Some people need help with running the tests.
- Check indentation.
- Printing vs. returning

## Talking Points

- Default values
- String interpolation
- Style preferences. This exercise is a good opportunity to talk about style conventions like indentation, parameter parenthesis in method declarations (if using `experimental`) and removing redundant comments.
  Given the place in the curriculum it may be worth not going too deep and to not address points that are controversial or personal preference.
- Unit Tests. For some students this will be an introduction to the notion of unit tests.
  Make the case that these allow them to be productive while engaging with the problem.

## Mentoring Notes

A friendly standard answer about how this can be done in one line, and a 'hint: use a different default value' to get rid of the conditionals, will be all you need for maybe 90% of the submissions.
For another 5% of the submissions you will need to go into detailed instructions.
You might start with some questions:
Do they know how to run the tests?
Some users may have trouble running pytest due to path issues.
Get them to paste you any error messages in another iteration (and remind them they can do as many iterations as they want!!) then talk them through

```shell
$ cd path/to/dir/
prove .
```

or 

```shell
    $cd path/to/dir
    prove -v .
```

For a bit more information.

Do they understand what the tests tell them? Importantly, do they understand how the information is getting fed to them via `__DATA__`? They're going to need to understand that, and JSON itself, before they can totally understand what's happening.

### Editing the Tests

You will see students who modify the tests to get them to pass.
You should explain the function and importance of the tests.

### Test Driven Thinking

The submission below passes all the tests, but misses the point a little in that it doesn't cover what happens if a new name is added to the tests.
Ask what happens when Carol and Doug show up.

```perl
def two_fer {
    if name == 'Alice' {
        return 'One for Alice, one for me.';
    }
    elsif name == 'Bob' {
        return 'One for Bob, one for me.';
    }
    else:
        return 'One for you, one for me.'
```
