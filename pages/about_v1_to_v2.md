# About v1 to v2 transition

We've rebuilt Exercism from the ground up to provide a smoother, more in-depth experience. Exercism now has progression through tracks, more structured mentoring and a much better user interface.

Below, we have outlined a few of the biggest changes. For even **more** details you can view [this document](https://github.com/exercism/v2-feedback). If you need help migrating solutions on your local system from v1 to v2, please [read this document](/cli-v1-to-v2).

We are still working through lots of TODOs to get things right, so please bear with us, but we hope you find this new version more fun and useful than ever.

## New branding

There are aspects of the old logo and branding that we like, but we found that it doesn't express the most important thing about Exercism: this is a friendly, welcoming place focused on the humans.

The horned "e" logo and the unofficial tagline "the devil is in the details" was problematic. It focused too hard on the "exorcism" part of the pun, rather than the "exercise" part of the pun. The pink color scheme and the horns can be perceived as off-putting, aggressive, and unwelcoming. The meaning of the idiom "the devil is in the details" is not obvious, especially if English is not your first language. While the original intent of this was a playful hat tip to how deeply you can dig into a simple problem, how much you can learn from it, and how much people can find to say about it, the result is that it felt like an inside joke. Inside jokes exclude people, which is the exact opposite of what we want. Additionally, for people who are deeply religious in the Catholic tradition, this can sometimes come across as a disrespectful play on their beliefs.

Also, to some people it looks like an emotional support group for people who don't like Internet Explorer. I'm sorry. Now you can't unsee it. I know.

We want to emphasize human connections and a supportive, friendly learning environment.

To this end we have designed a completely new logo, and a new design aesthetic.

## Redesigned language tracks

We have completely redesigned the experience around joining, participating in, and completing a language track.

We have done so very carefully with the goal of enticing people to try a track, and to help motivate people to work their way through it.

The most important consideration for us in redesigning the tracks has been to support people's learning. We want to support their intrinsic motivation to progress through and complete the track. We want to reduce unnecessary friction. We are optimizing for the right friction, centered around wrestling with the language and exercises productively, rather than feeling intimidated by the process, the site, or the community.

As described in the design document about progression and learning, we have restructured the exercises within the tracks to contain a small set of core exercises that must be completed in order to complete the track. Each core exercise unlocks a number of optional exercises, which lets us continue to add exercises without making people feel like the goal post is constantly moving.

In order to enhance the playful and welcoming feel of the site, we've given each exercise its own icon. Most of the icons come from the Noun Project, with some custom designed icons where we couldn't find something that fit. We've also redesigned all the track icons to get a uniform look and feel across the site. All the exercise and track icons live in the website-icons repository.

Each person who joins a track gets a personal dashboard for that track, showing their progression through the core exercises. It also shows them all of the optional exercises, letting people filter on topic and difficulty in order to find exercises they want to work on.

The maintainers of a track have a huge influence on the experience that a track provides.

A great track will be a comprehensive introduction to the basics of a programming language. It will have a rich set of varied exercises that cover the breadth of both the language features themselves, as well as the standard library. It will have a large number of optional exercises that explore parts of the language more in-depth.

It is our hope that the user experience on the site is so good that it fades into the background, creating a place where the work of the maintainers can shine.

There are two core audiences for the exercise portion of the language tracks. They are:

- people who are learning to program for the first time
- programmers who want to ramp up quickly in a new language

We are able to have two core audiences rather than one, because they share a common goal: basic fluency in a programming language. Exercism's sweet spot is bridging the awkward gap between "hello world" and productivity in the basics of a language.

How many exercises someone needs will vary from person to person and from language to language, based on people's existing background and skills. The goal is to achieve basic fluency in the syntax, data structures, standard library, and idioms of a language. There is no competitive aspect designed into the product, and we've put a lot of effort into making sure that people can work at their own pace, focusing on the parts of the language that they need the most and are most interested in.

Notice that we're not focusing on "artisans" as a core audience for the exercises themselves. Artisans are typically already fluent in a language, use it professionally, and care deeply about the finer details of the language. We believe that artisans will be able to enjoy the exercises and get a lot out of them, however we are not catering to their needs directly within the track progression. We are willing to design for them, but only to the extent that it doesn't detract from the two core audiences whose focus is basic fluency.

That said, we believe that Exercism has a lot to offer artisans, and they are part of our core "mentor" audience, described in more detail below.

## A new mentorship model
Because learning can be such a vulnerable process, we decided after much deliberation to make the mentorship process private between the learner and their mentors. There are some giant trade-offs inherent in this choice, between helping people feel safe and supported, scaling mentorship, and making solutions available for others to learn from. We will be addressing some aspects of the old model of communal feedback and learning with the new teams interface.

We have written in depth about the considerations we wrestled with and that led to this decision in the design document about code review.

We believe this redesigned mentorship will benefit both the learners and the mentors. For learners, this will improve the quality of the feedback, and provide a safer space within which to receive it.

By opting in to be a mentor, an individual is opting in to receive meta feedback and—if we can find great coaches—coaching on their mentoring skills. The skills that mentors will be practicing and improving are skills that are highly valued on software development teams. Things like code review, communication skills, the ability to synthesize information, explain technical concepts, provide useful feedback, the difference between critique and criticism, a deeper understanding of architecture, best practices, the design of code, simplicity, naming things, etc. These skills are among the skills that employers look for when choosing technical leads or managers for technical teams.

In order to reduce the risk of learners feeling like they're at the bottom of a dogpile, we will restrict the number of mentors that have access to a given solution. We think that the optimal ratio of mentor to learner on a solution is probably about 3:1—however we don't think we need three times as many mentors as learners. Most mentors will be able to give feedback on exercises much more quickly and efficiently than learners will be submitting code. We will need to work out the ideal ratios once we have launched.

Once a student has completed an exercise, they can decide whether or not to make it available to the broader Exercism community. If someone decides to make the solution available, they can also decide whether or not to include it in their public showcase.

## Privacy features
**Aliases:** People can choose on a track-by-track basis what avatar they want to use and what handle they want to go by. This means that people can use their Exercism username publicly in some tracks while remaining private in others. Logging in is now decoupled from GitHub, so the Exercism username may or may not be the same as their GitHub username. If someone chooses to use a handle that is different from their username, then we will make it clear to mentors that this is an alias.

**Blocking:** People can choose to not interact with certain others. This goes for both learners who can opt out of certain mentors, and mentors who can choose to not work with certain learners. There are a number of reasons why people might want to not interact with someone, and they do not all reflect poorly on the person in question. We will however, be monitoring this data for outliers so that we can intervene if we are seeing behavior that is concerning.

**Selective:** As mentioned above, people can choose whether or not to make their solutions available to the Exercism community, and also whether or not they wish to make specific exercises/solutions available in their public showcase. Solutions submitted under an alias can not be added to a user's public showcase. The solutions can still be made available via browsing to the general Exercism audience, however.
