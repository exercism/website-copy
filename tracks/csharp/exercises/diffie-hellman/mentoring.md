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


### Common suggestions: Good suggestions specific to this exercise. Good lessons that emerge from it.

- Talk about limitations of built in methods `Random.Next(Int32)` or `BigInteger.Pow(BigInteger, Int32)`. 
- Talk about support for *standard* operations `Random.ModPow(BigInteger, BigInteger, BigInteger)`. (https://docs.microsoft.com/en-us/dotnet/api/system.numerics.biginteger.modpow?view=net-6.0)
- Ensure zero is excluded from the random range!

### Talking points: Questions to challenge more advance learners with.

There is no easy way to generate a BigInteger random number. There are many options, one example is here:
https://gist.github.com/rharkanson/50fe61655e80488fcfec7d2ee8eff568. 

But this might be too much for some, and perhaps the generation of a 32 bit integer could be used as a starting point for a discussion about limitations
of the standard libraries as well as implications of 'shortcuts' like that have on security of solutions. In this example, the standard libraries support `BigInteger` operations typical in secuirty applications with the `BigInteger.ModPow()` function. Without it, there is a lot of casting to do. But there is no good way to generate a random `BigInteger` necessary for a lot of securitity tasks. The use of `random.Next((int)primeP)` appears to be working, the tests pass, but the solution is not what it seems as the returned random numbers are of `BigInteger` type, but all fall within the 64 bit integer range. 
