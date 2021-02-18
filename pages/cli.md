# CLI 

## Installation

The Exercism command line interface (CLI) is a tool that can download exercises, show your progress through a track, and submit your solutions - all from within your terminal. The best way to get started with the CLI is our [Interactive Walkthrough](https://exercism.io/cli-walkthrough). It guides you down the right path depending on your operating system, experience with the command line, etc, and will get your CLI configured.

If you just want to download the CLI manually and work out how to use it, you can download and install it from [GitHub](https://github.com/exercism/cli/releases/latest). However, please note that we ask that you work through the [Interactive Walkthrough](https://exercism.io/cli-walkthrough) before opening any support requests.


## Upgrading from pre-v3

If you have a previous version of the CLI and want to upgrade, please read [these instructions](https://github.com/exercism/website-copy/blob/main/pages/cli_v1_to_v2.md).

## Basic usage
Run the help subcommand to get the full list of available commands.

```bash
exercism help
```

## Configuration
You need to tell the tool who you are. You can find your token in your [settings page](http://exercism.io/my/settings).

```
exercism configure --token=YOUR_API_TOKEN
```

## Troubleshooting

Make sure you are on the latest version.

Verify which version you are on:

```bash
exercism version
```

Verify against the latest release and upgrade if your version is not the most recent.

After upgrading, double-check the version. If the version didn’t change, make sure you are running the upgraded binary.

```bash
which exercism
```

If you are still having trouble open an issue in exercism/cli on GitHub with the output of the troubleshoot command.

```bash
exercism troubleshoot
```

You can open issues on [our issue tracker](https://github.com/exercism/exercism.io) and the community will try to help you. **Please ensure you have worked through the [Interactive Walkthrough](https://exercism.io/cli-walkthrough) before opening any issues.**
