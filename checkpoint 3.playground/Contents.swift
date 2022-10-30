import SwiftUI

for i in 1...100 {
	if mult3(x: i) && mult5(x: i) {
		print("FizzBuzz")
	} else if mult3(x: i) {
		print("Fizz")
	} else if mult5(x: i) {
		print("Buzz")
	} else {
		print(i)
	}
}

func mult3(x: Int) -> Bool {
	if x % 3 == 0 { //can use x.isMultiple(of: 3)
		return true
	} else {
		return false
	}
}

func mult5(x: Int) -> Bool {
	if x % 5 == 0 {
		return true
	} else {
		return false
	}
}
