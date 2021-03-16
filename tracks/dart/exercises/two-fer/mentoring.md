# Mentoring

### Reasonable solutions

The most simple solution is to set the default value for an optional parameter to `"you"` and use 
string interpolation:

```dart
String twofer([String name = "you"]) {
  return "One for $name, one for me.";
}
```

Solution using an expression-bodied method:

```dart
String twofer([String name = "you"]) => "One for $name, one for me.";
```

### Common suggestions

- If they are using overloaded methods, suggest to use a single method with an 
[optional parameter][reference-optional-parameter].
- Instead of using an if-statement, suggest to use a single expression. This will force the student 
to remove any duplication in the code.
- Suggest using [string interpolation][reference-string-interpolation] over string concatenation
because it is the recommended practice by the Dart development team and that it is a common practice
within the Dart community.
- If they are using `null` as the default value, suggest to use `"you"` instead.
- It might be useful to suggest writing the `twofer` method as an 
[expression-bodied method][reference-expression-bodied-method] (also called arrow syntax or `=> expr`),
 as it is perfect for these kinds of small methods.
- One best practice is to avoid changing the value of the function parameters. This has the main
 benefit of keeping things immutable: by not overwriting the parameter value, you know its value on 
 every single line in the method: namely its original value. This greatly helps in figuring out the 
 state of a system.

[reference-optional-parameter]: https://dart.dev/guides/language/language-tour#default-parameter-values
[reference-string-interpolation]: https://dart.dev/guides/language/language-tour#strings
[reference-expression-bodied-method]: https://dart.dev/guides/language/language-tour#functions