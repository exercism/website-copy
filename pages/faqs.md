## Exercism FAQs

### Who is behind Exercism?
Exercism was originally founded by [Katrina Owen](http://www.kytrinyx.com/). Katrina is a polyglot developer and Ruby Hero award winner who accidentally became a developer while pursuing a degree in molecular biology. She began nitpicking code back in 2006 while volunteering at JavaRanch, and got hooked. When programming, her focus is on automation, workflow optimization, and refactoring. She cares deeply about open source and contributes to several projects outside of Exercism.

In 2016, Katrina decided that for Exercism to fulfill its potential, it needed a professional product team to rethink Exercism from the ground up. She recruited [Jeremy Walker](https://ihid.co.uk) as co-founder, and working with [Nicole Chalmers](https://twitter.com/n_chalmers) and the team at [Thalamus](http://thalamus.ai), they reconceived Exercism as the fully-fledged product you see today.

In addition to this [leadership team](/team), Exercism is made possible by thousands of wonderful volunteers who have crafted the various language tracks and exercises that made Exercism so popular. Learn more about our [mentors](/team/mentors), our [track maintainers](/team/maintainers) and our thousands of [contributors](/team/contributors).

### What's with the name "Exercism"?

Despite being one vowel away from "exorcism", the name has nothing to do with demons or fixing "evil code".

Instead, it's a pun on exercise. The way Katrina came to think about each exercise is that they are small, trivial, and seemingly simple. However, when it comes to solving an exercise, the devil is often in the details. In other words, that simple exercise is suddenly more challenging once you think about the finer details.

To learn more about what it means for the devil to be in the details, check out the
[Overkill](http://www.kytrinyx.com/talks/overkill) and
[Succession](http://www.kytrinyx.com/talks/succession) talks by Katrina.

### I get the error "Sorry, we could not authenticate you from GitHub" when trying to log in. What should I do?

This means that GitHub isn't willing to verify who you are. That can be because you choose to not give permission or it might be because your GitHub account is not properly configured. A common problem is that you haven't verified your email address on GitHub. You can check that in your [GitHub email settings](https://github.com/settings/emails).

### How do I delete my account?

You can delete your account by following the link at the bottom of your [settings page](https://exercism.io/my/settings).

### How do new language tracks get added to the site?

A new language track gets created when a member of the community takes the lead on it and becomes a maintainer of the track. If you'd like to get involved in helping set one up, there are [instructions here](https://github.com/exercism/request-new-language-track/blob/master/README.md).

## Exercism Command-line Client FAQs

### I can't submit! What should I do?

The new site has a brand new command-line client, and also needs some extra metadata for your exercise. Read about how to [upgrade your command-line client and migrate your solutions for the new site](/cli-v1-to-v2).

If that doesn't help, or you didn't use the old version of the command-line client, please read through the [command-line client Walkthrough](https://exercism.io/cli-walkthrough). If that doesn't help either, open an issue on [exercism/exercism.io](https://github.com/exercism/exercism.io) and we will help you get it sorted out.

### How do I check the version of my command-line client?
The version command `exercism version` outputs the running version of the Exercism command-line client. By running the version command with the latest flag `exercism version --latest` you can check if there is a newer version available.

### How do I upgrade to the latest version of the command-line client?
The command `exercism upgrade` will upgrade to the latest available version of the command-line client if one is available.

### I get permission denied errors when upgrading! What should I do?
If you are receiving permission denied errors when trying to upgrade the command-line client, chances are the binary was installed via a system package manager (e.g Homebrew) or has been installed into a directory that you no longer have write access to.

If your command-line client was installed via a package manager please use your package manager for upgrading, as opposed to running the `exercism upgrade` command.

If your command-line client was installed manually, please check the path of the Exercism command-line client `which exercism` on Linux and MacOs, `where exercism` on Windows and ensure that the returned path is a directory you created. If so, use the tools provided by your system to change the permissions of the directory to grant write access to your user and trying upgrading again. If you are not sure if you created the directory, or the returned path is a system path, please use your system tools to uninstall the command-line client and reinstall using the [interactive walkthrough](https://exercism.io/cli-walkthrough).

### I get the "16-bit MS-DOS Subsystem" error dialog after upgrading on Windows. What should I do?
Prior to version 3.0.5 of the Exercism command-line client, there was a bug in the upgrade command that would replace the command-line client binary file with a single text file causing the "16-bit MS-DOS Subsystem" error. To resolve this issue remove the corrupt binary and reinstall the command-line client using the [interactive walkthrough](https://exercism.io/cli-walkthrough).

### What if my issue is not listed on this page?
  If your problem hasn't been resolved or reported, then [create an issue](https://github.com/exercism/cli/issues/new) with the following information:

  1. The output of the `exercism troubleshoot` command.
  1. Details on the issue you are experiencing.
  1. Instructions on how to reproduce the issue.

## Exercism Team FAQs

### What happened to my Team from the old site?

We have a brand new dedicated Teams website coming soon. We will tweet out as soon as it's launched. Follow us at [@exercism_io](https://twitter.com/exercism_io).

