### Topics Covered:
1. <a href="https://www.w3schools.com/typescript/typescript_arrays.php" target=_blank> Array in Typescript</a>
2. <a href="https://www.tutorialspoint.com/typescript/typescript_array_indexof.htm" target=_blank>Get index using inbuilt function</a>

In the problem statement, the colors and their code are already mentioned. So first let us define an array of colors.
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

Now we have an array, we can directly get code by fetching the index of the parameter color in the array and using the Array.indexOf() to achieve our results.

```
export const colorCode = (color: string) => {
  return COLORS.indexOf(color); 
}
```
