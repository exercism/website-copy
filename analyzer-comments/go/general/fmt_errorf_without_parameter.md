Prefer `errors.New` over `fmt.Errorf` for error messages that don't need interpolation, 
as it avoids parsing the message for placeholders.
