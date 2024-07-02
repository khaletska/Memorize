//
//  ContentView.swift
//  Memorize
//
//  Created by Yeliena Khaletska on 30.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State var chosenTheme: Theme = .getRandom()

    var body: some View {
        VStack {
            self.title
            ScrollView {
                self.cards
            }
            Spacer()
            self.themeButtons
        }
        .padding()
    }

    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }

    var cards: some View {
        let emojis = (self.chosenTheme.emojis + self.chosenTheme.emojis).shuffled()

        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: false)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var themeButtons: some View {
        HStack {
            ForEach(Theme.all, id: \.self) { theme in
                Button(action: {
                    self.chosenTheme = theme
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

struct Theme: Hashable {

    let name: String
    let iconName: String
    var emojis: Array<String>

    static func getRandom() -> Theme {
        Self.all.randomElement()!
    }

    static let all: [Theme] = [
        .init(name: "Pastry", iconName: "birthday.cake", emojis: ["🍞", "🥐", "🥖", "🥨", "🥯", "🥞", "🧇", "🍩", "🍪"]), // pastry
        .init(name: "Ocean", iconName: "fish", emojis: ["🐳", "🦭", "🐬", "🐟", "🐠", "🐡", "🦈", "🐙", "🪼"]), // ocean
        .init(name: "Food", iconName: "fork.knife", emojis: ["🍔", "🍟", "🍕", "🌭", "🌮", "🌯", "🍿", "🍣", "🍜"]), // street food
    ]
}

#Preview {
    ContentView()
}
