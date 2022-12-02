//
//  Expenses.swift
//  iExpense
//
//  Created by Andrew Cousin on 11/24/22.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(items) { //can also just replace encoder with JSONEncoder() and remove encoder property
				UserDefaults.standard.set(encoded, forKey: "Items")
			}
		}
	}
	init() {
		if let savedItems = UserDefaults.standard.data(forKey: "Items") {
			if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
				items = decodedItems
				return
			}
		}
		items = []
	}
}
