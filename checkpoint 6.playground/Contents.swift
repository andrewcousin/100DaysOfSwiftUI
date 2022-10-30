import SwiftUI

enum shiftError: Error {
	case outRange
}

struct Car {
	let model: String
	let numberOfSeats: Int
	private(set) var numberOfGears: Int
	private(set) var currentGear: Int
	
	init(model: String, numberOfSeats: Int, numberOfGears: Int, currentGear: Int) {
		self.model = model
		self.numberOfSeats = numberOfSeats
		self.numberOfGears = numberOfGears
		self.currentGear = 0
	}
	
	mutating func changeToGear(_ gear: Int) {
		if gear > 0 && gear < numberOfGears {
			currentGear = gear
			print("Gear \(gear) now selected.")
		} else if gear == 0 {
			currentGear = gear
			print("Neutral now selected.")
		} else if gear == numberOfGears {
			currentGear = gear
			print("Reverse gear now selected.")
		} else {
			print("Can't select that gear")
		}
	}
}

var matrix = Car(model: "Matrix", numberOfSeats: 5, numberOfGears: 6, currentGear: 9_001)
print(matrix.currentGear)
matrix.changeToGear(6)
