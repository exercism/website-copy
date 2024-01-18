# Pig Latin

### Reasonable solutions:

There is a (somewhat) reasonable solution using regular expressions, however most students are likely to use a combination of `strings` funtions or string slicing to solve this problem.

Solutions vary considerably, but most reasonable solutions should demonstrate these three insights:

1. Decoupled logic to break down a sentence into words and reform the Pig Latin sentence.

```
func Sentence(sentence string) string {
	words := strings.Fields(sentence)
	pigWords := make([]string, 0, len(words))
	for _, w := range words {
		pigWords = append(pigWords, pigWord(w))
	}
	return strings.Join(pigWords, " ")
}
```

2. Identify that some number of consonants (according to the rules) will be added moved to the end of the word and "ay" will be added to the end of the word.

```
func pigWord(word string) string {
	consonants := consonantCount(word)
	return fmt.Sprintf("%s%say", word[consonants:], word[:consonants])
}
```

3. Identify how many letters count as consonants.

```
func consonantCount(word string) int {
	if strings.HasPrefix(word, "xr") || strings.HasPrefix(word, "yt") {
		return 0
	}
	for i, r := range word {
		switch r {
		case 'a', 'e', 'i', 'o':
			return i
		case 'u':
			if i > 0 && word[i-1] == 'q' {
				// When a 'qu' is together, the u is also moved to the end of the word
				return i + 1
			}
			return i
		case 'y':
			if i == 0 {
				// Leading y is not considered a vowel
				continue
			}
			return i
		}
	}
	return 0
}
```

It is possible to combine parts 2 and 3, but this often leads to less readable code that repeats parts of the logic to form the pig latin word.

### Common suggestions:
* Avoid complex, deeply nested logic.
* Reduce the number of special cases by generalizing logic.  For instance, the first vowel in the word can potentially be handled the same, regardless of whether it is at the start of the word or not.
* Prefer switch/case to long if/else chains.
* Add explanatory comments when the intent of the code might not be clear to the reader.
* `gofmt` ensures consistent formatting, and is standard across most of the Go community.

### Talking points
* `rune` vs `byte` and why iterating over a string with `range` returns runes: [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings)
* The test cases do not include uppercase letters. How would the student's solution have to change to handle uppercase letters?
* `fmt.Sprintf` and `strings.Builder` are more common than using the `+` operator to concatenate strings.
