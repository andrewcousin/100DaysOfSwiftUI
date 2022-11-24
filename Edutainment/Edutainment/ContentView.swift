//
//  ContentView.swift
//  Edutainment
//
//  Created by Andrew Cousin on 11/15/22.
//

import SwiftUI

struct ContentView: View {
//MARK: - PROPERTIES

	@State private var animationAmount = 1.0
	@State private var animationAmountTwo = 2.0
	@State private var animationAmountThree = 2.0
	@State private var multiplicationValue = 7
	@State private var questionValue = 0
	@State private var questionIncrement = 0
	@State private var starTrackerRowOne = 0
	@State private var starTrackerRowTwo = 0
	@State private var score = 0
	
	@State private var alertTitle = ""
	@State private var playerAnswer = ""
	
	@State private var numberImages = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "cross"] //: unused for now
	
	@State private var answerArray = [""].shuffled()
	@State private var gameNew = true
	@State private var gameEnded = false //: unused for now
	@State private var gameStarted = false
	@State private var gameReset = false
	@State private var showAlert = false
	@State private var showResetAlert = false
	@State private var enableStarsRowOne = false
	@State private var enableStarsRowTwo = false
	
	@State private var question = [Question]()
	@State private var stars = [StarID]()
	@State private var stars2 = [StarID]()
	
	let howManyQuestions = [5, 10, 20]
	
	var numberOfQuestions: Int {
		switch questionValue {
		case 0:
			return 5
		case 1:
			return 10
		case 2:
			return 20
		default:
			return 5
		}
	}
	
	var correctAnswer: Bool {
		if gameStarted {
			if playerAnswer == String(question[questionIncrement].answer) {
				return true
			} else {
				return false
			}
		}
		return false
	}
		
//MARK: - BODY
	var body: some View {
		NavigationView {
			ZStack {
				LinearGradient(colors: [.yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
					.ignoresSafeArea()
				VStack {
					VStack {
						Text("🧸  Multiplication  🐢")
							.foregroundStyle(.linearGradient(Gradient(colors: [.secondary, .yellow, .secondary]), startPoint: .leading, endPoint: .trailing))
							.font(.system(.largeTitle, design: .rounded).bold()).foregroundColor(.secondary)
							.shadow(radius: 1)
					}
					.frame(maxWidth: .infinity, maxHeight: 40)
					.background(.thinMaterial)
					.clipShape(RoundedRectangle(cornerRadius: 25))
					.padding()
					Spacer()
					
					VStack(spacing: 0) {
						Text("Settings")
							.font(.title)
							.foregroundColor(.secondary)
						
						Stepper("Answer \(howManyQuestions[questionValue]) questions", onIncrement: incrementStep, onDecrement: decrementStep)
							.padding()
						
						Stepper("Multiplication Tables \(multiplicationValue)", value: $multiplicationValue, in: 2...12)
							.padding()
					}
					.frame(maxWidth: .infinity, maxHeight: 200)
					.background(.thinMaterial)
					.clipShape(RoundedRectangle(cornerRadius: 40))
					.shadow(radius: 5)
					.padding()
					
					Spacer()
					
					VStack {
						Button("START GAME", action: start)
							.foregroundColor(.secondary)
							.padding(20)
							.background(.regularMaterial)
							.clipShape(RoundedRectangle(cornerRadius: 50))
							.shadow(radius: 5)
							.padding()
							.onAppear{
								animationAmount += 0.15
							}
							.scaleEffect(animationAmount)
							.animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animationAmount)
					}
				}
				.opacity(gameNew ? 1 : 0)

				VStack {
					HStack {
						if enableStarsRowOne {
							ForEach(stars, id: \.id) { star in
								enableStarsRowOne ? Image(star.starType).onAppear{animationAmountTwo = 1}.scaleEffect(animationAmountTwo).animation(.default, value: animationAmountTwo) : Image("star_outline").onAppear{animationAmountTwo = 1}.scaleEffect(animationAmountTwo).animation(.default, value: animationAmountTwo)
							}
						}
					}

					HStack {
						if enableStarsRowTwo {
							ForEach(stars2, id: \.id) { star in
								enableStarsRowTwo ? Image(star.starType).onAppear{animationAmountThree = 1}.scaleEffect(animationAmountThree).animation(.default, value: animationAmountThree) : Image("star_outline").onAppear{animationAmountThree = 1}.scaleEffect(animationAmountThree).animation(.default, value: animationAmountThree)
							}
						}
					}
					Spacer()
					Spacer()
				}
								
				VStack {
					Spacer()
					
					HStack(spacing: 1) {
						if gameStarted {
							Text(question[questionIncrement].question)
						}
					}
					.scaleEffect(1.5)
					.foregroundColor(.secondary)
					.padding()
					.frame(maxWidth: .infinity)
					.background(.thinMaterial)
					.clipShape(RoundedRectangle(cornerRadius: 50))
					.padding()
					.shadow(radius: 5)
					
					Spacer()
					
					VStack(spacing: 20) {
						HStack(spacing: 10) {
							ForEach(answerArray.unique(), id: \.self) { num in
								Button {
									playerAnswer = num
									starTrackerRowOne < 10 ? (starTrackerRowOne += 1) : (starTrackerRowTwo += 1)
									enableStarsRowOne = true
									if starTrackerRowTwo == 1 { enableStarsRowTwo = true }
									
									if starTrackerRowOne < 11 && !enableStarsRowTwo { correctAnswer ? stars.append(StarID(starType: "star")) : stars.append(StarID(starType: "star_outline")) }
									
									if enableStarsRowTwo { correctAnswer ? stars2.append(StarID(starType: "star")) : stars2.append(StarID(starType: "star_outline")) }
									
									questionIncrement == numberOfQuestions - 1 ? showResetAlert.toggle() : showAlert.toggle()
									starTrackerRowOne < 10 ? (animationAmountTwo = 2) : (animationAmountTwo = 1)
									animationAmountThree = 2
									if correctAnswer { score += 1 }
								} label: {
									Text(num)
								}
								.buttonMods()
							}
						}
						.background(.ultraThinMaterial)
						.clipShape(RoundedRectangle(cornerRadius: 75))
						.frame(maxWidth: .infinity, maxHeight: 200)
						.padding()
						.shadow(radius: 5)
					}
				}
				.opacity(gameStarted ? 1 : 0)
				
//				VStack {
//					Button("Play Again?", action: settings)
//					Button("exit", action: endGame)
//				}
//				.opacity(gameEnded ? 1 : 0)
			}
			.alert(alertTitle, isPresented: $showAlert) {
				Button("continue", action: askQuestion)
			} message: {
				Text(alertBrain())
			}
			
			.alert(alertTitle, isPresented: $showResetAlert) {
				Button("continue", action: settings)
			} message: {
				Text("You answered \(score) out of \(numberOfQuestions) correctly")
			}
			
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					if gameStarted {
						Button("Start Over", action: startOver)
							.shadow(radius: 10)
							.foregroundColor(.green)
					}
				}
			}
		}
	}
	
//MARK: - FUNCTIONS
	func incrementStep() {
		questionValue += 1
		if questionValue >= howManyQuestions.count { questionValue = 0 }
	}
	
	func decrementStep() {
		questionValue -= 1
		if questionValue < 0 { questionValue = howManyQuestions.count - 1}
	}
	
	func settings() {
		removal()
		enableStarsRowOne = false
		gameNew = true
		gameStarted = false
		showResetAlert.toggle()
		questionIncrement = 0
		starTrackerRowOne = 0
		starTrackerRowTwo = 0
		score = 0
	}
	
	func start() {
		gameNew = false
		gameStarted = true
		populate()
		randomAnswers()
		alertTitle = ""
	}
	
	func startOver() {
		alertTitle = "Returning to home page"
		showResetAlert.toggle()
	}
	
	func removal() {
		question.removeLast(numberOfQuestions)
		stars.removeLast(starTrackerRowOne)
		stars2.removeLast(starTrackerRowTwo)
	}
	
	func askQuestion() {
		showAlert.toggle()
		questionIncrement += 1
		randomAnswers()
	}
	
	func endGame() {
		fatalError()
	}
	
	func alertBrain() -> String {
		return correctAnswer ? "You got it!" : "Nope!"
	}
	
	func numberImage(_ number: Int) -> some View { //:unused for now
		Image(numberImages[number])
			.renderingMode(.original)
			.shadow(radius: 1)
	}
	
	func populate() {
		for _ in 0...numberOfQuestions - 1 {
			let x = Int.random(in: Int.random(in: 0...2)...multiplicationValue)
			let y = Int.random(in: Int.random(in: 0...2)...multiplicationValue)
			question.append(Question(question: "What is \(x) x \(y) ?", answer: x * y))
		}
	}
	
	func randomAnswers() {
		answerArray.removeAll()
		for _ in 0...2 {
			let x = Int.random(in: Int.random(in: 1...2)...multiplicationValue)
			let y = Int.random(in: Int.random(in: 0...2)...multiplicationValue)
			answerArray.append("\(x * y)")
		}
		answerArray.append(String(question[questionIncrement].answer))
		answerArray.shuffle()
	}
}

//MARK: - STRUCTS
struct Question {
	let question: String
	let answer: Int
}

struct StarID {
	let id = UUID()
	let starType: String
}

//MARK: - MODIFIERS
struct ButtonMods: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.title2)
			.padding()
			.foregroundColor(.secondary)
			.frame(maxWidth: .infinity, maxHeight: 100)
			.background(.ultraThinMaterial)
			.clipShape(Circle())
			.padding(4)
			.shadow(radius: 5)
	}
}

//MARK: - EXTENSIONS
extension View {
	func buttonMods() -> some View {
		modifier(ButtonMods())
	}
}

extension Sequence where Iterator.Element: Hashable {
	func unique() -> [Iterator.Element] {
		var seen: Set<Iterator.Element> = []
		return filter { seen.insert($0).inserted }
	}
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
