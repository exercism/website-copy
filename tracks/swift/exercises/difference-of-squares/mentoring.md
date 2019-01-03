# Difference of Squares

_Differences of Squares_ is a core exercise, unlocked after _Gigasecond_.

## Reasonable Solutions

```swift
class Squares {
    let maxNum: Int
    
    lazy var squareOfSum: Int = {
        let sum = (0...self.maxNum).reduce(0, { $0 + $1 })
        return sum.squared
    }()
    
    lazy var sumOfSquares: Int = {
        return (0...self.maxNum).reduce(0, { $0 + $1.squared })
    }()
    
    lazy var differenceOfSquares: Int = {
        return self.squareOfSum - self.sumOfSquares
    }()
    
    init(_ maxNum: Int) {
        self.maxNum = maxNum
    }
}

extension Numeric {
    var squared: Self {
        return self * self
    }
}
```

## Common suggestions

- Sometimes students will try to do all of the computations within the init method. This is not optimal when numbers get very large; the cost of computation starts to rise. So the use of lazy variables is strongly encouraged.
- Encourage the use of reduce here. It's a perfect place to understand exactly what this function does and how powerful it can be.
- In addition it is a great place to teach students about the power of ranges. You can assemble a range in a variety of ways, however the syntactial sugar of `...` is the simpliest and most straight forward.

## Next Level Additions
- You can take this to the next level with some extra extensions on sequences to do the heavy lifting of summing and squaring: (but this is more advanced and not required for an easy level problem)
```swift
extension Sequence where Element: Numeric {
    var sum: Element {
        return reduce(0, +)
    }
    
    var eachSquared: [Element] {
        return self.map { $0.squared }
    }
}
```
