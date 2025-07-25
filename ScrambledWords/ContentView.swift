//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct ContentView: View {
    
    @State var letters: [Letter] = [
        Letter(id: 0, text: "A"),
        Letter(id: 1, text: "O"),
        Letter(id: 2, text: "E"),
        Letter(id: 3, text: "R"),
        Letter(id: 4, text: "N"),
        Letter(id: 5, text: "G")
    ]
    
    @State var guessedLetters: [Letter] = []
    @State var showSuccess = false
    @State var showFailure = false
    @State var score: Int = 0
    
    let correctAnwer = "ORANGE"
    
    var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Color.backgroud
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        VStack {
                            
                            Spacer()
                            
                            Image("orange")
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
                                                    letters[guessedLetter.id].text = guessedLetter.text
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
                            ForEach(Array(letters.enumerated()), id: \.1) { index, letter in
                                LetterView(letter: letter)
                                    .onTapGesture {
                                        if !letter.text.isEmpty {
                                            guessedLetters.append(letter)
                                            letters[index].text = ""
                                            if guessedLetters.count == letters.count {
                                                
                                                let guessedAnswer = guessedLetters.map { $0.text }.joined()
                                                
                                                if guessedAnswer == correctAnwer {
                                                    score += 1
                                                    showSuccess = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        showSuccess = false
                                                    }
                                                    print("correct")
                                                    
                                                } else {
                                                    showFailure = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        showFailure = false
                                                    }
                                                    print("wrong")
                                                }
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
    ContentView()
}
