//
//  LetterView.swift
//  ScrambledWords
//
//  Created by mac on 7/25/25.
//

import SwiftUI


struct LetterView: View {
    
    @State var  character: String
    var body: some View {
        Text(character)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(width: 30, height: 30)
                .background(Color.white.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}


