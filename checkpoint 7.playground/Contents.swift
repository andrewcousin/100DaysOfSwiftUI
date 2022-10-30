import SwiftUI

class Animal {
	var legs: Int
	
	init(legs: Int) {
		self.legs = legs
	}
}

class Dog: Animal {
	func speak() {
		print("Woof Woof!")
	}
}

class Corgi: Dog {
	override func speak() {
		print("woooof!")
	}
}

class Poodle: Dog {
	override func speak() {
		print("Grrrrrr! Wooof Wooof Wooof!")
	}
}

class Cat: Animal {
	var isTame: Bool
	
	init(legs: Int, isTame: Bool) {
		self.isTame = isTame
		super.init(legs: legs)
	}
	
	func speak() {
		print("Meow.")
	}
}

class Persian: Cat {
	override func speak() {
		print("meooowowowow!")
	}
}

class Lion: Cat {
	override func speak() {
		print("Grrrrrrrroaaar!")
	}
}

let corgi = Corgi(legs: 4)
corgi.speak()

let Simba = Lion(legs: 4, isTame: false)
Simba.isTame
Simba.speak()
