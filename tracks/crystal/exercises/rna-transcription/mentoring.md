# Mentoring

## Reasonable Solutions

There are two general approaches to this problem. Crystal has a more-or-less purpose-designed method for this problem in `String#tr`.
```crystal
module RnaComplement
  def self.of_dna(strand)
    strand.tr("CGTA", "GCAU")
  end
end
```
This could be critiqued for having an uninformative name (it's named after little-known a [Unix utility][tr]), and for obscuring the associative relation between the input and output characters. Solutions which use a `case` statement to translate characters should be avoided.
```crystal
module RnaComplement
  DNA_TO_RNA = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  def self.of_dna(strand)
    strand.gsub(DNA_TO_RNA)
  end
end
```
There are a variety of solutions which use a `Hash` to translate the characters, but `gsub` is the most concise of these.

## Common Suggestions

The problem does not require the creation of any kind of object, and given that the optimal solutions here consist of a single method call, the instantiation of an object is probably unjustifiable. Crystal recommends using `Struct` when possible for performance reasons, but `Module` works just as well; `Struct` is not a requirement.

If a `Hash` is used, `DNA_TO_RNA` would be a relatively traditional name for that constant. One can also assign the strings used with `tr` to constants, but `DNA_BASES = "GCTA"` doesn't necessarily convey that it is a collection. There are a few different ways to write this `Hash`, none of which are more preferable than the others.

[tr]: https://en.wikipedia.org/wiki/Tr_(Unix)
