# Mentoring

### Reasonable solutions

```elisp
;;; two-fer.el --- Two-fer Exercise (exercism)

;;; Commentary:
;;; Two-fer or 2-fer is short for two for one.  One for you and one for me.

;;; Code:
(defun two-fer (&optional name)
  "One for NAME, one for me."
  (format "One for %s, one for me." (or name "you")))

(provide 'two-fer)
;;; two-fer.el ends here
```

### Common suggestions

* Suggest the use of a single call to the `format` function - [https://www.gnu.org/software/emacs/manual/html_node/elisp/Formatting-Strings.html](https://www.gnu.org/software/emacs/manual/html_node/elisp/Formatting-Strings.html)
* Explain that the `format` function takes a format string and a list of objects to substitute into the format string, and that those objects can _themselves_ be expressions. For example:
```elisp
(format "1 for you, %s for me" (+ 1 1)) ;;; "1 for you, 2 for me"
```
* Suggest the use of the `or` special form over complex conditionals like `(if name name "you")` - [https://www.gnu.org/software/emacs/manual/html_node/elisp/Combining-Conditions.html#Combining-Conditions](https://www.gnu.org/software/emacs/manual/html_node/elisp/Combining-Conditions.html#Combining-Conditions)


### Talking points

* The `defun` macro takes several arguments, one of which is a documentation string of the function. In addition to giving more context to the reader of the source code Emacs' help system can display this documentation to consumers of your function. The documentation string parameter of the `defun` macro _is_ optional, but highly encouraged by the community. [https://www.gnu.org/software/emacs/manual/html_node/eintr/defun.html](https://www.gnu.org/software/emacs/manual/html_node/eintr/defun.html)
