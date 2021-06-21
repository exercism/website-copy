# Become a maintainer

The Exercism language tracks are a great way to get involved in:

- A programming language you love.
- A programming language you're curious about.
- Open source (in general).

Each language track lives in its own repository, which means that you can contribute
to a track without having to know anything about the rest of the Exercism ecosystem.

Also, each track is focused, containing implementations of trivial exercises and the tools
to make development easier, so there's no big codebase to get acquainted with.

**The journey to becoming a maintainer starts with contributing to a track to demonstrate your interest, knowledge and ability.** Once you have been an active contributor for a while, then please reach out to the existing track maintainers if you would like to become a maintainer too :)

## Submit a couple of solutions

If you haven't used Exercism before, then we recommend first submitting solutions to a couple of
exercises. It doesn't matter which language track you submit to, it's just to get a feel
for what a language track consists of.

## Watch the track repository

If you haven't picked a language you want to contribute to yet, check out the list of [language tracks][tracks]
and their respective [repositories][repositories].

Then go to the repository for the language you've chosen, click the _Watch_ button, and select _Watching_.
This will notify you of any new issues, pull requests, or comments in the repository, which is a great way
of getting acquainted with the people involved and the issues that tend to come up.

## Orient yourself

Read the README, and look through the open issues and pull requests, and get a feel for what's going on.

## Contribute!

There are a number of ways to contribute to a track. All of them are sorely needed, and greatly appreciated!

### Triaging issues

A great issue is detailed and actionable. When they're not, you can help ask the questions to make them so.

For more detailed suggestions about things to keep in mind when triaging, check out [this documentation][triaging-issues].

### Reviewing pull requests

We always need more eyeballs on pull requests. On language tracks most pull requests tend to be related to
the exercises themselves, and we have [detailed documentation][reviewing-prs] that should help
you get started with code reviews.

### Porting an exercise

The easiest way to add a new exercise is to find an exercise that has already been implemented in another language
track, and port it over to your target language.

We've got [a guide][porting] that walks you through how to find an exercise to port, and the things to
keep in mind when implementing it.

### Improving the contributing documentation

It's not always obvious how to get started contributing to a language track. As you get involved, help improve the
README in the track repository.

- Are there undocumented dependencies?
- How do you run the tests? Is there a way to run all the tests for all the exercises?
- Are there any naming conventions for files or types or classes or functions?
- Is there any tooling that we're using? Linters?
- Is there continuous integration? Are there any gotchas?

## Improving the curriculum

As you solve exercises on the site, pay attention to what you like and dislike
about the exercises.

### Improving exercise READMEs

If the README is ambiguous or confusing, then there's almost certainly
something we can do to clarify.

Or maybe you found a typo (you wouldn't be the first).

The READMEs are generated, and all the details are explained [here][fixing-readmes].

### Changing exercise test suites

- Did the test suite force you towards a certain solution? (It shouldn't.)
- Did you come across a solution that passed the tests, but that had a bug?
  (Maybe we're missing a test case.)

The test suite is straight forward to find: look in the `exercises`
directory in the language track repository for the directory named after the
slug of the exercise. The test file will be right there.

That said, some test suites are generated based on the `canonical-data.json`
file found in [problem-specifications][]. The README for the language track repository
should tell you what you need to know.

For every change that you make to the test suite, ask yourself: **Should this
change also affect other language tracks that implement the same exercise?**

If you think it might, open a discussion in the [problem-specifications][] repository and get
other track implementors' feedback on the subject.

If this change should affect the broader Exercism curriculum, then use the
issue in [problem-specifications][] to:

- Hash out all the details together.
- Figure out the necessary changes to the `canonical-data.json` for the
  exercise (if it exists).
- Draft an issue that can be submitted to all the tracks that implement the
  exercise using the [blazon][] tool (which automates the tedious parts).
  More about that [here][blazon-process].

### Reordering exercises

We don't have a formal process for deciding how the exercises should be
ordered, and often as we add more exercises, we get some less-than-optimal
sequences of exercises.

As you work through the exercises in the track, notice whether an exercise
seems vastly more difficult than the previous one, or much easier, or boring.

The order is decided by the `exercises` array in `config.json`.

- If it's **too easy**, move it higher up in the array.
- If it's **too hard**, move it further down in the array.
- If two exercises are **too similar** then move one of them so that there are
  some different exercises between them.

We can also deprecate an exercise by removing it from the `exercises` array
and adding the slug to the `deprecated` key, which is also in the
`config.json` file.

### Adding hints

Sometimes an exercise is in the right place in the sequence, but it's really
hard to figure out how to solve it anyway.

In this case consider whether there's a blog post or some documentation that
you could point people to, and add it to `$ROOT/exercises/$SLUG/.meta/hints.md` in the exercise directory
in the language track. If the file doesn't exist, create a new one.

[tracks]: https://exercism.io/tracks
[repositories]: https://github.com/exercism
[triaging-issues]: https://github.com/exercism/legacy-docs/blob/main/you-can-help/triage-issues.md
[reviewing-prs]: https://github.com/exercism/legacy-docs/blob/main/you-can-help/review-pull-requests.md
[porting]: https://github.com/exercism/legacy-docs/blob/main/you-can-help/implement-an-exercise-from-specification.md
[problem-specifications]: https://github.com/exercism/problem-specifications
[blazon]: https://github.com/exercism/blazon
[blazon-process]: https://github.com/exercism/legacy-docs/blob/main/you-can-help/improve-exercise-metadata.md
[fixing-readmes]: https://github.com/exercism/legacy-docs/blob/main/language-tracks/exercises/anatomy/readmes.md
