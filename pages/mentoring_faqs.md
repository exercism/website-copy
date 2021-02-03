# Mentoring FAQs

Here we have collated a list of the questions asked frequently by mentors. If you have a question that hasn't been answered here, please post it on the **[\#questions](https://exercism-team.slack.com/archives/CAQP7JL3T)** channel on Slack.

## Getting Started

### How do I get started with Mentoring?
Once you've become a mentor via the [become a mentor](https://exercism.io/become-a-mentor) page, you can access your [mentor dashboard](https://exercism.io/mentor/dashboard) at any time. When you joined you should have received an invitation to our Slack Room. You can find more instructions in the [start-here channel on Slack](https://exercism-mentors.slack.com/archives/CBDA9LMDF/p1529968977000336).

### What is the goal of mentoring a solution?
The purpose of Exercism is to improve programming language _fluency_ rather than proficiency. In this sense, fluency is the ability to "speak" the language, to read and write code in it that communicates with other programmers and the machine. Our goal is to teach someone to write code in that language like a "native" programmer in that language would. Proficiency is the ability to write real-world programs using a language - e.g. understanding the standard library, the ecosystem, displaying technical rigor or algorithmic competency.

### When is a solution considered complete?
Each exercise on Exercism touches upon several programming concepts. A learner should touch on 2/3 concepts as they work through their iterations whilst taking on board mentor feedback and improving their solution through each iteration. If a student has done this, you could ask them if they would like to move onto the next exercise or if they'd like to learn how to improve their solution further to allow them to choose their own pace and depth of learning.

### How quickly do I need to respond to a submission?
Ideally within a week of a learner submitting their solution to help maintain their motivation and enthusiasm for the exercise. We will be implementing a "Leave of Absence" notification button for mentors soon that you can use if don't feel like you'll be able to respond to solutions within this timeframe. This button will pass the solutions you're mentoring onto another mentor.

## Better Mentorship

### What should I do if I don't know how to give feedback on a solution?
If you're not sure what feedback to give, paste a link to the solution (e.g. `https://exercism.io/mentor/solutions/...`) on the relevant language channel on Slack and brainstorm some ideas with other mentors.

### How can I improve my mentoring skills?
This is something we're extremely passionate about helping you with and we are in the process of writing some awesome guides on giving great feedback with lots of examples. Eventually we hope to have a guide for each track.

In the meantime, here are some recommended resources:

- [The Science and Art of Receiving Feedback Well](https://www.amazon.com/Thanks-Feedback-Science-Receiving-Well-ebook/dp/B00DMCV0XE/)
- [Unlearning Toxic Behaviours in a Code Review Culture - Conference talk by Sandya Sankarram](https://drive.google.com/file/d/1ROZA9yKpEa8suiqVXtPO0IJtqa95SOjE/view) and related [Blog Post](https://medium.freecodecamp.org/unlearning-toxic-behaviors-in-a-code-review-culture-b7c295452a3c)
- [How Positive and Negative Feedback Motivate Goal Pursuit](https://web.archive.org/web/20181227202107/https://faculty.chicagobooth.edu/ayelet.fishbach/research/FEF%20Compass%202010.pdf)
- The #mentor-the-mentor channel on Slack, where you can learn to be an amazing mentor from other amazing mentors.

In general, behaviours to avoid:

- stating opinion as fact
- avalanche of comments
- judgmental questions
- sarcasm

The Recurse Center has a simple but effective [list of social rules](https://www.recurse.com/social-rules) that can guide both your mentoring and personal interactions.

Examples:

> Unhelpful: “Why didn’t you just do ___?” (asking judgmental
questions)

> Helpful: “You can also do ___, which has the benefit of ___”


> Unhelpful: “Did you even test this code before you submitted it?” (being sarcastic)

> Helpful: “Your code breaks during “x, y, and z” edge cases, can you please address those cases?”

We appreciate this is a rough guide and we are working on creating documentation for each exercise to help with this.

### How can I report abuse or other violations?
Please check our [Code of Conduct](https://exercism.io/code-of-conduct) for more information about our expectations of conduct. If you would like to report something, please reach out to us at [abuse@exercism.io](mailto:abuse@exercism.io?subject=%5BCoC%5D]) and we will try to fix or resolve the issue respecting both you and your privacy.

## Managing Your Time

### How much time should I be spending on mentoring?
We had 1,000 submissions per day on the original Exercism site, of which fewer than 20% received feedback. Our key launch-targets are to achieve >95% feedback-rate. We have based our mentor recruitment numbers on mentors offering 1hr/week on average. If you can offer more than that then that's great!

###  Can I mentor another language?
Yes! To mentor another language go to [https://exercism.io/mentor/configure](https://exercism.io/mentor/configure) and select the languages you want to mentor.

### I need to have a break from mentoring, can I stop receiving new solutions?
Yes! We have this logged as an issue on GitHub (see [https://github.com/exercism/exercism/issues/3922](https://github.com/exercism/exercism/issues/3922)) and will be implementing a Leave of Absence notification soon.

### How can I stop mentoring a track?
If you would like to stop mentoring a track, please revert the pull request (PR) you (may have) made to add yourself to the list of mentors on the website for that track. You can find all website copy PRs on [the website copy repository](https://github.com/exercism/website-copy/pulls). Filter with the Author dropdown to find yours and select the PR for the right track (if you made more than one). Near the bottom of the PR, click Revert. If you made multiple updates with a single PR then create a new PR reverting the specific track addition.

## The Mentoring Interface

### I can’t see the Mentor Dashboard even though I've followed the "start-here" instructions
Go back to [https://exercism.io/mentor/configure](https://exercism.io/mentor/configure) and check that you have clicked the “Save” button at the bottom of the screen. Some people have missed this step and then been understandably confused by why they can't see the Mentor Dashboard. This should fix the issue.

### Why are there tests marked as skipped?
The tests are marked as skipped to encourage people to use the TDD approach of doing one test at a time. When people submit their solution and you view it in the UI, you're seeing the original tests that the user was sent, not their final tests file.

## Opening an Issue

If you have a question rather than an issue, use the #questions channel on Slack. If you believe it is a genuine issue, be sure to check the relevant GitHub issue tracker first to see if it has already been reported or addressed:

  1. [The Exercism Website or Product](https://github.com/exercism/website-copy/issues)
  2. [Exercises](https://github.com/search?q=topic%3Aexercism-track+org%3Aexercism&type=Repositories) - Select your language and then look at the issues tab

You can search through issues (remove the `is:open` filter to include closed/resolved issues). Try a few different keywords.

### What if my issue is not listed here or on GitHub?
  If your problem hasn't been reported, then create a report in the appropriate repository by selecting the green **New issue** button.

Make sure to include the following information:
  1. Details on the issue you are experiencing
  1. Instructions on how to reproduce the issue
  1. If applicable, reference to any related issue using its issue number (formatted like #1203)

### What if there is an issue with instructions or language on the website?
  If you have spotted a typo or if you have a suggestion for clearer language or instructions, then [create an issue for Exercism Website Copy](https://github.com/exercism/website-copy/issues/new) with the following information:
  1. Link to the page where the issue is
  1. Explanation of what the mistake is or what is unclear
  1. Your proposed change
