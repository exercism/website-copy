:warning: The following notes are for a version of the exercise that does not involve the use of generics (see this [issue](https://github.com/exercism/java/issues/1507) for more information). To validate a solution involving generics, use [this test](https://github.com/exercism/java/blob/65e2f240123b3357e310881bc5f2c29e92009343/exercises/binary-search/src/test/java/BinarySearchTest.java).

### Reasonable solutions

#### Using a while-loop
```java

import java.util.List;

class BinarySearch {

    private List<Integer> array;
    private int arraySize;

    BinarySearch(List<Integer> array) {
        this.array = array;
        this.arraySize = array.size();
    }

    int indexOf(int value) {
        return search(value);
    }

    private int search(int value) {
        int left = 0;
        int right = arraySize - 1;

        while (left <= right) {
            int middle = (left + right) / 2;
            int element = array.get(middle);

            if (value > element) {
                left = middle + 1;
            } else if (value < element) {
                right = middle - 1;
            } else {
                return middle;
            }
        }

        return -1;
    }
}
```

#### Using recursion
```java

import java.util.List;

class BinarySearch {

    private List<Integer> array;
    private int arraySize;

    BinarySearch(List<Integer> array) {
        this.array = array;
        this.arraySize = array.size();
    }

    int indexOf(int value) {
        return search(value, 0, arraySize - 1);
    }

    private int search(int value, int left, int right) {
        if (left > right) {
            return -1;
        }

        int middle = (left + right) / 2;
        int element = array.get(middle);

        if (value > element) {
            return search(value, middle + 1, right);
        } else if (value < element) {
            return search(value, left, middle - 1);
        } else {
            return middle;
        }
    }
}
```

### Common suggestions

- Use `left + (right - left) / 2` instead of `(left + right) / 2` to avoid overflow. _See [Nearly All Binary Searches and Mergesorts are Broken](https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html) by Joshua Bloch._

### Talking points

- Precomputing `arraySize` is correct only if we assume that the size of `array` will never change. However, without a defensive copy (which could be inefficient) this is not true.
- Recursion is safe for binary search because it require at most _log2(n)_ stack frames, where _n_ is the size of the array. Nevertheless, a while-loop uses less memory.
