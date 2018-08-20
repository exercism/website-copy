## One day to two weeks

### Teams

We are building a dedicated site for teams. It will allow groups of people to complete exercises and mentor each other in a private space. We envision it being used by bootcamps, groups of friends, and colleagues at work. Teams on Exercism v1 was a really important feature for many people so restoring it is a top priority for us.

**Status:** Close to launching. Ironing out the last bugs.

### Fixing bugs

There are still loads of little issues that need resolving from the launch of v2. Anything tagged with `type/bug` on the exercism/exercism repo needs sorting. You can explore that list [here](https://github.com/exercism/exercism/issues?q=is%3Aissue+is%3Aopen+label%3Atype%2Fbug).

## One week to four weeks 

### Merging mentoring.exercism.io into the main site

We want to streamline the sign up process, to remove the Google Form and the need to join slack to mentor. We have some challenges to do this, such as ensuring there is quality control before someone can go wild mentoring, but we have some ideas as to how to achieve this.

### Mentoring UI Improvements

- Exposing the communal mentoring notes from GitHub to be visible directly within the UI.
- Adding personalised mentor notes per exercise, viewable and editable within the UI.
- Adding 'Comment and Request changes' to mentoring UI, which will prompt the learner to submit another iteration (a little like Code Review on GitHub)
- Adding difficulty filter to solution selector
- Showing more information (such as track backlog) on the dashboard

### Delete my account

We need to give people the ability to delete their account without emailing Jeremy.

## Two to three months

### Changelog

We want to add a changelog into the site that all maintainers and contributors can add to. Rather than being a static page, this will be a functional product. We envisage that a maintainer would submit an entry saying "We've added a new exercise called XYZ to the ABC track". This would then appear on the changelog with a nice track icon, and the Track's twitter account (yes, every track will have its own account) will then tweet that out. The changelog will be filterable by track or topic and have built in searching.

### Automated testing on the real site

We want to create true integration tests that run against production that test sign up, track creation, mentoring and then delete the user. These will run after each deploy of both new code and changes to a track to ensure nothing has broken.

## Three to six months

### Generate a examplar syllabus for the sample tracks

We are actively working to explore what an examplar syllabus would look like for the Ruby track, considering things such as  learning pathways, goals, mentoring-burden. We will then explore where the gaps are and what new exercises might be created as part of this. Once we have made some basic progress we will widen the discussion to include a small set of sample tracks with active maintainers.

### Provide automatic code analysis of submissions

We used to have a bot called Rikki that was use the [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) to work out what anti-patterns were being used and provide an automatic comment. We want to evolve this to provide a suggested comment to mentors that they can give to students (we may sometimes choose to make it automatic - we need to explore this futher). We imagine using a mixture of Machine Learning and AST analysis to do this and will probably prototype it on 1-3 tracks first.

## Beyond six months

### Allowing exercises to be completed online

Remove the requirement to install the CLI allow people to complete the exercises and run the tests on the Exercism website. This will also allow us to automatically run tests against submitted code to test that it works and help mentors.

### Multi-lingual support

We really want to support multiple languages, but doing this is a huge, complex project, which would involve translating the exercises, website, etc as well as being able to recruit mentors into a specific language. We're currently exploring what a first stage of this might look like for PT-BR [here](https://github.com/exercism/exercism/issues/4207).
