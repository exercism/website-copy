# Roadmap

# Roadmap

_This page deals with the various individual tasks that the team are focused on. Before reading this, you may be interested in reading about [Exercism's Strategy](/strategy) to place the items below in context._

This is a rough roadmap for Exercism. It is split into our short term goals (<12 months) and our longer-term goals, which will be dependant on the success of our short-term objectives. Each section is split roughly in priority order, and sections are ordered as per our general priorities.

## Short-term goals

## Bugs

- There are lots of little issues that need resolving from the launch of v2. Anything tagged with `type/bug` on the exercism/exercism repo needs sorting. You can explore that list [here](https://github.com/exercism/exercism/issues?q=is%3Aissue+is%3Aopen+label%3Atype%2Fbug).
- **Fix issues with exercises not being unlocked:** [#3867](https://github.com/exercism/exercism/issues/3867).

## Abuse and quality control

- **Add a button for mentors to report learners** [#4306](https://github.com/exercism/exercism/issues/4306).

## Curriculum

We are actively working to explore what an exemplar syllabus would look like for the Ruby track, considering things such as learning pathways, goals, mentoring-burden. We will then explore where the gaps are and what new exercises might be created as part of this. Once we have made some basic progress we will widen the discussion to include a small set of sample tracks with active maintainers.

## Mentoring Tools

- Adding personalised mentor notes per exercise, viewable and editable within the UI. [#4083](https://github.com/exercism/exercism/issues/4083)
- Adding 'Comment and Request changes' to mentoring UI, which will prompt the learner to submit another iteration (a little like Code Review on GitHub)
- Adding difficulty filter to solution selector [#4105](https://github.com/exercism/exercism/issues/4105)
- Showing more information (such as track backlog) on the dashboard [#4032](https://github.com/exercism/exercism/issues/4032)
- Improve mentoring notifications [#3883](https://github.com/exercism/exercism/issues/3883)
- Allow mentors to view other mentors' comments [#3988](https://github.com/exercism/exercism/issues/3988)
- Allow track mentors to find previous reviews of other solutions of the same exercise [#4364](https://github.com/exercism/exercism/issues/4364)
- Calculate mentors' "weekly progress" per track [#4438](https://github.com/exercism/exercism/issues/4438)
- **Send content with mentor emails:** [4428](https://github.com/exercism/exercism/issues/4428)

## Usability and documentation

- **Make the steps of the installation guide linkable:** [#4470](https://github.com/exercism/exercism/issues/4470)
- **Add more information about timescales for mentoring:** [#4368](https://github.com/exercism/exercism/issues/4368).
- **Download link on all iterations** Add the download link and a link to instructions on all iterations in the student's view. [#4259](https://github.com/exercism/exercism/issues/4259)

## Profiles and public solutions

- **Allow users to change which iteration is published:** At the moment only the most recent submission is published. We will allow users to choose any of the iterations to make public.
- **Allow deletion of iterations:** Often people submit iterations by default. This will allow people to delete them. [#3848](https://github.com/exercism/exercism/issues/3848)
- **Add display name option:** [4365](https://github.com/exercism/exercism/issues/4365)
- **Enable commenting on community solutions:** We are going to let people decide whether want comments enable on a per solution basis.

## Maintainer Tools
We want to update the new website to allow for an easy and pleasant experience for track maintainers and will build out tools within the UI to allow them to more easily experiment with track setups.

## Accessibility

There are various [a11y](https://a11yproject.com/) improvements we are making, spearheaded by [@unused's plan here](https://github.com/exercism/website/pull/182).

## Changelog

We want to add a changelog into the site that all maintainers and contributors can add to. Rather than being a static page, this will be a functional product. We envisage that a maintainer would submit an entry saying "We've added a new exercise called XYZ to the ABC track". This would then appear on the changelog with a nice track icon, and the Track's twitter account (yes, every track will have its own account) will then tweet that out. The changelog will be filterable by track or topic and have built in searching.

## Public API

We want to define a public API that will allow others to integrate Exercism into their code editors [#4087](https://github.com/exercism/exercism/issues/4087).

## Automated running of the tests

We want to create true integration tests that run against production that test sign up, track creation, mentoring and then delete the user. These will run after each deploy of both new code and changes to a track to ensure nothing has broken.

We see this as a long-term goal and not something that will be implemented in the next 6 months.

## Automated code analysis of submissions

We used to have a bot called Rikki that used the [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) to work out what anti-patterns were being used and provide an automatic comment. We want to evolve this to provide a suggested comment to mentors that they can give to students (we may sometimes choose to make it automatic - we need to explore this further). We imagine using a mixture of Machine Learning and AST analysis to do this and will probably prototype it on 1-3 tracks first.

## Long-term goals

## Online completion of exercises

Remove the requirement to install the CLI allow people to complete the exercises and run the tests on the Exercism website. This will also allow us to automatically run tests against submitted code to test that it works and help mentors.

## Multilingual support

We really want to support multiple languages, but doing this is a huge, complex project, which would involve translating the exercises, website, etc., as well as being able to recruit mentors into a specific language. We're currently exploring what a first stage of this might look like for PT-BR [here](https://github.com/exercism/exercism/issues/4207).
