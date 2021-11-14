# multiline string

To comfortably work with texts with a lot of newlines, use the triple-double-quote heredoc syntax.

```elixir
# preferred

"""
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     #{i1}  +  #{i2}     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"""

# not preferred

"     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     #{i1}  +  #{i2}     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
```

