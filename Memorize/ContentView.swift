//
//  ContentView.swift
//  Memorize
//
//  Created by Yeliena Khaletska on 30.06.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🐳", "🦭", "🐬", "🐟", "🐠", "🐡", "🦈", "🐙", "🪼"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView {
                self.cards
            }
            Spacer()
            self.cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            self.cardRemover
            Spacer()
            self.cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<self.cardCount, id: \.self) { index in
                CardView(content: self.emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardRemover: some View {
        makeCardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        makeCardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    func makeCardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            self.cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(self.cardCount + offset < 1 || self.cardCount + offset > self.emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(self.content).font(.largeTitle)
            }
            .opacity(self.isFaceUp ? 1 : 0)
            base.fill().opacity(self.isFaceUp ? 0 : 1)
        }.onTapGesture {
            self.isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
