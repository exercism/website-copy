# Mentoring
## Reasonable solutions

```csharp
using System;

abstract class Character
{
    protected string CharacterType { get; }

    protected Character(string characterType)
    {
        CharacterType = characterType;
    }

    public sealed override string ToString() => $"Character is a {CharacterType}";

    public abstract int DamagePoints(Character target);

    public virtual bool Vulnerable() => false;
}

class Warrior : Character
{
    public Warrior() : base("Warrior") { }

    public override int DamagePoints(Character target) => target.Vulnerable() ? 10 : 6;
}

class Wizard : Character
{
    private bool SpellPrepared { get; set; } = false;

    public Wizard() : base("Wizard") { }

    public void PrepareSpell() => SpellPrepared = true;

    public override bool Vulnerable() => !SpellPrepared;

    public override int DamagePoints(Character target) => SpellPrepared ? 12 : 3;
}
```


## Talking Points

###  Encapsulation using properties
- Use **properties** instead of fields to enhance encapsulation and readability.
- Example: `CharacterType` and `SpellPrepared` are implemented as properties.

###  Mark methods with sealed
- Mark methods like `ToString` as `sealed` to prevent unnecessary overriding in derived classes.

###  Expression-bodied members
- Simplify methods with single-line logic using **expression-bodied members**.
- Example: 
  ```csharp
  public override bool Vulnerable() => !SpellPrepared;
  ```

### Use of readonly fields
- Use `readonly` for fields that are initialized once and remain constant.
- Example: `CharacterType` can be declared as `readonly`.

### Constructor Chaining
- Use **constructor chaining** for clarity when initializing class members.
- Example:
  ```csharp
  public Warrior() : this("Warrior") { }
  ```

### Abstract Classes and Polymorphism
- The `Character` class is abstract, demonstrating the concept of polymorphism in C#.
- Derived classes (`Warrior` and `Wizard`) implement their own behavior for `DamagePoints` and `Vulnerable`.



## Additional Resources

- [Properties (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties)
- [sealed Modifier (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/sealed)
- [Expression-bodied Members (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members)
- [readonly (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/readonly)
- [Using Constructors (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/using-constructors)
- [Abstract Classes and Members (C#)](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/abstract)
