# Initial Notes
- Both CalculateWorkingCarsPerHour and CalculateWorkingCarsPerMinute do not need to have multiple variables declared instead they can just be calculated in the return statement.
- Both the 95000 and 10000 constants that are brought in from the question prompt should be declared as constants either in the CalculateCost function or in the package itself, this avoids a "MagicNumber" and allows you to declare a name for the values.

# Benchmark code

```golang
package cars

import (
	"strconv"
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
			"productionPerHour="+strconv.Itoa(tt.productionPerHour)+"-successRate="+strconv.FormatFloat(tt.successRate, 'f', -1, 64),
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
			"productionPerHour="+strconv.Itoa(tt.productionPerHour)+"-successRate="+strconv.FormatFloat(tt.successRate, 'f', -1, 64),
			func(b *testing.B) {
				for i := 0; i < b.N; i++ {
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
			"carsCount="+strconv.Itoa(tt.carsCount),
			func(b *testing.B) {
				for i := 0; i < b.N; i++ {
					CalculateCost(tt.carsCount)
				}
			})
	}
}

```
