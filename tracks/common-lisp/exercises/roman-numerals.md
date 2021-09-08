# Mentoring

This exercise does not have any restriction on using functions in the standard library.

If the student either doesn't know the canonical solution or believes they were not supposed to use it provide full mentoring on the code they chose to implement. But direct them to the canonical solution.

## Reasonable Solutions

```lisp
(defun romanize (number)
  (format nil "~@R" number))
```

Is *the* canonical solution.

## Talking Points

The [reason](http://code-and-cocktails.herokuapp.com/blog/2020/10/21/standard-joke/) that the language contains this feature is an amusing story and might be of interest to the student.

