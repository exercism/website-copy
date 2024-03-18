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
	for(auto rd_it = std::cbegin(aStr); rd_it != std::cend(aStr); ++rd_it)
	{
		if(std::isalpha(*rd_it))
		{
			const auto a = static_cast<int>('a'); 
			const auto z = static_cast<int>('z');
			*wr_it = static_cast<char>(z - std::tolower(*rd_it) + a);
			++wr_it;
		}
		else if(std::isdigit(*rd_it))
		{
			*wr_it = *rd_it;
			++wr_it;
		}
	}

	aStr.erase(wr_it, aStr.end());

	return aStr;
}
}  // namespace atbash_cipher

```
## Common suggestions

 - The atbash cipher is symmetrical that is why it is possible to use one function to encode and decode. Ask a student to refactor. `Could you extract chunk splitting code and make refactoring of you code taking in account that fact?`
 - Passing function non-POD arguments by value (here usually std::string).
   - Explain the problem of time efficiency
   - Ask use references or lightweight objects (here std::string_view)
 - Students usually use mapping algorithm (map/array chars)
   - Explain what is ASCII table, char type
   - Ask refactor code using math equation to mutate a char
 - Introduce to a student standart functions to check character (std::isalpha/std::isalnum/..)

## Talking points

