# use of naked returns

The Go community recommends avoiding *naked returns* (or *bare returns*) under normal circumstances,
as they typically make code harder to read.
See the [official Go code review guide](https://github.com/golang/go/wiki/CodeReviewComments#naked-returns) for details.
There is a [proposal](https://github.com/golang/go/issues/21291) to remove bare returns altogether in Go 2.
