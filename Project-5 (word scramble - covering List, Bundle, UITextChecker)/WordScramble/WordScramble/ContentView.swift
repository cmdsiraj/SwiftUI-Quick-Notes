//
//  ContentView.swift
//  WordScramble
//
//  Created by Mahammad Siraj Cheruvu on 2/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle=""
    @State private var errorMessage=""
    @State private var showingError=false
    
    @State private var score = 0
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError=true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func restart() {
        usedWords = [String]()
        rootWord=""
        newWord=""
        score=0
        startGame()
    }
    
    func startGame(){
        // 1. Find the URL for start.txt in our Bundle
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsUrl, encoding: .utf8) {
                // 3. Split the string in to array of strings. split at the line break.
                let allWords = startWords.components(separatedBy: "\n")
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                // If we are here, everything has worked. so we can exit.
                return
            }
        }
        
        fatalError("Could not load start.txt from the bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer != rootWord else {
            wordError(title: "Word is same as root word", message: "Think of New Words")
            return
        }
        
        guard isOriginal(word: newWord) else {
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
        
        guard answer.count > 0 else { return }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += newWord.count
        }
        
        
        
        newWord=""
    }
    
    var body: some View {
        NavigationStack{
            Section {
                Text("Score: \(score)")
                    .font(.headline)
            }
            List{
                Section {
                    TextField("Enter your word", text: $newWord).textInputAutocapitalization(.never)
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
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok") {}
            } message : {
                Text(errorMessage)
            }
            .toolbar{
                Button("Restart", action: restart)
            }
        }
    }
}

#Preview {
    ContentView()
}
