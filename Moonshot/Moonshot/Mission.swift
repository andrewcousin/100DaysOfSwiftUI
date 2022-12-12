//
//  Mission.swift
//  Moonshot
//
//  Created by Andrew Cousin on 12/3/22.
//

import Foundation

struct Mission: Codable, Identifiable {
	struct CrewRole: Codable {
		let name: String
		let role: String
	}
	
	let id: Int
	let launchDate: Date? // String?
	let crew: [CrewRole]
	let description: String
	
	var displayName: String {
		"Apollo \(id)"
	}
	
	var image: String {
		"apollo\(id)"
	}
	
	var formattedLaunchDate: String {
		launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
	}
}
