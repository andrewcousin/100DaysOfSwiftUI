import SwiftUI

protocol Building {
	var rooms: Int {get}
	var cost: Int {get set}
	var name: String {get set}
}

extension Building {
	func salesSummary() {
		print("This \(Self.self) has \(rooms) rooms, cost $\(cost) and is called \(name)")
	}
}

struct House: Building {
	var rooms: Int
	var cost: Int
	var name: String
}
	
struct Office: Building {
	var rooms: Int
	var cost: Int
	var name: String
}
	
let office = Office(rooms: 10, cost: 910_000, name: "Hello Swift")
print(office.salesSummary())

let house = House(rooms: 5, cost: 450_000, name: "Riverfront")
print(house.salesSummary())
