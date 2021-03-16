# Mentoring

## Reasonable Solutions

```swift
class Squares {
    let maxNum: Int
    
    lazy var squareOfSum: Int = {
        return (0...self.maxNum).sum.squared
    }()
    
    lazy var sumOfSquares: Int = {
        return (0...self.maxNum).eachSquared.sum
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

extension Sequence where Element: Numeric {
    var sum: Element {
        return reduce(0, +)
    }
    
    var eachSquared: [Element] {
        return self.map { $0.squared }
    }
}
```

## Common suggestions

- Sometimes students will try to do all of the computations within the init method. This is not optimal when numbers get very large; the cost of computation starts to rise. So the use of lazy variables is strongly encouraged so that computation is only done if needed.
- Encourage the use of reduce here. It's a perfect place to understand exactly what this function does and how powerful it can be.
- In addition it is a great place to teach students about the power of ranges. You can assemble a range in a variety of ways, however the syntactial sugar of `...` is the simpliest and most straight forward.

## Talking Points

- The extensions on sequence make each line within the Squares class more delarative, and while optimal they should not be required to allow a student to pass and continue on.
- Additionally students could do all of the of the computation inside the init. This saves them from having to store the `maxNum`, but forces the computation of every variable at initialization time (potentially taxing). The solution here takes the trade off of saving the Int (a relatively small amount of memory) to delay to computation of each variable (which is still only done once with the lazy vars).
- Some students may generate Arrays of numbers instead of using the range operators to generate the numbers from 0 to the max int. Ranges should be the prefered way since they take up less memory than an Array and are far easier to generate.
