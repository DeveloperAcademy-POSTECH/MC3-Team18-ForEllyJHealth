//
//  SurprisingButtonView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct Movement{
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var opacity: Double
}

struct ButtonAnimView: View {
    @ObservedObject var presenter: SessionPresenter
    
    @State var animate = [false]
    @State var finishedAnimationCouter = 0
    @State var counter = 0
    @Binding var emoji: Emoji
    
    private let uuidLength = 36
    
    var body: some View {
        ZStack{
            ForEach(finishedAnimationCouter...counter, id:\.self) { i in
                ConfettiContainer(animate:$animate[i], emoji: $emoji, finishedAnimationCouter:$finishedAnimationCouter)
            }
            Button(emoji.emoticon){
                animate[counter].toggle()
                animate.append(false)
                counter += 1
            }
        }
        .onChange(of: presenter.receivedData ?? "", perform: { receivedData in
            let dataEndIndex = receivedData.count - 1
            let emojiData = receivedData.substring(from: uuidLength, to: dataEndIndex)
            if emojiData == emoji.emoticon
            {
                animate[counter].toggle()
                animate.append(false)
                counter += 1
            }
        })
    }
}

struct ConfettiContainer: View {
    @State var movement = Movement(x: 0, y: 0, z: 1, opacity: 0)
    @Binding var animate:Bool
    @Binding var emoji: Emoji
    @Binding var finishedAnimationCouter:Int
        
    var body: some View{
        ZStack{
            Text(emoji.emoticon)
                .offset(x: movement.x, y: movement.y)
                .scaleEffect(movement.z)
                .opacity(movement.opacity)
                .onChange(of: animate) { _ in
                    withAnimation(Animation.easeOut(duration: 0.4)) {
                        movement.opacity = 1
                        movement.x = CGFloat.random(in: -300...400)
                        movement.y = -300 * CGFloat.random(in: 0.3...0.8)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(Animation.easeIn(duration: 3)) {
                            movement.y = 200
                            movement.opacity = 0.0
                        }
                    }
                }
        }
        .onChange(of: animate) {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                finishedAnimationCouter += 1
            }
        }
    }
}
