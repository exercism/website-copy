# Mentoring

## Reasonable solutions

### With iterators

```C++
#if !defined(CIRCULAR_BUFFER_H_)
#define CIRCULAR_BUFFER_H_

#include <vector>
#include <stdexcept>

namespace circular_buffer {

template <typename ValueType>
class circular_buffer {
    using buf_iter = typename std::vector<ValueType>::iterator;
public:
    circular_buffer(std::size_t capacity) 
        : buffer(capacity), head(buffer.begin()), tail(head), full(false) {}

    ValueType read() {
        if (is_empty())
            throw std::domain_error("Circular buffer is empty.");

        ValueType item = *head;
        move_position(head);
        full = false;
        return item;
    }

    void write(ValueType item) {
        if (full)
            throw std::domain_error("Circular buffer is full.");

        push_back(item);
        full = head == tail;
    }

    void overwrite(ValueType item) {
        if (full)
            move_position(head);

        push_back(item);
        full = head == tail;
    }

    void clear() {
        head = tail;
        full = false;
    }

private:
    std::vector<ValueType> buffer;
    buf_iter head;
    buf_iter tail;
    bool full;

    void push_back(ValueType item) {
        *tail = item;
        move_position(tail);
    }

    void move_position(buf_iter& position) {
        ++ position;
        if(position == buffer.end())
            position = buffer.begin();
    }
    bool is_empty() const { return !full && head == tail; }
};
}

#endif
```

### With indexes

```C++
#if !defined(CIRCULAR_BUFFER_H_)
#define CIRCULAR_BUFFER_H_

#include <vector>
#include <stdexcept>

namespace circular_buffer {

template <typename ValueType>
class circular_buffer {
public:
    circular_buffer(std::size_t capacity) 
        : buffer_(capacity + 1), head_(0), tail_(0) {}
    ValueType read();
    void write(ValueType item);
    void overwrite(ValueType item);
    void clear() { head_ = tail_; }

private:
    std::vector<ValueType> buffer_;
    std::size_t head_;
    std::size_t tail_;

    void push_back(ValueType item);
    void move_position(std::size_t& position) { position = (position + 1) % buffer_.size(); }
    bool is_empty() const { return head_ == tail_; }
    bool is_full() const { return head_ == (tail_ + 1) % buffer_.size(); }
};

template <typename ValueType>
ValueType circular_buffer<ValueType>::read() {
    if (is_empty()) throw std::domain_error("Circular buffer is empty."); 
    ValueType item = buffer_[head_];
    move_position(head_);
    return item;
}

template <typename ValueType>
void circular_buffer<ValueType>::write(ValueType item) {
    if (is_full()) throw std::domain_error("Circular buffer is full.");
    push_back(item);
}

template <typename ValueType>
void circular_buffer<ValueType>::overwrite(ValueType item) {
    if (is_full()) move_position(head_);
    push_back(item);
}

template <typename ValueType>
void circular_buffer<ValueType>::push_back(ValueType item) {
    buffer_[tail_] = item;
    move_position(tail_);
}

}

#endif
```

### Common suggestions

* In `clear`, the underlying object should not be `clear`ed as well (if it is a standard library container, like `vector`). This is because clearing a standard library container almost always **removes** all the elements, rather than resetting them. There is no need to reset the objects either - simply resetting the iterators / indexes should suffice.
* If the solution uses a *non-fixed-size* container, it should be pointed out that a *fixed-size* container should be used for this exercise. Something like a `vector` is fine, as long as it is initialized with a given size / resized once.
