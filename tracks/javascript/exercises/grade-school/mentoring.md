# Mentoring

## Reasonable solutions
```typescript
export class GradeSchool {

  constructor() {
    this._roster = {}
  }

  roster() {
    return Object.keys(this._roster).reduce((result, i) => {
      return { ...result, [i]: this.grade(i) }
    }, {})
  }

  add(student, i) {
    const gradeStudents = (this._roster[i] || []).concat(student)
    this._roster[i] = gradeStudents.sort()
  }

  grade(i) {
    return [ ...(this._roster[i] || []) ]
  }
}
```

Variations include:
- Using a `Map` as backing roster
- Using query time sort (`grade`)
- Using destructuring or `.concat` to duplicate `roster`/`grade`
- Using `JSON.parse(JSON.stringify(...))` to deep clone the `roster`
- Using `Object.entries` instead of `Object.keys`

## Common suggestions

## Talking points
- Insertion sort (insert time) vs sorting when outputting the roster (query time)
- Methods of cloning (deep clone iteration, `slice()`, etc)
- `Map` vs `{}` for backing
