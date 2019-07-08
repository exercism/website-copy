In order to guard against accidental changes, always define the `return` type
for public APIs, such as functions that are `export`ed:

\`\`\`typescript
  ${'signature'}: <return-type> {}
\`\`\`

TypeScript is really good at type inference and will assign a `return` type to
all functions. But accidental changes may change that inferred type, and it
may or may not cause a compilation error at the source of that change. Adding an
explicit return type may make the compilation fail at the source.
