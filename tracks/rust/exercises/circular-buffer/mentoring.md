### Concepts

- [Defining Error Types](https://doc.rust-lang.org/rust-by-example/error/multiple_error_types/define_error_type.html)
- [Trait Bounds](https://doc.rust-lang.org/rust-by-example/generics/bounds.html)

### Reasonable Solutions

A reasonable solution should:

- Return an `Error` when appropriate
- Limit the use of `unwrap`
- Exhibit Separation of Concerns by defining additional helper functions to perform logically distinct operations

#### Examples

Solution that is generic over types that adhere to the `Default` and `Clone` constraints:

```rust
#[derive(Debug, PartialEq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

pub struct CircularBuffer<T: Default + Clone> {
    buffer: Vec<T>,
    size: usize,
    start: usize,
    end: usize,
}

impl<T: Default + Clone> CircularBuffer<T> {
    // this circular buffer keeps an unallocated slot between the start and the end
    // when the buffer is full.
    pub fn new(size: usize) -> CircularBuffer<T> {
        CircularBuffer {
            buffer: vec![T::default(); size + 1],
            size: size + 1,
            start: 0,
            end: 0,
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        if self.is_empty() {
            return Err(Error::EmptyBuffer);
        }

        let v = self.buffer[self.start].clone();
        self.advance_start();
        Ok(v)
    }

    pub fn write(&mut self, byte: T) -> Result<(), Error> {
        if self.is_full() {
            return Err(Error::FullBuffer);
        }

        self.buffer[self.end] = byte;
        self.advance_end();
        Ok(())
    }

    pub fn overwrite(&mut self, byte: T) {
        if self.is_full() {
            self.advance_start();
        }

        self.buffer[self.end] = byte;
        self.advance_end();
    }

    pub fn clear(&mut self) {
        self.start = 0;
        self.end = 0;

        // Clear any values in the buffer
        for element in self.buffer.iter_mut() {
            std::mem::take(element);
        }
    }

    pub fn is_empty(&self) -> bool {
        self.start == self.end
    }

    pub fn is_full(&self) -> bool {
        (self.end + 1) % self.size == self.start
    }

    fn advance_start(&mut self) {
        self.start = (self.start + 1) % self.size;
    }

    fn advance_end(&mut self) {
        self.end = (self.end + 1) % self.size;
    }
}
```

Solution that doesn't impose `Default` and `Clone` bounds over the generic type:

```rust
pub struct CircularBuffer<T> {
    buffer: Vec<Option<T>>,
    start: usize, // read index
    end: usize,   // write index
}

#[derive(Debug, PartialEq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T> CircularBuffer<T> {
    pub fn new(capacity: usize) -> Self {
        CircularBuffer {
            buffer: (0..capacity).map(|_| None).collect(),
            start: 0,
            end: 0,
        }
    }

    pub fn write(&mut self, element: T) -> Result<(), Error> {
        match self.buffer[self.end] {
            Some(_) => Err(Error::FullBuffer),
            None => {
                self.buffer[self.start] = Some(element);
                self.advance_end();
                Ok(())
            }
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        self.buffer[self.start]
            .take()
            .ok_or(Error::EmptyBuffer)
            .map(|elem| {
                self.advance_start();
                elem
            })
    }

    pub fn clear(&mut self) {
        self.start = 0;
        self.end = 0;

        self.buffer.iter_mut().for_each(|elem| *elem = None);
    }

    pub fn overwrite(&mut self, element: T) {
        if self.buffer[self.start].is_some() {
            self.advance_start();
        }

        self.buffer[self.end] = Some(element);
        self.advance_end();
    }

    fn advance_start(&mut self) {
        self.start = (self.start + 1) % self.buffer.len();
    }

    fn advance_end(&mut self) {
        self.end = (self.end + 1) % self.buffer.len();
    }
}

```

### Common Suggestions

TODO