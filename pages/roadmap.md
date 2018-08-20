## Coming as soon as possible

### Teams

We are building a dedicated site for teams. It will allow groups of people to complete exercises and mentor each other in a private space. We envision it being used by bootcamps, groups of friends, and colleagues at work. Teams on Exercism v1 was a really important feature for many people so restoring it is a top priority for us.

**Status:** Close to launching. Ironing out the last bugs.

### Fixing bugs

There are still loads of little issues that need resolving from the launch of v2. Anything tagged with `type/bug` on the exercism/exercism repo needs sorting. You can explore that list [here](https://github.com/exercism/exercism/issues?q=is%3Aissue+is%3Aopen+label%3Atype%2Fbug).

## Next up

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

## Mini-projects

### Changelog

We want to add a changelog into the site that all maintainers and contributors can add to. Rather than being a static page, this will be a functional product. We envisage that a maintainer would submit an entry saying "We've added a new exercise called XYZ to the ABC track". This would then appear on the changelog with a nice track icon, and the Track's twitter account (yes, every track will have its own account) will then tweet that out. The changelog will be filterable by track or topic and have built in searching.

### Automated testing ont the real site

We want to create true integration tests that run against production that test sign up, track creation, mentoring and then delete the user. These will run after each deploy of both new code and changes to a track to ensure nothing has broken.
