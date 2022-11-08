//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andrew Cousin on 11/4/22.
//

import SwiftUI

struct ContentView: View {
	
	@State private var appChoice = 0
	@State private var playerChoice = 0
	@State private var win = true
	@State private var appChoices = ["✊🏾", "🖐🏾","✌🏾"]
	@State private var playerChoices = ["🖐🏾", "✌🏾", "✊🏾"]
	@State private var scoreTitle = ""
	@State private var draw = false
	@State private var resultTitle = false
	@State private var reset = false
	@State private var startGame = true
	@State private var startTitle = "Tap start to begin"
	@State private var score = 0
	@State private var gameCounter = 1
	@State private var appVocab = ["lays down", "serves up", "barrels in with", "smashes down", "gently presents", "suspectfully extends", "charges with", "hammers down", "suspiciously tries", "lazily tosses", "confidently throws", "thrust a", "rushes with", "darts in with", "ambushes with", "cautiously shows", "apprehensively reveals"].shuffled()
	
	var countdown: String {
		"\(gameCounter)/10"
	}
	
	var winLose: String {
		win ? "WIN" : "LOSE"
	}
	
	var didDraw: Bool {
		draw ? true : false
	}
	
	var didWin: Bool {
		win ? winBrain : loseBrain
	}
	
	var winBrain: Bool {
		appChoice == playerChoice ? true : false
	}
	
	var loseBrain: Bool {
		appChoice != playerChoice ? true : false
	}
	
	func randomizer() {
		win = Bool.random()
		appChoice = Int.random(in: 0...2)
		startGame = false
		appVocab.shuffle()
	}
	
	func pressedCalc() {
		if appChoices[appChoice] == playerChoices[playerChoice] {
			draw.toggle()
		}
		
		if didDraw {
			scoreTitle = "It's a draw!"
		} else if didWin {
			scoreTitle = "You are correct!"
			score += 1
		} else {
			scoreTitle = "Wrong..."
			score -= 1
		}
	}
	
	func buttonPressed() {
		if gameCounter < 10 {
			pressedCalc()
			gameCounter += 1
			resultTitle.toggle()
		} else {
			pressedCalc()
			reset.toggle()
		}
		draw = false
	}
	
	func resetGame() {
		score = 0
		gameCounter = 1
		randomizer()
	}
	
	var body: some View {
		NavigationView {
			ZStack {
				LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
					.ignoresSafeArea()
				
				VStack {
					HStack {
						Text("\(countdown)")
							.foregroundColor(.secondary)
						
						Spacer()

						Text("Player Score: \(score)")
							.foregroundColor(.primary)
					}
					.font(.title2)
					.padding()
					
					Spacer()
					
					HStack {
						Text("iphone")
							.font(.title)
							.foregroundColor(.secondary)
						
						Text("\(appVocab[0])")
							.font(.title)
							.foregroundColor(.primary)
					}
					
					Text("\(appChoices[appChoice])")
						.font(.system(size: 75))
						.shadow(radius: 15)
					
					Text("Your goal is to \(winLose)")
						.font(.title)
						.foregroundStyle(.linearGradient(Gradient(colors: [.secondary, .primary]), startPoint: .leading, endPoint: .trailing))
						
					Spacer()
					Spacer()
					
					Section {
						HStack {
							
							Spacer()
							
							Button("✊🏾") {
								playerChoice = 2
								buttonPressed()
							}
							.buttonMods()
							
							Spacer()
							
							Button("🖐🏾") {
								playerChoice = 0
								buttonPressed()
							}
							.buttonMods()

							Spacer()
							
							Button("✌🏾") {
								playerChoice = 1
								buttonPressed()
							}
							.buttonMods()

							Spacer()
							
						}
						.font(.system(size: 75))
						
						Spacer()
						Spacer()
						
					} header: {
						Text("How will you respond?")
							.foregroundColor(.primary)
							.font(.title3)
					}
					
					.alert(startTitle, isPresented: $startGame) {
						Button("Start", action: randomizer)
					}
					
					.alert(scoreTitle, isPresented: $resultTitle) {
						Button("Continue", action: randomizer)
					} message: {
						Text("Your score is \(score)")
					}
					
					.alert(scoreTitle, isPresented: $reset) {
						Button("Restart", action: resetGame)
					} message: {
						Text("Your final score is \(score)")
					}
				}
			}
		}
	}
}

struct ButtonMods: ViewModifier {

	func body(content: Content) -> some View {
		content
			.shadow(radius: 5)
			.frame(maxWidth: 75, maxHeight: 85)
			.padding(10)
			.background(.ultraThinMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 25))
			.shadow(radius: 10)
	}
}

extension View {
	func buttonMods() -> some View {
		modifier(ButtonMods())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
