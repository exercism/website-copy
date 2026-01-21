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

- Use `const std::string&` or `std::string_view` instead of `std::string` as a parameter, unless the string is re-used and returned.
- If students use structures representing alphabet for linear find, explain what is ASCII table, char type

## Talking points

- Be aware of hidden copies being made by using certain types as function parameters. (`std::string` in this case)
- When appending to a std::string, call std::string::reserve is a good optimization.
- Be aware of undefined behaviour using <cctype> if the argument's value is neither representable as unsigned char nor equal to EOF 