# Mentoring

## Problem and challenges

The markdown exercise asks the student to refactor some code. The original code is
hard to follow; it is constructed of a single `for` loop, has many nested
conditionals, and meaningless variable names. The goal is for them to produce
improved code that still passes the tests.

## Reasonable solution

```python
import re


def format_header(line):
    def replacement(match):
        hashes, text = match.groups()
        num = len(hashes)
        return f'<h{num}>{text}</h{num}>'
    return re.sub(r'^(#{1,6}) (.*)', replacement, line)


def format_bold(curr):
    return re.sub(r'__(.*?)__', r'<strong>\1</strong>', curr)


def format_italic(curr):
    return re.sub(r'_(.*?)_', r'<em>\1</em>', curr)


def format_list_item(line):
    return re.sub(r'^\* (.*)', r'<li>\1</li>', line)


def format_paragraph(line):
    if not re.match('<h|<ul|<p|<li', line):
        line = f'<p>{line}</p>'
    return line


def convert_line(line):
    line = format_header(line)
    line = format_list_item(line)
    line = format_paragraph(line)
    line = format_bold(line)
    line = format_italic(line)
    return line


def group_list_items(old_lines):
    in_list = False
    new_lines = []
    for line in old_lines:
        if line.startswith('<li>'):
            if not in_list:
                new_lines.append('<ul>')
            in_list = True
        else:
            if in_list:
                new_lines.append('</ul>')
            in_list = False
        new_lines.append(line)
    if in_list:
        new_lines.append('</ul>')
    return new_lines


def parse(markdown):
    # Note: the markdown is separated by line, but the tests assume the HTML is all a single line
    markdown_lines = markdown.splitlines()
    html_lines = group_list_items(convert_line(line) for line in markdown_lines)
    return ''.join(html_lines)
```

Many possible solutions to this problem exist. The primary goal is to make comprehending the code
easier for the reader, while still passing all the tests. The new solution should aim to refactor the existing code, but need not be a complete rewrite. A significant increment towards readability could use the same basic approach and reuse some of the code if possible.

## Talking points

- Conditional statements make reading and understanding a solution harder. The original code has
17 conditional statements, and that should be significantly reduced.
- Functions should be small and have a clear purpose with a clear name.
- Repeated string concatenation to build up the result is inefficient. It is more efficient to build up a list of lines and then concatenate them all at once. That can also make some of the other changes easier.
- Variable names should be descriptive and unique (the original code used single letter names and the meaning of a variable
changed throughout the code.)
- Duplication should be minimized.
- `re.sub` is more concise and efficient for replacing strings than using `re.match` and building up a new string. It also handles multiple substitutions in a single line.
