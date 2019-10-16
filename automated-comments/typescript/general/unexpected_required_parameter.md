The parameter \`${'parameter.name'}\` is called with and without a value in
the tests, but it is _not marked as optional_, which means that the tests
won't pass. A TypeScript parameter can be explicitly marked as optional using
a `?` postfix:

```typescript
function(${'parameter.name'}?: ${'parameter.type'}) {
  //
}
```

Or, alternatively, by assigning a default value:

```typescript
function(${'parameter.name'}: ${'parameter.type'} = <default>) {
  //
}
```
