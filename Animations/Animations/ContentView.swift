//
//  ContentView.swift
//  Animations
//
//  Created by Andrew Cousin on 11/13/22.
//

import SwiftUI

struct ContentView: View {
//	@State private var animationAmount = 1.0
	@State private var animationAmount = 0.0 //for rotation degrees
	
	@State private var enabled = false
	
	var body: some View {
		VStack{
//			Stepper("Scale Amount", value: $animationAmount.animation(//), in: 1...10)
//				.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10)
			
			Spacer()
			
			Button("Tap me") {
				enabled.toggle()
//				animationAmount += 1
				withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
//				withAnimation {
					animationAmount += 360 //for rotation
				}
				withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
					animationAmount += 500
				}
			}
			.frame(width: 200, height: 100)
			.padding(50)
			.background(enabled ? .blue : .red)
			.animation(.default, value: enabled) //can use nil for first argument
			.foregroundColor(.white)
			.clipShape(RoundedRectangle(cornerRadius: enabled ? 50 : 0))
			.animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
//			.clipShape(Circle())
//			.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 10, z: 0))
//			.overlay(
//				Circle()
//					.stroke(.red)
//					.scaleEffect(animationAmount)
//					.opacity(3 - animationAmount)
//					.animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
//			)
//			.onAppear {
//				animationAmount = 5
//			}
//			.scaleEffect(animationAmount)
//			.blur(radius: (animationAmount - 1) * 3)
//			.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
//			.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true), value: animationAmount)
//			.animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
//			.animation(.easeInOut(duration: 2), value: animationAmount)
//			.animation(.interpolatingSpring(stiffness: 50, damping: 2), value: animationAmount)
//			.animation(.default, value: animationAmount) //.animation when added, swift auto animates any changes that happen to the attached view using first argument, in this case .default, when value changes. Without a value such as animationAmount, swift would animate any small change that occurs.
			Spacer()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
