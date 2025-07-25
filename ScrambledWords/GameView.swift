//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct GameView: View {
    
    @State private var guessedLetters: [Letter] = []
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var score: Int  = 0
    
    @State var questions: [Question] = [
        Question(image: "orange", scrambledletters: [
            Letter(id: 0, text: "A"),
            Letter(id: 1, text: "O"),
            Letter(id: 2, text: "E"),
            Letter(id: 3, text: "R"),
            Letter(id: 4, text: "N"),
            Letter(id: 5, text: "G")
        ], Answer: "ORANGE"),
        Question(image: "banana", scrambledletters: [
            Letter(id: 0, text: "A"),
            Letter(id: 1, text: "A"),
            Letter(id: 2, text: "N"),
            Letter(id: 3, text: "B"),
            Letter(id: 4, text: "N"),
            Letter(id: 5, text: "A")
        ], Answer: "BANANA"),
        Question(image: "apple", scrambledletters: [
            Letter(id: 0, text: "A"),
            Letter(id: 1, text: "L"),
            Letter(id: 2, text: "E"),
            Letter(id: 3, text: "P"),
            Letter(id: 4, text: "P")
        ], Answer: "APPLE")
        
    ]
    
    @State private var currentQuestionIndex = 0
    
    var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Color.backgroud
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        VStack {
                            
                            Spacer()
                            
                            Image(questions[currentQuestionIndex].image)
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Spacer()
                            
                            HStack {
                                ForEach(guessedLetters) { guessedLetter in
                                    VStack {
                                        LetterView(letter: guessedLetter)
                                            .onTapGesture {
                                                if let index = guessedLetters.firstIndex(of: guessedLetter) {
                                                    guessedLetters.remove(at: index)
                                                    questions[currentQuestionIndex].scrambledletters[guessedLetter.id].text = guessedLetter.text
                                                }
                                            }
                                        Rectangle()
                                            .fill(Color.white)
                                            .frame(width: 25, height: 2)
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                            
                        }
                        .frame(width: proxy.size.width * 0.9,height: proxy.size.width * 0.9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.border, lineWidth: 2)
                        }
                        Text("Score \(score)")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.white)
                        
                        HStack {
                            ForEach(Array(questions[currentQuestionIndex].scrambledletters.enumerated()), id: \.1) { index, letter in
                                LetterView(letter: letter)
                                    .onTapGesture {
                                        if !letter.text.isEmpty {
                                            guessedLetters.append(letter)
                                            questions[currentQuestionIndex].scrambledletters[index].text = ""
                                            if guessedLetters.count == questions[currentQuestionIndex].scrambledletters.count {
                                                
                                                let guessedAnswer = guessedLetters.map { $0.text }.joined()
                                                
                                                if guessedAnswer == questions[currentQuestionIndex].Answer {
                                                    score += 1
                                                    showSuccess = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        showSuccess = false
                                                        if currentQuestionIndex == questions.count - 1 {
                                                            
                                                        } else {
                                                            currentQuestionIndex += 1
                                                        }
                                                        
                                                    }
                                                    print("correct")
                                                    
                                                } else {
                                                    showFailure = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        showFailure = false
                                                        if currentQuestionIndex == questions.count - 1 {
                                                            
                                                        } else {
                                                            currentQuestionIndex += 1
                                                        }
                                                        
                                                    }
                                                    print("wrong")
                                                }
                                                guessedLetters.removeAll()
                                                
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    
                    if showFailure {
                        VStack {
                            Image("cross")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                    }
                    
                    if showSuccess {
                        VStack {
                            Image("tick")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                    }
                    
                    
                }
            }
            }
        }

#Preview {
    GameView()
}
