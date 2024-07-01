//
//  ContentView.swift
//  Memorize
//
//  Created by Yeliena Khaletska on 30.06.2024.
//

import SwiftUI

struct ContentView: View {
    let themes: [Theme] = [
        .init(name: "Pastry", iconName: "birthday.cake.fill", emojis: ["🍞", "🥐", "🥖", "🥨", "🥯", "🥞", "🧇", "🍩", "🍪"]), // pastry
        .init(name: "Ocean", iconName: "fish.fill", emojis: ["🐳", "🦭", "🐬", "🐟", "🐠", "🐡", "🦈", "🐙", "🪼"]), // ocean
        .init(name: "Street Food", iconName: "fork.knife", emojis: ["🍔", "🍟", "🍕", "🌭", "🌮", "🌯", "🍿", "🍣", "🍜"]), // street food

    ]
    @State var chosenThemeIndex = 0
    @State var cardCount: Int = 4

    var body: some View {
        VStack {
            title
            ScrollView {
                self.cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }

    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }

    var cards: some View {
        let emojis = (themes[chosenThemeIndex].emojis + themes[chosenThemeIndex].emojis).shuffled()

        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var themeButtons: some View {
        HStack {
            ForEach(Array(themes.enumerated()), id: \.0) { (index, theme) in
                Button(action: {
                    chosenThemeIndex = index
                }, label: {
                    VStack {
                        Image(systemName: theme.iconName)
                            .imageScale(.large)
                        Text(theme.name)
                    }
                })
                .padding()
            }
        }
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

struct Theme {

    let name: String
    let iconName: String
    var emojis: Array<String>

}

#Preview {
    ContentView()
}
