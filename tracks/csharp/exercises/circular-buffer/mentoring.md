# Mentoring

### Reasonable solutions

This exercise aims to teach two concepts: queue, as an abstract data structure, and how to use the associated implementation `Queue<T>`. Below you could find two very similar implementations.

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

    public T Read() =>  _buffer.Dequeue(); 

    public void Write(T value)
    {
        if (_buffer.Count == _capacity) 
            throw new InvalidOperationException("Circular buffer is full !");

        _buffer.Enqueue(value);   
    }

    public void Overwrite(T value)
    {
        if (_buffer.Count == _capacity) 
            _buffer.Dequeue();

        _buffer.Enqueue(value);
    }

    public void Clear() => _buffer.Clear();
}
```

#### extending generic collection `Queue<T>`

```csharp
using System;
using System.Collections.Generic;

public class CircularBuffer<T> : Queue<T>
{
   private readonly int _capacity;
   
   public CircularBuffer(int capacity) : base(capacity) => _capacity = capacity;
    
   public T Read() => Dequeue();      
    
   public void Write(T value)
   {
      if (this.Count == _capacity)
            throw new InvalidOperationException("Circular buffer is full !");

      Enqueue(value);
    }

   public void Overwrite(T value)
   {
      if (this.Count == _capacity)
         Dequeue();
       
      Enqueue(value);
    }
}
```

### Common suggestions

- While the queue data structure could be implemented using a different type of collection (e.g. `Array<T>`), it is much easier to do this with `Queue<T>`.     

- To achieve better performance, the queue should be initialized in the constructor, by setting the initial capacity. This initialization would be preferred to small, and incremental memory allocations. 

- An additional advantage for setting the initial capacity comes with the implicit check of the capacity. If this is not valid then an exception will be raised (`ArgumentOutOfRangeException: Non-negative number required.`)   

### Talking points

- The class fields should be made [readonly](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/readonly) - by doing this we could prevent changing their values outside of the constructor.

- By inheriting from Queue<T> we achieve a cleaner version. However, this would be slightly more complex, so it should not be suggested as first solution.

- Some students may try to implement the queue mechanism from scratch. This is a good thing and it should not be discouraged. Still, they should also try using .NET implementation (`Queue<T>`).
