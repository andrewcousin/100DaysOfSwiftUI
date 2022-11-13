//
//  ContentView.swift
//  WordScramble
//
//  Created by Andrew Cousin on 11/11/22.
//

import SwiftUI

struct ContentView: View {
	@State private var usedWords = [String]()
	@State private var rootWord = ""
	@State private var newWord = ""
	
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	@State private var showingError = false
	
	@State private var score = 0
	
	var body: some View {
		NavigationView {
			List {
				Section {
					TextField("Enter your word", text: $newWord)
						.autocapitalization(.none)
				}
				
				Section {
					ForEach(usedWords, id: \.self) { word in
						HStack {
							Image(systemName: "\(word.count).circle")
							Text(word)
						}
					}
				}
			}
			.navigationTitle(rootWord)
			.onSubmit(addNewWord)
			.onAppear(perform: startGame)
			.onChange(of: rootWord, perform: { newValue in
				resetScore()
			})
			.alert(errorTitle, isPresented: $showingError) {
				Button("OK", role: .cancel) { }
			} message: {
				Text (errorMessage)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Text("Score \(score)")
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("Restart", action: startGame)
				}
			}
		}
	}
	
	func addNewWord() {
		let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		guard answer.count > 0 else {return}
		
		guard isOriginal(word: answer) else {
			wordError(title: "Word used already", message: "Be more original")
			return
		}
		
		guard isPossible(word: answer) else {
			wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
			return
		}
		
		guard isReal(word: answer) else {
			wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
			return
		}
		
		guard isLongEnough(word: answer) else {
			wordError(title: "Word not long enough", message: "Word needs to be at least three characters.")
			return
		}
		
		scoreBrain(word: answer)
			
		withAnimation {
			usedWords.insert(answer, at: 0)
		}
		newWord = ""
	}
	
	func startGame() {
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: startWordsURL) {//contentsOf: is throwing func
				let allWords = startWords.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "silkworm"
				usedWords = [String]()
				return
			}
		}
		fatalError("Could not load start.txt from bundle")
	}
	
	func isOriginal(word: String) -> Bool {
		!usedWords.contains(word) && word != rootWord
	}
	
	func isPossible(word: String) -> Bool {
		var tempWord = rootWord
		
		for letter in word {
			if let pos = tempWord.firstIndex(of: letter) {
				tempWord.remove(at: pos)
			} else {
				return false
			}
		}
		return true
	}
	
	func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		
		return misspelledRange.location == NSNotFound
	}
	
	func wordError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showingError = true
	}
	
	func isLongEnough(word: String) -> Bool {
		word.count > 2
	}
	
	func resetScore() {
		score = 0
	}
	
	func scoreBrain(word: String) {
		score += 1

		word.count > 3 ? (score += 1) : (score += 0)
		word.count > 4 ? (score += 1) : (score += 0)
		word.count > 5 ? (score += 1) : (score += 0)
		word.count > 6 ? (score += 1) : (score += 0)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
