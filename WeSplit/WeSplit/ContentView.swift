//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrew Cousin on 10/29/22.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = 0..<101
	
	var totalAmount: Double {
		let tipSelection = Double(tipPercentage)
		let tipvalue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipvalue
		return grandTotal
	}
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)
		
		let tipvalue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipvalue
		let amountPerPerson = grandTotal / peopleCount
		return amountPerPerson
	}
	
	var useRedText: Bool {
		if tipPercentage == 0 {
			return true
		} else {
			return false
		}
	}
	
	var localCurrency: FloatingPointFormatStyle<Double>.Currency {
		(.currency(code: Locale.current.currencyCode ?? "USD"))
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $checkAmount, format: localCurrency)
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
					
					Section {
						Picker("Tip percentage", selection: $tipPercentage) {
							ForEach(tipPercentages, id: \.self) {
								Text($0, format: .percent)
							}
						}
						.pickerStyle(.wheel)
					} header: {
						Text("What % tip do you want to leave?")
					}
				}
				
				Section {
					Text(totalAmount, format: localCurrency)
						.foregroundColor(useRedText ? .red : .primary)
				} header: {
					Text("Total Amount")
				}
				
				Section {
					Text(totalPerPerson, format: localCurrency)
				} header: {
					Text("Amount per person")
				}
				
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
			.navigationTitle("Amount per person")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
