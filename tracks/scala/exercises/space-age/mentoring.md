# Mentoring

## Reasonable solutions

### Simple Solutions

```scala
object SpaceAge {
  def earthAge(ageSeconds: Double): Double = ageSeconds / 31557600D

  def onEarth(ageSeconds: Double): Double = earthAge(ageSeconds) / 1D
  def onMercury(ageSeconds: Double): Double = earthAge(ageSeconds) / 0.2408467
  def onVenus(ageSeconds: Double): Double = earthAge(ageSeconds) / 0.61519726
  def onMars(ageSeconds: Double): Double = earthAge(ageSeconds) / 1.8808158
  def onJupiter(ageSeconds: Double): Double = earthAge(ageSeconds) / 11.862615
  def onSaturn(ageSeconds: Double): Double = earthAge(ageSeconds) / 29.447498
  def onUranus(ageSeconds: Double): Double = earthAge(ageSeconds) / 84.016846
  def onNeptune(ageSeconds: Double): Double = earthAge(ageSeconds) / 164.79132
}
```

```scala
object SpaceAge {
  private val daysToEarthAge = 365.25
  private val daysToMercuryAge = 87.969
  private val daysToVenusAge = 224.701
  private val daysToMarsAge = 686.971
  private val daysToJupiterAge = 4332.59
  private val daysToSaturnAge = 10759.22
  private val daysToUranusAge = 30799.095
  private val daysToNeptuneAge = 60190.03

  private def toEarthDays(seconds: Double): Double = {
    val minutes = seconds.toDouble / 60
    val hours = minutes / 60
    hours / 24
  }

  private def toPlanetAge(daysToPlanetAge: Double, seconds: Double): Double =
    round(toEarthDays(seconds) / daysToPlanetAge)

  private def round(value: Double): Double = (value * 100).round / 100.0

  def onEarth(seconds: Double): Double = toPlanetAge(daysToEarthAge, seconds)
  def onMercury(seconds: Double): Double = toPlanetAge(daysToMercuryAge, seconds)
  def onVenus(seconds: Double): Double = toPlanetAge(daysToVenusAge, seconds)
  def onMars(seconds: Double): Double = toPlanetAge(daysToMarsAge, seconds)
  def onJupiter(seconds: Double): Double = toPlanetAge(daysToJupiterAge, seconds)
  def onSaturn(seconds: Double): Double = toPlanetAge(daysToSaturnAge, seconds)
  def onUranus(seconds: Double): Double = toPlanetAge(daysToUranusAge, seconds)
  def onNeptune(seconds: Double): Double = toPlanetAge(daysToNeptuneAge, seconds)
}
```

### Solution using Dynamics

```scala
import scala.language.dynamics

object SpaceAge extends Dynamic {
  private val EarthSeconds: Double = 31557600

  private val PlanetSeconds: Map[String, Double] = Map(
    "Earth" -> EarthSeconds,
    "Mercury" -> 0.2408467 * EarthSeconds,
    "Venus" -> 0.61519726 * EarthSeconds,
    "Mars" -> 1.8808158 * EarthSeconds,
    "Jupiter" -> 11.862615 * EarthSeconds,
    "Saturn" -> 29.447498 * EarthSeconds,
    "Uranus" -> 84.016846 * EarthSeconds,
    "Neptune" -> 164.79132 * EarthSeconds
  )

  private def age(planet: String, ageSeconds: Double): Double =
    (ageSeconds / PlanetSeconds.getOrElse(planet, EarthSeconds))

  def applyDynamic(planet: String)(ageSeconds: Double) =
    age(planet.substring(2), ageSeconds)
}
```

### Common suggestions

- Magic numbers should not be used within each `on` Planet function.
- The logic to calculate an age on a planet should not be repeated within each  `on` Planet function.

### Talking points

- Scala dynamic can be used to avoid duplicating code for each of the `on` Planet functions.

