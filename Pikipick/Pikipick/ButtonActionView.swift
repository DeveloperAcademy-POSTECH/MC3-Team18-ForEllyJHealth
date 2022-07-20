//
//  EmojiAnimView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/20.
//

import Combine
import SwiftUI

struct Emoji: Hashable {
    var emoticon: String
    var count: Int = 0
}

struct ButtonActionView: View {
    
    @StateObject var presenter = SessionPresenter()
    
    @State var currentEmoji: String = ""
    @State private var counter: Int = 0
    @State var emoji = [
        Emoji(emoticon: "👏"),
        Emoji(emoticon: "😮"),
        Emoji(emoticon: "🎉"),
        Emoji(emoticon: "🔥"),
        Emoji(emoticon: "🤔"),
        Emoji(emoticon: "👍"),
    ]
    
    var body: some View {
        HStack {
            ForEach(0 ..< emoji.count, id:\.self){ index in
                ButtonAnimView(presenter: presenter, emoji: $emoji[index])
            }
        }
        .onAppear(){
            print("BROWSING START!")
            presenter.startBrowsing()
            presenter.startAdvertise()
        }
        .onDisappear(){
            print("BROWSING STOP!")
            presenter.stopAdvertise()
            presenter.stopBrowsing()
            presenter.sessionDisconnect()
        }
    }
}

struct ButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionView()
    }
}
