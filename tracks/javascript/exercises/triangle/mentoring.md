# Mentoring

Most students compare side with magic numbers

 **Example:** `this.side[0] === this.sides[3]`

 It would be a good opportunity to explain why **magic numbers** is not the better approach.

 Also it's a good opportunity to introduce the students to **destructuring assignment**.

 **Example**:

 ```javascript
const [smallestSide] = this.sortedSides;
return smallestSide !== 0
 ```
