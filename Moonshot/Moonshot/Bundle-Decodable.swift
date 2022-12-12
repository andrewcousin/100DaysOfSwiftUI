//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Andrew Cousin on 12/3/22.
//

import Foundation

extension Bundle { // T is some type
	func decode<T: Codable>(_ file: String) -> T {// T replaces the following: [String: Astronaut] not sure why {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to laod \(file) from bundle.")
		}
		
		let decoder = JSONDecoder()
		let formatter = DateFormatter()
		formatter.dateFormat = "y-MM-dd"
//		formatter.timeZone // not needed here but should use normally
		decoder.dateDecodingStrategy = .formatted(formatter)
		
		guard let loaded = try? decoder.decode(T.self, from: data) else { // .decode([String: Astronaut].self
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		return loaded
	}
}
