//
//  ContentView.swift
//  iExpense
//
//  Created by Andrew Cousin on 11/22/22.
//

import SwiftUI

struct ContentView: View {
	@StateObject var expenses = Expenses() // @StateObject only used when creating instance, @ObservedObject used all other times for an existing instance
	@State private var showingAddExpense = false
	
	var body: some View {
		NavigationView {
			List {
				ForEach(expenses.items) { item in
					HStack {
						VStack(alignment: .leading) {
							Text(item.name)
								.font(.headline)
							Text(item.type)
						}
						
						Spacer()
						
						item.amount < 10 ? Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.green) :
						
						(item.amount < 100 ? Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.blue) :
							
							Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.red))
					}
				}
				.onDelete(perform: removeItems)
			}
			.navigationTitle("iExpense")
			.toolbar {
				Button {
					showingAddExpense = true
				} label: {
					Image(systemName: "plus")
				}
			}
			.sheet(isPresented: $showingAddExpense) {
				AddView(expenses: expenses)
			}
		}
	}
	
	func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
	}
}

//struct SectionType: ViewModifier {
//	@ObservedObject var expenses = Expenses()
//
//	func body(content: Content) -> some View {
//		content
//		ForEach(expenses.items) { item in
//			HStack {
//				VStack(alignment: .leading) {
//					Text(item.name)
//						.font(.headline)
//					Text(item.type)
//				}
//
//				Spacer()
//
//				item.amount < 10 ? Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.green) :
//
//				(item.amount < 100 ? Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.blue) :
//
//					Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(.red))
//			}
//		}
//	}
//}
//
////MARK: - EXTENSIONS
//extension View {
//	func sectionType() -> some View {
//		modifier(SectionType())
//	}
//}
//
////MARK: - test
//struct BigOrange: ViewModifier {
//	var text: String
//
//	func body(content: Content) -> some View {
//		Text(text)
//			.font(.title)
//			.foregroundColor(.orange)
//	}
//
//}
//
//extension View {
//	func bigOrange(with text: String) -> some View {
//		modifier(BigOrange(text: text))
//	}
//}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
