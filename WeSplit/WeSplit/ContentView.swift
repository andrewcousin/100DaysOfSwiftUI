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
	
	let tipPercentages = [0, 5, 10, 15, 20, 25]
	
	
    var body: some View {
        Form {
			Section {
				TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
			}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
