### Reasonable solution

#### using `Queue`
This exercise aims to teach two concepts: queue, as an abstract data structure, and how to use the associated implementation `Queue<T>`.

```csharp
using System;
using System.Collections.Generic;

public class CircularBuffer<T>
{
    private readonly int _capacity;
    private readonly Queue<T> _buffer;

    public CircularBuffer(int capacity)
    {
        _capacity = capacity;
        _buffer = new Queue<T>(capacity);
    }

    public T Read()
    {
        if (_capacity < 1) 
            throw new InvalidOperationException("Circular buffer capacity needs to be greater than 0 !");
        else 
            return _buffer.Dequeue(); 
    }

    public void Write(T value)
    {
        if (_buffer.Count == _capacity) 
            throw new InvalidOperationException("Circular buffer is full !");
        else 
            _buffer.Enqueue(value);   
    }

    public void Overwrite(T value)
    {
        if (_buffer.Count==_capacity) _buffer.Dequeue();
        _buffer.Enqueue(value);
    }

    public void Clear() => _buffer.Clear();
}
```

### Common suggestions

- While the queue data structure could be implemented using a different type of collection (e.g. `Array<T>`), it is much easier to do this with `Queue<T>`. 

- To achieve better performance, the queue should be initialized in the constructor (setting the initial capacity). This initialization would be preferred to small, and incremental memory allocations.

### Talking points

- The class fields should be made [readonly](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/readonly) - by doing this we could prevent changing their values outside of the constructor.
