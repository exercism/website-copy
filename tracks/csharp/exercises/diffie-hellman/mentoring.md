### Reasonable solutions: 

```csharp
static class DiffieHellman
{
  private static readonly Random _random = new Random();

  public static BigInteger PrivateKey(BigInteger primeP) 
    => new BigInteger(1+_random.Next((int)primeP));

  public static BigInteger PublicKey(BigInteger primeP, BigInteger primeG, BigInteger privateKey) 
    => BigInteger.ModPow(primeG, privateKey, primeP);

  public static BigInteger Secret(BigInteger primeP, BigInteger publicKey, BigInteger privateKey) 
    => BigInteger.ModPow(publicKey, privateKey, primeP);
}
```


### Common suggestions: 
*Good suggestions specific to this exercise. Good lessons that emerge from it.*

- Talk about limitations of built in methods `Random.Next(Int32)` 
[(docs)](https://docs.microsoft.com/en-us/dotnet/api/system.random.next) 
or `BigInteger.Pow(BigInteger, Int32)` [(docs)](https://docs.microsoft.com/en-us/dotnet/api/system.numerics.biginteger.pow). 
- Talk about support for *standard* operations `BigInteger.ModPow(BigInteger, BigInteger, BigInteger)`
[(docs)](https://docs.microsoft.com/en-us/dotnet/api/system.numerics.biginteger.modpow).
- Ensure zero is excluded from the random range! It can cause intermittent test failures.


### Talking points: 
*Questions to challenge more advance learners with.*

There is no easy way to generate a BigInteger random number. 
There are many options, one example is [in this gist](https://gist.github.com/rharkanson/50fe61655e80488fcfec7d2ee8eff568).

But this might be too much for some. 
Perhaps the generation of a 32 bit integer could be used as a starting point 
for a discussion about limitations of the standard libraries and implications of 'shortcut' solutions. 
In this example, the standard libraries support `BigInteger` operations typical in secuirty applications with the `BigInteger.ModPow()` function. 
Without it, there is a lot of casting to do. 
But there is no good way to generate a random `BigInteger` necessary for a lot of security tasks. 
The use of `random.Next((int)primeP)` appears to be working, the tests pass, but the solution is not what it seems.
The returned random numbers are of `BigInteger` type, but all the values fall within the 32 bit positive integer range. 
