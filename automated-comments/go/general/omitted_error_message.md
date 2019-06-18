You create an error with an empty message. In Go the error message is (currently) the only way for you to know what happened.
If you omit the error message you have no way of knowing what is going on. Go's errors don't have a traceback either.

Note: this is about to change. Go's errors will contain more information soon. Still the error message should never be left empty.
