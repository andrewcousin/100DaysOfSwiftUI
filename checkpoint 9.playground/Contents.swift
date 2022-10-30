import SwiftUI

func optArray(array: [Int]?) {array?.randomElement() ?? .random(in: 1...100)}

optArray(array: [])
