//
//  ContentView.swift
//  Unit Conversions
//
//  Created by Andrew Cousin on 10/30/22.
//

import SwiftUI

struct ContentView: View {
	@State private var valueToConvert = 0.0
	@State private var inputSelected = ""
	@State private var outputSelected = ""
	@FocusState private var valueIsFocused: Bool
	
	let unitArray = ["meters", "Km", "feet", "yards", "Miles"]
	let feetConversion = ["meters": 3.28, "Km": 3_280.84, "feet": 1.00, "yards": 3.00, "Miles": 5_280.00]
	
	var convertedValue: Double {
		if let x = feetConversion[inputSelected] {
			if let y = feetConversion[outputSelected] {
				return(x * valueToConvert / y)
			}
		}
		return 0
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Enter amount", value: $valueToConvert, format: .number)
						.keyboardType(.decimalPad)
						.focused($valueIsFocused)
				} header: {
					Text("Enter a value to convert")
				}
				Section {
					Picker("Convert from:", selection: $inputSelected) {
						ForEach(unitArray, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("Pick a unit to convert from")
				}
				Section {
					Picker("Convert to:", selection: $outputSelected) {
						ForEach(unitArray, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("Pick a unit to convert to")
				}
				Section {
					Text(convertedValue, format: .number)
				} header: {
					Text("Converted value")
				}
			}
			.navigationTitle("Distance Conversions")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						valueIsFocused = false
					}
				}
			}
		}
	}
	
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
}
