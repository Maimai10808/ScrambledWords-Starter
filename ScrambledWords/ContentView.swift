//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct ContentView: View {
    
    @State var letters: [String] = ["R", "A", "R", "B", "K","L"]
    
    @State var guessedLetters: [String] = []
    
    
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
                            ForEach(guessedLetters, id: \.self) { letter in
                                VStack {
                                    LetterView(character: letter)
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
                    Text("Score 0")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                    
                    HStack {
                        ForEach(Array(letters.enumerated()), id: \.1) { index, letter in
                            LetterView(character: letter)
                                .onTapGesture {
                                    if !letter.isEmpty {
                                        guessedLetters.append(letter)
                                        letters[index] = ""
                                    }
                                    
                                }
                        }
                    }
                    
                    
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
