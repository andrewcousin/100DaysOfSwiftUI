import SwiftUI

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

for luck in luckyNumbers.filter({$0 % 2 != 0}).sorted().map({"\($0) is a lucky number"}) {
	print(luck)
}
