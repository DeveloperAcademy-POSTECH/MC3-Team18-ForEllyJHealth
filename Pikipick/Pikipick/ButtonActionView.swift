//
//  EmojiAnimView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/20.
//
import SwiftUI

struct Emoji: Hashable {
    var emoticon: String
    var count: Int = 0
}

struct ButtonActionView: View {
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
            ForEach(0 ..< emoji.count, id:\.self){ i in
            ButtonAnimView(emoji: $emoji[i])
            }
        }
    }
}

struct ButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionView()
    }
}
