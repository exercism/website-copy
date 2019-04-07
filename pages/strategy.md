Exercism is a large complex project with thousands of contributors working across dozens of projects, all trying to achieve ambitious goals. It would quickly become overwhelming if we were all working towards making Exercism perfect, so to keep things manageable, we periodically determine the critical next step for Exercism to achieve its goals and then plan that into a strategy. Our current goal is to make Exercism scalable. We expect our next three goals to be to make Exercism financially sustainable, to make Exercism more accessible to beginners, and to intentionally grow Exercism for the first time.

We present this as an Objective, which will aim to achieve with a Strategy, supported by a series of Tactics. This is commonly known as the OST framework.

## Objective

**Make Exercism scalable**

At the time of writing, Exercism has 8,000 new submissions per week. Our mentors currently cannot keep up with the amount of submissions submitted. When they do keep up, the number of submissions almost immediately doubles, as students stick with a Language Track. We are growing by 300-400 new users per day. Many find Exercism too hard to use, but in the future, when that is fixed, we will expect to see the number of submissions double again. We have never actively marketed Exercism. All 300,000 members have come through word of mouth. When we start to market Exercism, we expect to see an increase in usage by two orders of magnitude. Our most important goal at this stage is being able to give our current students a timely mentoring experience, and be able to cope with further growth without overwhelming mentors.

We aim to achieve this goal by the end of 2019.

## Strategy

**Acquire and retain more mentors by making mentoring rewarding and enjoyable**

Currently, mentoring can be both fulfilling and frustrating. It can be very rewarding to help a student that wants to learn. On the flipside, it can be repetitive, students can be rude, there are few positive feedback loops, and it can feel too much like a job rather than a hobby. In order to retain our existing mentors, and to acquire new ones, we must make mentoring more enjoyable and more rewarding. We must make our mentors feel like that are part of something bigger them them, and that they are contributing to something valuable. A good parallel is wikipedia, where thousands of people contribute (from once a year, to dozens of times per day) because they feel like they are making a tangible difference to something that matters, and because the process itself is straight-forward but (strangely) rewarding.

## Tactics

### Track Anatomy Project

Some solutions are fun to mentor, some are extremely challenging. For example, solutions that require maths lead to mentors trying to tutor someone on algebra, not on coding. Other solutions can be solved in such a variety of ways that the mentor ends up debating the right algorithm, not teaching the idioms of the language.

The Track Anatomy Project will fix this by providing a framework to Track Maintainers, which they can work through in order to determine the optimal series of core exercises, and sensible related side exercises. In our prototype Track (Ruby), the result of the Track Anatomy Project saw a average reduction in waiting time from one week to half a day, and reduced the queue from hundreds to ~30 at any time. It also saw a doubling in the number of submissions per week and dramatically increased mentor retention, with the most active weekly number mentors of any track. Encoding this into a framework and applying it to all tracks should have a dramatic affect on mentor enjoyment.

### Automated Mentor Support Project

The majority of submissions are common. It is rare for a student to submit a solution that no-one else has ever submitted. The Track Anatomy Project aims to ensure this is the case, guiding tracks to have core exercises that are usually solved with one of a few common approaches. Automated Mentoring Support aims to utilize this consistency to provide automated approval and/or feedback to students for the majority of submissions to core exercises. This has the following benefits:
- **Reduce student frustration:** We give students a quick feedback loop. If a solution is optimal, let them continue. If it fails in a known way, tell them and let them improve it. This keeps students getting frustrated with waiting for their perfectly-ok solutions to be approved and therefore with the mentors who they perceive to be the source of the slowness.
- **Dramatically reduce the size of the queue:** Our prototyping has shown that for simple exercises (e.g. TwoFer) we will be able to provide automated mentoring in 90%+ of cases. For more complex exercises, this will reduce, but we expect to be able to provide automated mentoring on 50% of exercises, and on all optimal, or close-to-optimal, solutions.
- **Removes repetitiveness for mentors:** As most solutions fall into similar buckets, mentoring often turns into a copy and paste process, with a canned answer for each class of solution. This is boring and uninteresting to all but the most determined of mentors. By removing common solutions from the mentor queue, we ask mentors to only help students who need something extra, or have a fundamental learning gap that we cannot see.

### Mentor-Learner Relationship Project

Mentoring on Exercism is currently a very transactional process. A student submits a solution and a mentor gives comments. Other than the generally friendly nature of conversations there is no "relationship" between the mentor and the learner. There is no easy way for a mentor to remember if they have given feedback to that student before. There is no way to know if a student is a beginner or an experienced programmer and tailor feedback accordingly. There is no way for a student to know their mentor's background and respect/appreciate the feedback in that context.

By providing profiles for both mentors and learners, within the user interface, and by allowing both parties to continue the mentorship beyond one solution, we can make the whole experience less transactional and more empathetic, making mentoring more rewarding and enjoyable.

### Improve documentation and onboarding for mentors

Over 50% of people who sign up to mentor do not go on to mentor a single solution. I recently emailed all of those who had done this. Nearly 1/3 replied with various explanations, but a clear underlying theme is that getting a mentor to give feedback on their first solution quickly and with enough hand-holding would dramatically increase the amount of people who try mentoring. Providing guides and information that they help upskill those mentors and give them a further safety net would significantly increase their retention.

### Empower our mentors into a self-supporting community

Those mentors who mentor the most regularly are also the most active on our Slack community. We believe this is because they feel the most connected to Exercism, the most supported, and because mentoring becomes more than just replying to students - it becomes about sharing in bigger goal with other like-minded people. It is clear that Slack is also a bad choice of tool for many people as it has a barrier-to-entry, clashes with many people's main work-tool, and is a relatively synchronous experience. It also has no reminder/pull-backs if someone closes the window. If we can find a more asynchronous alternative system where people can be part of the community and the conversation, without needing to be "always on", and where we can remind them of conversations they'd like to see, then we will likely improve the quality, frequency, and inclusiveness of the conversation. Slack is also not a scalable option - having 100,000 mentors in one Slack room does not sound like fun.

### Provide realistic expectations to students

A key frustration for students is that some Tracks have a response time of hours and others have a response time of weeks. This discrepancy means that we frustrate and lose many students, many of whom could eventually become mentors. We also end up with lots of "abandoned" solutions that we don't know are abandoned until the student doesn't respond to the mentor - something that disheartens mentors and causes them to leave.

By providing realistic response-time expectations for the students in the UI **before** they put the effort into solving a solution, we can remove this frustration for both students and mentors.

### Remove the barrier to mentoring

We currently have a deliberate barrier to mentoring with a wall that you have to sign up through. We have put this in place because we want to try and ensure a level of quality control and therefore want to gate-keep and ensure that people who are mentoring feel like they are up to the taks. However, as we add automation, documentation, and a more integrated community, we will be able to remove this barrier and making mentoring more of "something for everyone" on Exercism, rather than something for the elite.

Once the barriers to mentoring are removed, we can actively encourage students to become mentors within the flow of Exercism itself. When someone completes the core exercises in a Track, we can prompt them to mentor. By asking students to fill out profiles listing the languages they know, we can show them solutions that they might be able to mentor, and encourage them to get involved.
