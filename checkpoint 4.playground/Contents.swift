import SwiftUI

enum notSqRoot: Error {
	case outBounds, noRoot
}

func checkSqRoot(num: Int) throws -> Int {
	if num < 1 || num > 10_000 {
		throw notSqRoot.outBounds
	}
	
	var sqRoot = 0
	
	for i in 1...num {
		if i * i == num {
			sqRoot = i
			break
		}
	}
	if sqRoot == 0 {
		throw notSqRoot.noRoot
		}
	return sqRoot
}

do {
	let root = try checkSqRoot(num: 3)
	if root != 0 {
		print(root)
	}
} catch notSqRoot.outBounds {
	print("out of bounds")
} catch notSqRoot.noRoot {
	print("no root")
}
