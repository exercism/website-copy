# Mentoring

This exercise is meant to teach the relation of classes, instances, methods and properties.

## Reasonable Solution

The main point is about the use of static methods of the class and public properties of the instance. Without those, the test will fail.

There are different strategies for the `generateAbilityScore` method. One can use a loop and two variables to store the sum and the smallest, then return the sum minus the smallest throw. One can also use an Array of dices, which can be created in multiple ways, manually (`[dice(), dice(), ...]`), via the method shown above, `[...Array(4)].map(...)`, or `Array.from({ length: 4 }, () => ...)`. It can either be sorted and sliced or summed up and the smallest throw subtracted.

It is possible to set the values in the constructor by looping over an array with the property names, but that could be considered overengineering.

### Normal solution

```ts
export class DnDCharacter {
  public strength : number;
  public dexterity : number;
  public constitution : number;
  public intelligence : number;
  public wisdom : number;
  public charisma : number;
  public hitpoints : number;
  
  public constructor( 
    strength: number,
    dexterity : number,
    constitution : number,
    intelligence : number,
    wisdom : number,
    charisma : number,
    hitpoints : number
  ) {
    this.strength = DnDCharacter.generateAbilityScore();
    this.dexterity = DnDCharacter.generateAbilityScore();
    this.constitution = DnDCharacter.generateAbilityScore();
    this.intelligence = DnDCharacter.generateAbilityScore();
    this.wisdom = DnDCharacter.generateAbilityScore();
    this.charisma = DnDCharacter.generateAbilityScore();
    this.hitpoints = 10 + DnDCharacter.getModifierFor(this.constitution);
  }
  
  public static generateAbilityScore(): number {
    return [0, 0, 0, 0].map(() => Math.floor(Math.random() * 6 + 1))
      .sort()
      .slice(1)
      .reduce((sum, dice) => sum + dice, 0);
  }
  public static getModifierFor(abilityValue: number): number {
    return Math.floor((abilityValue - 10) / 2);
  }
}
```

If the static methods are defined within the class, there is no way to use them in the instantiation outside of the constructor; to avoid separating the definition of the properties and filling them with values, one can create the functions outside of the class and use them directly for a very optimized solution:

### Optimized solution

```ts
const score = () => {
  const dices = [0, 0, 0, 0].map(() => Math.floor(Math.random() * 6 + 1));
  return dices.reduce((v, d) => v + d, -Math.min(...dices));
};
const mod = (value: number) => Math.floor((value - 10) / 2);

export class DnDCharacter {
  public strength = score();
  public dexterity = score();
  public constitution = score();
  public intelligence = score();
  public wisdom = score();
  public charisma = score();
  public hitpoints = 10 + mod(this.constitution);
  static generateAbilityScore = score;
  static getModifierFor = mod;
}
```

### Prototypal inheritance

JS still supports prototypal inheritance, so instead of a class method, one could also use

```ts
export function DnDCharacter(this: {
  strength: number,
  dexterity: number,
  constitution: number,
  intelligence: number,
  wisdom: number,
  charisma: number,
  hitpoints: number,
}) {
  [this.strength, this.dexterity, this.constitution,
  this.intelligence, this.wisdom, this.charisma] =
    Array.from({ length: 6 }, DnDCharacter.generateAbilityScore);
  this.hitpoints = 10 + DnDCharacter.getModifierFor(this.constitution);
}
DnDCharacter.generateAbilityScore = () => {
  const dices = [...Array(4)].map(() => Math.floor(Math.random() * 6 + 1));
  return dices.reduce((v, d) => v + d, -Math.min(...dices));
}
DnDCharacter.getModifierFor = (value: number) => Math.floor((value - 10) / 2);
```

but as the example shows, this also requires defining the properties before setting them.

## Typical mistakes

* Dice rolls miscalculated as `Math.floor(Math.random() * 6)` or `Math.floor(Math.random() * 5 + 1)`
* Removing not the smallest, but any dice
