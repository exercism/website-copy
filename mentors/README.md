# Mentors

This directory contains bios for mentors.

There is a directory for each track.
Each directory contains JSON files in the range 0..9,a..z

    mentors/
    ├── c
    │   ├── 0.json
    │   ├── ...
    │   ├── 9.json
    │   ├── a.json
    │   ├── ...
    │   └── z.json
    ├── ...
    │   ├── ...
    │   └── ...
    └── vimscript
        ├── 0.json
        ├── ...
        ├── 9.json
        ├── a.json
        ├── ...
        └── z.json

    mentors/
    └── c/

Each mentor should add a bio to _all_ tracks that they mentor.

## Add your bio
Choose the JSON file that starts with the first character of your GitHub username.
Use the following format.

    {
      "github_username": "kytrinyx",
      "name": "Katrina Owen",
      "link_text": null,
      "link_url": null,
      "avatar_url": null,
      "bio": "I love Go for its simplicity and consistency. I've written Go professionally, and also use it for open source projects."
    }

Aim for approximately 200-250 characters for the bio.

The `link_url` and `link_text` are for linking to a personal site, if you want to.

Note that if you leave a field `null`, we will use the content from your public GitHub profile.
If you want to leave a field blank, set it to an empty string.

The file should consist of a JSON array of mentor bios.  The first line of the file should contain only a single `[` character and the last line should be only a single `]` character.  Each bio should be separated by a single comma.

Please create a Pull Request in this repository, which we will review and merge.

For an example, see [Katrina's commit for Go](https://github.com/exercism/website-copy/pull/8/commits/469c4e2242d320928162d12bc83efea799a1c2fa).
