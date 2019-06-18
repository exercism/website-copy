If you have a static error message you can use `errors.New` instead of `fmt.Errorf`. It is a lot faster as it does not need
to parse the message for placeholders.
