I see you are creating a custom `error`. This is perfectly fine! If you did not know about `errors.New` and `fmt.Errorf` 
have a look at them as they are much simpler ways to create an error. Custom errors are helpful if you want to check if an 
error is of a certain type later.
