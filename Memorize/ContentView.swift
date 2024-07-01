//
//  ContentView.swift
//  Memorize
//
//  Created by Yeliena Khaletska on 30.06.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😝", "🥳", "🥰", "🫠"]
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
