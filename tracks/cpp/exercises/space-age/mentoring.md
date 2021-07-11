### Reasonable solutions

```cpp
#if !defined(SPACE_AGE_H)
#define SPACE_AGE_H

#include <cstdint>

namespace space_age
{
    class space_age final
    {
    public:
        explicit space_age(const std::int64_t seconds);
        
        std::int64_t seconds() const;
        double on_earth() const;
        double on_mercury() const;
        double on_venus() const;
        double on_mars() const;
        double on_jupiter() const;
        double on_saturn() const;
        double on_uranus() const;
        double on_neptune() const;

    private:
        enum class planet : std::int64_t;
        double on_planet(const planet p) const;
        std::int64_t _seconds;
    };
}

#endif // SPACE_AGE_H
```
```cpp
#include "space_age.h"

namespace space_age
{
    enum class space_age::planet : std::int64_t
    {
        Earth = 31557600,
        Mercury = 7600544,
        Venus = 19414149,
        Mars = 59355036,
        Jupiter = 374355660,
        Saturn = 929292360,
        Uranus = 2651370000,
        Neptune = 5200418600,
    };

    space_age::space_age(const std::int64_t seconds)
    : _seconds(seconds)
    { }

    std::int64_t space_age::seconds() const
    {
        return _seconds;
    }

    double space_age::on_planet(const planet p) const
    {
        return static_cast<double>(_seconds) / static_cast<std::int64_t>(p);
    }

    double space_age::on_earth() const
    {
        return on_planet(planet::Earth);
    }

    double space_age::on_mercury() const
    {
        return on_planet(planet::Mercury);
    }

    double space_age::on_venus() const
    {
        return on_planet(planet::Venus);
    }

    double space_age::on_mars() const
    {
        return on_planet(planet::Mars);
    }

    double space_age::on_jupiter() const
    {
        return on_planet(planet::Jupiter);
    }

    double space_age::on_saturn() const
    {
        return on_planet(planet::Saturn);
    }

    double space_age::on_uranus() const
    {
        return on_planet(planet::Uranus);
    }

    double space_age::on_neptune() const
    {
        return on_planet(planet::Neptune);
    }
}
```
### Common suggestions

 * Make sure the data type is big enough to store a 33 bit value (needed for neptune)
 * Make sure the data type is consistent (constructor, class member and return type from `seconds()`)
 * Constants should be static.
 * Arguments with names that indicate the units used.
 * Use `constexpr` for the functions.
### Talking points

 * `explicit` constructor so you don't accidently do a type casting. [examples](https://en.cppreference.com/w/cpp/language/explicit).
 * Prefer initialization over assignment. [Good explanation](https://stackoverflow.com/a/7350783)
 * Being explicit about units.
 * `signed` vs. `unsigned`.
   * `unsigned` can give some surprising results. [example](isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#es102-use-signed-types-for-arithmetic)
 * `double` vs. `float`
 * Implementation in header:
   * This will turn the functions to be implicitly inline, and allow the compiler to do some optimizations on these very small functions.
   * This also means that every change in the implementation will require a recompile, and will create longer compile time.
 * `const` on seconds
   * We don't want to change it, so we can declare it const so we don't accidentally do something stupid.
   * This won't allow us to use the assignment operator. Not needed for the exercise, but might be unintended.
