### Reasonable solutions
```cpp
#if !defined(_SPACE_AGE_H_)
#define _SPACE_AGE_H_

#include <cstdint>

namespace space_age
{
    class space_age final
    {
    public:
        explicit space_age(const uint64_t seconds);
        
        uint64_t seconds() const;
        double on_earth() const;
        double on_mercury() const;
        double on_venus() const;
        double on_mars() const;
        double on_jupiter() const;
        double on_saturn() const;
        double on_uranus() const;
        double on_neptune() const;

    private:
        enum class planet : uint64_t;
        double on_planet(const planet p) const;
        const uint64_t _seconds;
    };
}

#endif // _SPACE_AGE_H_
```
```cpp
#include "space_age.h"

namespace space_age
{
    enum class space_age::planet : uint64_t
    {
        EARTH = 31557600,
        MERCURY = 7600544,
        VENUS = 19414149,
        MARS = 59355036,
        JUPITER = 374355660,
        SATURN = 929292360,
        URANUS = 2651370000,
        NEPTUNE = 5200418600,
    };

    space_age::space_age(const uint64_t seconds)
    : _seconds(seconds)
    { }

    uint64_t space_age::seconds() const
    {
        return _seconds;
    }

    double space_age::on_planet(const planet p) const
    {
        return _seconds * 1.0 / static_cast<uint64_t>(p);
    }

    double space_age::on_earth() const
    {
        return on_planet(planet::EARTH);
    }

    double space_age::on_mercury() const
    {
        return on_planet(planet::MERCURY);
    }

    double space_age::on_venus() const
    {
        return on_planet(planet::VENUS);
    }

    double space_age::on_mars() const
    {
        return on_planet(planet::MARS);
    }

    double space_age::on_jupiter() const
    {
        return on_planet(planet::JUPITER);
    }

    double space_age::on_saturn() const
    {
        return on_planet(planet::SATURN);
    }

    double space_age::on_uranus() const
    {
        return on_planet(planet::URANUS);
    }

    double space_age::on_neptune() const
    {
        return on_planet(planet::NEPTUNE);
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
