In the problem statement, the colors and its code are already mentioned. So first let us define an array of colors.

```
export const COLORS = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white',
]
```

Now we have an array, we can directly get code by fetching the index of the parameter color in the array and use the Array.indexOf() to achieve our results.

```
export const colorCode = (color: string) => {
  return COLORS.indexOf(color); 
}
```
