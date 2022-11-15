//
//  ContentView.swift
//  Animations(Transitions)
//
//  Created by Andrew Cousin on 11/14/22.
//

import SwiftUI

struct ContentView: View {
	@State private var isShowingRed = false
	
    var body: some View {
		VStack {
			Button("Tap me") {
				withAnimation {
					isShowingRed.toggle()
				}
			}
			
			if isShowingRed {
				Rectangle()
					.fill(.red)
					.frame(width: 300, height: 200)
					.transition(.asymmetric(insertion: .scale, removal: .opacity))
//					.transition(.scale)
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
