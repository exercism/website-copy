# Mentoring

## Reasonable solutions

### Using for loop iteration

```java
class BirdWatcher {
    private int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay;
    }

    public int[] getLastWeek() {
        return birdsPerDay;
    }

    public int getToday() {
        return birdsPerDay.length > 0 ? birdsPerDay[birdsPerDay.length - 1] : 0;
    }

    public int incrementTodaysCount() {
        return ++birdsPerDay[birdsPerDay.length - 1];
    }

    public boolean hasDayWithoutBirds() {
        for (int dailyBirdCount : birdsPerDay) {
            if (dailyBirdCount == 0) {
                return true;
            }
        }
        return false;
    }

    public int getCountForFirstDays(int numberOfDays) {
        int visitingBirdsCount = 0;
        for (int i = 0; i < Math.min(numberOfDays, birdsPerDay.length); i++) {
            visitingBirdsCount += birdsPerDay[i];
        }
        return visitingBirdsCount;
    }

    public int getBusyDays() {
        int busyDaysCount = 0;
        for (int dailyBirdCount : birdsPerDay) {
            if (dailyBirdCount >= 5) {
                busyDaysCount++;
            }
        }
        return busyDaysCount;
    }
}
```

## Using streams

```java
import java.util.Arrays;

class BirdWatcher {
    private final int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay;
    }

    public int[] getLastWeek() {
        return birdsPerDay;
    }

    public int getToday() {
        return birdsPerDay.length == 0 ? 0 : birdsPerDay[birdsPerDay.length - 1];
    }

    public int incrementTodaysCount() {
        return ++birdsPerDay[birdsPerDay.length - 1];
    }

    public boolean hasDayWithoutBirds() {
        return Arrays.stream(birdsPerDay).anyMatch(birds -> birds == 0);
    }

    public int getCountForFirstDays(int numberOfDays) {
        return Arrays.stream(birdsPerDay, 0, Math.min(birdsPerDay.length, numberOfDays))
            .sum();
    }

    public int getBusyDays() {
        return (int) Arrays.stream(birdsPerDay).filter(this::isBusyDay).count();
    }

    private boolean isBusyDay(int birds) {
        return birds >= 5;
    }
}
```

## Common suggestions

- Leverage common Java libraries like `Math.min`

## Talking points

### Defensive copying

In general, we want to use defensive copies to protect the encapsulation of our mutable state.
Currently, the exercise does not follow this practice, but it is something we can discuss with students.
