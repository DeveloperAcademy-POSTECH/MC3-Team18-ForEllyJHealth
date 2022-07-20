//
//  EmojiAnimView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/20.
//
import SwiftUI
import Combine

struct Emoji: Hashable {
    var emoticon: String
    var count: Int = 0
}

struct ButtonActionView: View {
    
    
    @StateObject var presenter = SessionPresenter()
    @State var currentEmoji: String = ""
    // 컴바인을 어찌하고싶은지 확인하는것
    // 참고자료.. 확인해보세요..
    //https://zeddios.tistory.com/925
    // 출처: https://zeddios.tistory.com/925 [ZeddiOS:티스토리]
    //    let subscriber = presenter.sink { (value) in
    //        print(value)
    //    }
    //        .onChange(of: SessionPresenter.currentEmoji?.rawValue) { value in
    //            print(value)
    //        }
    
    @State var isPresentationReady : Bool = false
    //컴바인 섭스크라이브를 참고
    
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
                ButtonAnimView(emoji: $emoji[i], presenter: presenter)
            }
        }
        .onAppear(){
            print("BROWSING START!")
            presenter.startBrowsing()
            presenter.startAdvertise()
            //            presenter.publisher(for: <#T##KeyPath<Self, Value>#>, options: <#T##Foundation.NSKeyValueObservingOptions#>)
        }
        .onDisappear(){
            print("BROWSING STOP!")
            presenter.stopAdvertise()
            presenter.stopBrowsing()
            presenter.sessionDisconnect()
        }
    }
}

//struct ButtonActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonActionView()
//    }
//}
