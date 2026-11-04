# Mentoring

## Reasonable solutions
```cpp
#include <string>

namespace atbash_cipher
{

std::string apply_cypher(std::string aStr);
std::string apply_spaces(const std::string& aStr);

std::string encode(const std::string& aStr)
{
	auto str = apply_cypher(aStr);
	return apply_spaces(str);
}

std::string apply_spaces(const std::string& aStr)
{
	std::string out;
	out.reserve(aStr.length() + aStr.length() / 5);
	for(size_t i = 0; i < aStr.length(); ++i)
	{
		if(0 != i && 0 == i % 5)
			out.push_back(' ');
		out.push_back(aStr[i]);
	}

	return out;
}

std::string decode(const std::string& aStr)
{
	return apply_cypher(aStr);
}

std::string apply_cypher(std::string aStr)
{
	auto wr_it = std::begin(aStr);
	for(const unsigned char letter : aStr)
	           // ^ implicit cast bounded by cctype header functions ex. std::tolower and std::isdigit
	{
		if(std::isalpha(letter))
		{
			const auto a = static_cast<int>('a'); 
			const auto z = static_cast<int>('z');
			*wr_it = static_cast<char>(z - std::tolower(letter) + a);
			++wr_it;
		}
		else if(std::isdigit(letter))
		{
			*wr_it = letter;
			++wr_it;
		}
	}

	aStr.erase(wr_it, aStr.end());

	return aStr;
}  // namespace atbash_cipher

```
## Common suggestions

### **1. Use `const std::string&` or `std::string_view` instead of `std::string` as a parameter**

**The problem:** When you write `std::string apply_cypher(std::string aStr)`, the caller's string is **copied entirely** into the function. This is wasteful if you only need to read the string, not modify it.

**The solution:**
- Use **`const std::string&`** (const reference) – tells the compiler "I will only read this, don't copy it"
- Use **`std::string_view`** (C++17+) – a lightweight view into the string's data, even more efficient

**Example from the code:**
```cpp
// Current (wasteful):
std::string apply_cypher(std::string aStr)  // aStr is copied here

// Better:
std::string apply_cypher(const std::string& aStr)  // aStr is not copied
// or
std::string apply_cypher(std::string_view aStr)  // even lighter
```

**When this matters:** The `decode()` function calls `apply_cypher()` with a string parameter. If the input is large, that copy is unnecessary overhead.

---

### **2. Mention the ASCII table and character representation**

**The context:** Students often struggle to understand how characters are stored as numbers.

**What to explain:** The ASCII table maps characters to integer values (e.g., `'a'` = 97, `'z'` = 122). This is why the code does arithmetic like `z - std::tolower(letter) + a` — it's using these numeric values to swap letters.

**Why it matters:** Without this context, the Atbash cipher logic looks like magic.

---

## Talking points

### **1. Hidden copies when passing `std::string` by value**

**The issue:** Every time you call a function with `std::string aStr`, the entire string gets copied into the function's parameter. This happens in:
- `encode(const std::string& aStr)` → calls `apply_cypher(aStr)` (copy made here)
- `decode(const std::string& aStr)` → calls `apply_cypher(aStr)` (copy made here)

**Why students don't notice:** Small test strings (5–10 characters) run fast enough that the inefficiency is invisible.

**When it becomes a real problem:** If processing a 1 MB string, you're copying 1 MB multiple times—that's measurable performance loss.

**How to fix it:** Pass by const reference (`const std::string&`) or string_view.

---

### **2. Using `reserve()` is good practice before appending**

**What the code does right:**
```cpp
std::string out;
out.reserve(aStr.length() + aStr.length() / 5);  // Pre-allocate memory
for(size_t i = 0; i < aStr.length(); ++i) {
    out.push_back(aStr[i]);  // Now this doesn't trigger reallocations
}
```

**Why it matters:** When you call `push_back()` on a `std::string`, the string may need to reallocate and copy its internal buffer. `reserve()` pre-allocates enough space, so `push_back()` becomes truly O(1).

**Without reserve:**
- String grows: 1 → 2 → 4 → 8 → 16 → ... (exponential reallocations)
- Each reallocation copies the existing data

**With reserve:**
- All memory is allocated upfront
- `push_back()` never triggers a reallocation

---

### **3. Undefined behavior with `<cctype>` functions**

**The requirement:** `std::tolower()`, `std::isalpha()`, etc. expect either:
- An `unsigned char` value (0–255), OR
- The special value `EOF` (usually –1)

**The danger:**
```cpp
for(const unsigned char letter : aStr)  // Good: explicitly unsigned
{
    if(std::isalpha(letter))  // Safe
    if(std::tolower(letter))  // Safe
}
```

**What could go wrong:**
```cpp
for(const char letter : aStr)  // Risky: char can be signed
{
    std::tolower(letter);  // If letter has a negative value, undefined behavior!
}
```

**Why:** On systems where `char` is signed, characters with high bit set (128–255, representing accented letters, etc.) become negative. Passing negative values to `<cctype>` functions causes undefined behavior.

**The fix:** Cast to `unsigned char` or iterate over `unsigned char` directly (as the code already does).
