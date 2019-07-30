### Reasonable solutions

#### using `Queue`

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
        if (_capacity < 1) throw new InvalidOperationException("Circular buffer capacity needs to be greater than 0 !");
        else return _buffer.Dequeue(); 
    }

    public void Write(T value)
    {
        if (_buffer.Count == _capacity) throw new InvalidOperationException("Circular buffer is full !");
        else _buffer.Enqueue(value);   
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

- try recommend using Queue, instead of Arrays

- capacity and buffer could be made [readonly](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/readonly) - this would prevent changing them outside of the constructor

### Talking points

- within the constructor, the queue should be also initialized (setting the initial capacity). This could bring a  performance optimization on large buffers. 
