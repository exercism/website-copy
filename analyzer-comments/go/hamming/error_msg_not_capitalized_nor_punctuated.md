# error msg not capitalized nor punctuated

Error strings in Go are typically [not capitalized, and do not contain punctuation](https://github.com/golang/go/wiki/CodeReviewComments#error-strings). 
This is because in Go error strings are often chained together, 
providing a sort of breadcrumb trail of what led to the error. 
Punctuation and capitalization make the resulting error messages look weird.
