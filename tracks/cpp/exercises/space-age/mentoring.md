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
        explicit space_age(const int64_t seconds);
        
        int64_t seconds() const;
        double on_earth() const;
        double on_mercury() const;
        double on_venus() const;
        double on_mars() const;
        double on_jupiter() const;
        double on_saturn() const;
        double on_uranus() const;
        double on_neptune() const;

    private:
        enum class planet : int64_t;
        double on_planet(const planet p) const;
        const int64_t _seconds;
    };
}

#endif // SPACE_AGE_H
```
```cpp
#include "space_age.h"

namespace space_age
{
    enum class space_age::planet : int64_t
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

    space_age::space_age(const int64_t seconds)
    : _seconds(seconds)
    { }

    int64_t space_age::seconds() const
    {
        return _seconds;
    }

    double space_age::on_planet(const planet p) const
    {
        return _seconds * 1.0 / static_cast<int64_t>(p);
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
 * Save seconds as a const in the class
 * Use `constexpr` for the functions.
### Talking points
 * Implementation in header:
 ** This will turn the functions to be implicitly inline, and allow the compiler to do some optimizations on these very small functions.
 ** This also means that every change in the implementation will require a recompile, and will create longer compile time.
