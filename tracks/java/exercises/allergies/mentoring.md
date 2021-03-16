# Mentoring

## Reasonable solutions

```java
import java.util.EnumSet;
import java.util.List;
import java.util.stream.Collectors;

public class Allergies {
    private static int allergyScore;

    public Allergies(int allergyScore) {
        this.allergyScore = allergyScore;
    }

    public boolean isAllergicTo(Allergen allergen) {
        return (allergyScore & allergen.getScore()) != 0;
    }

    public List<Allergen> getList() {
        return EnumSet.allOf(Allergen.class).stream()
                .filter(this::isAllergicTo)
                .collect(Collectors.toList());
    }
}
```

## Common suggestions

The student must be encouraged to find a solution using streams.
