### Reasonable solutions

```elixir
defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  defstruct focus: nil, path: []

  @doc """
  Get a z focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt) do
    %Zipper{focus: bt}
  end

  @doc """
  Get the complete tree from a z.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(z = %Zipper{path: []}) do
    z.focus
  end

  def to_tree(z = %Zipper{path: [{:left, focus} | tail]}) do
    to_tree(%Zipper{focus: %BinTree{focus | left: z.focus}, path: tail})
  end

  def to_tree(z = %Zipper{path: [{:right, focus} | tail]}) do
    to_tree(%Zipper{focus: %BinTree{focus | right: z.focus}, path: tail})
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(%{focus: %{value: value}}) do
    value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil

  def left(%Zipper{focus: %{left: nil}}) do
    nil
  end

  def left(z = %Zipper{focus: %{left: left_child}, path: path}) do
    %Zipper{focus: left_child, path: [{:left, z.focus} | path]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Zipper{focus: %{right: nil}}) do
    nil
  end

  def right(z = %Zipper{focus: %{right: right_child}, path: path}) do
    %Zipper{focus: right_child, path: [{:right, z.focus} | path]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up(%Zipper{path: []}) do
    nil
  end

  def up(z = %Zipper{path: [{:left, focus} | tail]}) do
    %Zipper{focus: %BinTree{focus | left: z.focus}, path: tail}
  end

  def up(z = %Zipper{path: [{:right, focus} | tail]}) do
    %Zipper{focus: %BinTree{focus | right: z.focus}, path: tail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(%Zipper{focus: focus, path: path}, v) do
    %Zipper{focus: %BinTree{focus | value: v}, path: path}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(z = %Zipper{focus: focus}, l) do
    %Zipper{z | focus: %BinTree{focus | left: l}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(z = %Zipper{focus: focus}, r) do
    %Zipper{z | focus: %BinTree{focus | right: r}}
  end
end
```

### Common suggestions

#### Use the map update syntax

```
%Zipper{focus: %BinTree{focus | left: z.focus}, path: tail}
```