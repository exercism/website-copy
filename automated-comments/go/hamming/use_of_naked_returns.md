`Naked returns` (or `bare returns`) are considered evil by most of the Go community. Simply because they make code harder to read.
The official [Go code review guide](https://github.com/golang/go/wiki/CodeReviewComments#naked-returns) suggests to avoid them if the function has more than a few lines of code.
There is also a [proposal](https://github.com/golang/go/issues/21291) to remove bare returns altogether in Go 2.
My suggestin would be to avoid them.