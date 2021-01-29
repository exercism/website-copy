Using a map is a perfectly natural idea in this kind of situation. However, be careful:
because maps are implemented as hash tables, the order of their keys is not guaranteed. 
In fact, when iterating over the keys of a map, they will be in a different, random order each time.
See the `Iteration order` section of [Go maps in action](https://blog.golang.org/go-maps-in-action).
If the iteration order matters, a slice is a better choice.
