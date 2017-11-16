# Contributing to the Exercism CLI installation walkthrough

First off all, thank you for taking the time to contribute!

# Table of Contents

* [Code of Conduct](#code-of-conduct)
* [Setting up your local development environment](#setting-up-your-local-development-environment)
* [Submitting Code Changes](#submitting-code-changes)
    - [Git Workflow](#git-workflow)
    - [Issues](#issues)
    - [Pull Requests](#pull-requests)
    - [Development Workflow](#development-workflow)

## Code of Conduct

Help us keep exercism welcoming. Please read and abide by the [Code of Conduct][coc].

## Setting up your local development environment

1. Clone the repository.

```
$ git clone https://github.com/exercism/interactive-cli-walkthrough
```

2. Inside the repository's directory, run the following command:

```
$ bundle
```

## Submitting Code Changes

These instructions should get you closer to getting a commit into the
repository.

### Git Workflow

1. Fork and clone.
1. Add the upstream interactive-cli-walkthrough repository as a new remote to your clone.
   `git remote add upstream https://github.com/exercism/interactive-cli-walkthrough.git`
1. Create a new branch
   `git checkout -b name-of-branch`
1. Commit and push as usual on your branch.
1. When you're ready to submit a pull request, rebase your branch onto
   the upstream master so that you can resolve any conflicts:
   `git fetch upstream && git rebase upstream/master`
   You may need to push with `--force` up to your branch after resolving conflicts.
1. When you've got everything solved, push up to your branch and send the pull request as usual.

### Issues

We keep track of bugs, enhancements and support requests in the repository using GitHub [issues][].

### Pull Requests

When submitting a pull request, sometimes we'll ask you to make changes before
we accept the patch.

Please do not close the first pull request and open a second one with these
changes. If you push more commits to a branch that you've opened a pull
request for, it automatically updates the pull request.

When the pull request is ready to be merged, you will probably be asked to [squash your commits][squash-commits].

As with adding more commits, you do not need to close your pull request and open a new one.
If you change the history (rebase, squash, amend), and use git push --force to update the branch on your fork.
The pull request points to that branch, not to specific commits.

Here's a guide on [how to squash commits in a GitHub pull request][squash-commits].

When submitting a PR, please make sure to include the compiled HTML and the
newly generated instruction graph in order for your changes to appear on the
live site.

#### Compiling to HTML

In order to compile to HTML, run the following command:

```
$ twee2 build main.tw2 compiled.html --format=Snowman
```

#### Generating the instruction graph

In order to generate the instruction graph, run the following command:

```
$ rake graph
```

### Development workflow

The walkthrough is written in Markdown. In order to get a hang of the syntax,
please read this [tutorial][markdown].

#### Additional commands

Aside from the commands listed above, additional commands were added in order
to setup links through each step easier.

The first command follows this syntax: `[[<Link Text>-><Link Destination>]]`

This creates a link with `Link Text` that links to a page named `Link Destination`.

The second command follows this syntax: `::Link Destination`

This sets a file's name as `Link Destination`. This is needed in order for the
link command to know what page to link to.

#### Compiling

In order to view your changes compiled to HTML, compile using the ff command:
`twee2 build main.tw2 compiled.html --format=Snowman`

#### Generating the instruction graph

In order to aid you with the overall structure of the guide, you can
generate a graph of the pages by using the ff command: `rake graph`

This generates a `graph.png` file that you can open.

#### More information

For more guidance, you are free to peek into how the installation
instructions for Mac were written.

[coc]: https://github.com/exercism/exercism.io/blob/master/CODE_OF_CONDUCT.md
[squash-commits]: http://blog.steveklabnik.com/posts/2012-11-08-how-to-squash-commits-in-a-github-pull-request
[issues]: https://github.com/exercism/interactive-cli-walkthrough/issues
[markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
