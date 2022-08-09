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

There is no easy way to generate a BigInteger random number. There is many options, and one example is here 
https://gist.github.com/rharkanson/50fe61655e80488fcfec7d2ee8eff568. 

But this might be too much for some and perhaps the generation of a 32 integer could be used as a starting point for a discussiona bout limitations
of the standard libraries as well as implications of 'shortcuts' like that have on security of solutions. 
