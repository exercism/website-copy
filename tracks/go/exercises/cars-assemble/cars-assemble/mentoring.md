# Initial Notes

- Both `CalculateWorkingCarsPerHour()` and `CalculateWorkingCarsPerMinute()` do not need to have multiple variables declared.
  The result can be calculated directly in the return statement.
- Both the `95000` and `10000` constants from the instructions should be declared as constants, either in `CalculateCost()` or in the package.
  This avoids a "MagicNumber" and allows you to declare a name for the values.

# Benchmark code

```golang
package cars

import (
	"fmt"
	"testing"
)

// Benchmark for CalculateWorkingCarsPerHour using a table-driven approach
func BenchmarkCalculateWorkingCarsPerHour(b *testing.B) {
	tests := []struct {
		productionPerHour int
		successRate       float64
	}{
		{1547, 90},
		{2000, 75},
		{3000, 50},
		{1000, 100},
		{500, 0},
	}

	for _, tt := range tests {
		b.Run(
			// Name the sub-benchmark using the input values
			fmt.Sprintf("productionPerHour=%d-successRate=%f", tt.productionPerHour, tt.successRate),
			func(b *testing.B) {
				for i := 0; i < b.N; i++ {
					CalculateWorkingCarsPerHour(tt.productionPerHour, tt.successRate)
				}
			})
	}
}

// Benchmark for CalculateWorkingCarsPerMinute using a table-driven approach
func BenchmarkCalculateWorkingCarsPerMinute(b *testing.B) {
	tests := []struct {
		productionPerHour int
		successRate       float64
	}{
		{1105, 90},
		{2000, 75},
		{1500, 50},
		{800, 100},
		{600, 0},
	}

	for _, tt := range tests {
		b.Run(
			fmt.Sprintf("productionPerHour=%d-successRate=%f", tt.productionPerHour, tt.successRate),
			func(b *testing.B) {
				for b.Loop() {
					CalculateWorkingCarsPerMinute(tt.productionPerHour, tt.successRate)
				}
			})
	}
}

// Benchmark for CalculateCost using a table-driven approach
func BenchmarkCalculateCost(b *testing.B) {
	tests := []struct {
		carsCount int
	}{
		{37},
		{21},
		{100},
		{250},
		{1000},
		{5000},
	}

	for _, tt := range tests {
		b.Run(
			fmt.Sprintf("carsCount=%d", tt.carsCount),
			func(b *testing.B) {
				for b.Loop() {
					CalculateCost(tt.carsCount)
				}
			})
	}
}

```
