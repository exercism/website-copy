<!--
requires 3 params:
  line: line of the error
  error: the error encountered
  token: if a specific token is mentions by the parser
-->

Something went wrong while parsing the submission; most likely a "Syntax Error":

Message: Parsing error on line: `%{line}`. Check near: `%{token}`

```text
%{error}
```
