//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Andrew Cousin on 11/24/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
	var id = UUID()
	let name: String
	let type: String
	let amount: Double
}
