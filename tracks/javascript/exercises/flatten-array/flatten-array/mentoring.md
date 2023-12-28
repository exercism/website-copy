recursive approach

function flattenArray(arr) {
  let result = [];
  
  arr.forEach(item => {
    if (Array.isArray(item)) {
      result = result.concat(flattenArray(item));
    } else if (item !== null) {
      result.push(item);
    }
  });
  
  return result;
}

const input = [1, [2, 3, null, 4], [null], 5];
const output = flattenArray(input);
console.log(output);
