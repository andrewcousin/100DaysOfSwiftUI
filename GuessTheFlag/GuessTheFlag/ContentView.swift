//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrew Cousin on 11/1/22.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var resetGame = false
	@State private var scoreTitle = ""
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var score = 0
	@State private var gameCounter = 1
	
	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.orange, .brown, .brown , .black]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack{
				
				Spacer()
				
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundColor(.primary)
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.foregroundStyle(.secondary)
							.font(.headline.weight(.heavy))
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
					}
					
					ForEach(0..<3) {number in
						Button {
								flagTapped(number)
						} label: {
							Image(countries[number])
								.renderingMode(.original)
								.clipShape(RoundedRectangle(cornerRadius: 10))
								.shadow(radius: 5)
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				Spacer()
				
				Text("Score: \(score)")
					.font(.title)
					.foregroundColor(.orange)
				Text("\(gameCounter)/8")
					.foregroundColor(.orange)
				
				Spacer()
			}
			.alert(scoreTitle, isPresented: $showingScore) {
				Button("Continue", action: askQuestion)
			} message: {
				Text("Your score is \(score)")
			}
			
			.alert(scoreTitle, isPresented: $resetGame) {
				Button("Reset", action: reset)
			} message: {
				if score > 4 {
					Text("Your final score is \(score). Good job!")
				} else {
					Text("Your final score is \(score) You can do better!")
				}
			}
			
			.padding()
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
			score += 1
		} else {
			scoreTitle = "Wrong, that's the flag of \(countries[number])"
			score -= 1
		}
		
		
		if gameCounter < 8 {
			gameCounter += 1
			showingScore.toggle()
		} else {
			resetGame.toggle()
		}
	}
	
	func reset() {
		score = 0
		gameCounter = 0
		askQuestion()
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
