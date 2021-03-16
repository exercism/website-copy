# Mentoring

### Reasonable solutions
```typescript
type StudentRoster<T> = Map<T, string[]>

export default class GradeSchool {

  private roster: StudentRoster<number> = new Map()

  studentRoster(): StudentRoster<string> {
    const result: StudentRoster<string> = new Map()
    const grades = this.roster.keys()
    for (const grade of grades) {
      result.set(grade.toString(), this.studentsInGrade(grade))
    }
    return result
  }

  addStudent(student: string, grade: number) {
    const gradeStudents = (this.roster.get(grade) || []).concat(student)
    this.roster.set(grade, gradeStudents)
  }

  studentsInGrade(grade: number): string[] {
    const gradeStudents = (this.roster.get(grade) || [])
    return gradeStudents.sort().slice()
  }
}
```

Variations include:
- Using an `{}` with indexed type as backing roster
- Using insertion-time sort (`addStudent`)
- Using destructuring or `.concat` to duplicate `studentsInGrade`

### Common suggestions
- Does not warrent blocking approval, if the student uses an `{}`, you can point out that the test wants a `Map` anyway, or at least somehting that behaves like it.

### Talking points
- Insertion sort vs sorting when outputting the roster
- Converting everything to `string` or only for the output
- Methods of cloning (deep clone iteration, `slice()`, etc)
- `Map` vs `{}` for backing
