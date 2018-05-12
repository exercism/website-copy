# Contributing to the Exercism CLI installation walkthrough

First off all, thank you for taking the time to contribute!

# Table of Contents

* [Code of Conduct](#code-of-conduct)
* [What is the walkthrough?](#what-is-the-walkthrough?)
* [How can I help?](#how-can-i-help?)
* [How do I start contributing?](#how-do-i-start-contributing)
* [Submitting Code Changes](#submitting-code-changes)
    - [Git Workflow](#git-workflow)
    - [Issues](#issues)
    - [Pull Requests](#pull-requests)
    - [Development Workflow](#development-workflow)

## Code of Conduct

Help us keep exercism welcoming. Please read and abide by the [Code of Conduct][coc].

## What is the walkthrough?

### Background

Looking at the data, we noticed that a significant number of users have never
completed a single exercise on exercism. We believe this is because setting it up
isn't easy. This walkthrough aims to solve that.

The goal of the walkthrough is to guide users through the many steps of
installing the Exercism command-line client (CLI), which is a prerequisite to
doing exercises on the site.

### Structure

The walkthrough is structured in the following way:

1. To prevent users from getting lost, the walkthrough is a step by step guide.
1. At the end of each step, the user must be able to confirm whether they've
done the step correctly. This should prevent users from installing incomplete
packages which may lead to harder troubleshooting in the future.
1. When the user encounters a problem during a step, the user should be given
steps to self-diagnose or troubleshoot the problem on their own.

## How can I help?

You can help by:

1. Giving feedback on the walkthrough. In particular:
    * **Did the instructions match your experience?**
    * **Are any steps confusing?**
    * **Did we miss any steps?**
1. Writing better instructions. If you have a better way to describe a step in
mind, a PR submission would be greatly appreciated.
1. Looking through the issues and submitting a patch. We're tracking bugs and
upcoming features in this repository's issue tracker.

## How do I start contributing?

### Installing the walkthrough

1. Clone the repository.

```
$ git clone https://github.com/exercism/interactive-cli-walkthrough
```

2. Inside the repository's directory, run the following command:

```
$ bundle
```

### Writing workflow

#### Steps

##### Format

Each step is written in Markdown. If you haven't used it before, we recommend
looking at this [tutorial][markdown].

Steps should be saved with the `*.tw2` file extension.

##### Adding steps

In order to add a step, you must first add it to the table of contents. The
table of contents is the file named [table_of_contents.tw2][table_of_contents.tw2].

##### Table of contents

To further explain the table of contents' structure, let's take a look at an
example:

```
::StoryIncludes

common/step_1.tw2
common/step_2.tw2
```

The first line, `::StoryIncludes`, is a special command which doesn't need to
be changed.

The consecutive lines tell the table of contents that we have two steps,
`common/step_1.tw2` and `common/step_2.tw2`. These steps are located inside
the `common/` directory and have the file names `step_1.tw2` and `step_2.tw2`,
respectively.

If we want to add a third step, `step_3.tw2`, located inside the `mac/`
directory, we write the table of contents this way:

```
::StoryIncludes

common/step_1.tw2
common/step_2.tw2
mac/step_3.tw2
```

#### Additional commands

To make it easy to create links between steps, two special commands are
available:

##### Step title

`::Link Destination`

This sets a step's name as `Link Destination` which is needed in order for the
link command to know what step to link to. This command is placed on the first
line of the file.

##### Link

`[[<Link Text>-><Link Destination>]]`

This creates a link with `Link Text` that links to a step entitled
`Link Destination`.

#### Viewing changes

In order to view your changes, you need to compile the project. Compiling is
done by running this command:

```
$ bundle exec rake compile
```

Compiling produces a file named `compiled.html`. Open this file in your browser
and you should see your changes.

#### Visualizing steps

If you're a bit lost of how each step links to another, you can generate the
walkthrough graph.

This requires Graphviz—follow the instructions for your platform on the [Graphviz Download](https://graphviz.gitlab.io/download/) page.

Then run this command:

```
$ bundle exec rake graph
```

This produces a file named `graph.png`. This tool is also helpful to find broken
links between steps.

### Submitting Code Changes

If you're new to contributing to open source on GitHub, this next section should
help you get started. If you get stuck, open an issue to ask us for help and
we'll get you sorted out (and improve these instructions).

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
newly generated walkthrough graph.


#### More information

For more guidance, you are free to peek into how the installation
instructions for Mac were written.

[coc]: https://github.com/exercism/exercism.io/blob/master/CODE_OF_CONDUCT.md
[table_of_contents.tw2]: https://github.com/exercism/exercism.io/blob/master/table_of_contents.tw2
[squash-commits]: http://blog.steveklabnik.com/posts/2012-11-08-how-to-squash-commits-in-a-github-pull-request
[issues]: https://github.com/exercism/interactive-cli-walkthrough/issues
[markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
