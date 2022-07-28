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
    var emojiSize: CGFloat
    var opacity: Double
}

struct ButtonAnimView: View {
    @ObservedObject var presenter: SessionPresenter
    
    @State var animate = [false]
    @State var finishedAnimationCouter = 0
    @State var counter = 0
    @Binding var emoji: Emoji
    
    private let identifierLength = 39 // Emoji Identifier(3) + uuidLength(36)
    
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
            .background {
                Circle()
                    .fill(Color.black)
                    .frame(width: 44, height: 44, alignment: .center)
                Circle()
                    .fill(Color.backgroundColor)
                    .frame(width: 40, height: 40, alignment: .center)
                Circle()
                    .fill(Color.secondaryGradient)
                    .frame(width: 36, height: 36, alignment: .center)
            }
            .frame(width: 40)
        }
        .onChange(of: presenter.receivedData ?? "", perform: { receivedData in
            let dataEndIndex = receivedData.count - 1
            let emojiData = receivedData.substring(from: identifierLength, to: dataEndIndex)
            if emojiData == emoji.emoticon
            {
                animate[counter].toggle()
                animate.append(false)
                counter += 1
            }
        })
    }
}

//ref: https://www.youtube.com/watch?v=S7hhHc9FgnY&t=639s
struct ConfettiContainer: View {
    @State var movement = Movement(x: 0, y: 0, emojiSize: 0.1, opacity: 0)
    @State var animationValues: [Bool] = Array(repeating: false, count: 5)
    @State var emojiPositionSet = false
    @Binding var animate: Bool
    @Binding var emoji: Emoji
    @Binding var finishedAnimationCouter: Int
    
    var body: some View{
        Text(emoji.emoticon)
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.emojiSize)
            .opacity(movement.opacity)
            .onChange(of: animate) { _ in
                withAnimation(Animation.easeOut(duration: 0.4)) {
                    emojiPositionSet.toggle()
                    movement.opacity = 1
                    movement.emojiSize = 20 * movement.emojiSize
                    movement.x = UIScreen.screenHalfWidth * CGFloat.random(in: -0.4...0.4)
                    movement.y = -UIScreen.screenHalfHeight * CGFloat.random(in: 0.4...0.8)
                    withAnimation(.easeInOut(duration: 0.35)){
                        animationValues[0] = true
                    }
                    withAnimation(.easeInOut(duration: 0.45).delay(0.06)){
                        animationValues[1] = true
                    }
                    withAnimation(.easeInOut(duration: 0.35).delay(0.3)){
                        animationValues[2] = true
                    }
                    withAnimation(.easeInOut(duration: 0.35).delay(0.4)){
                        animationValues[3] = true
                    }
                    withAnimation(.easeInOut(duration: 0.55).delay(0.55)){
                        animationValues[4] = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    
                    withAnimation(Animation.easeIn(duration: 3)) {
                        movement.y = 200
                        movement.opacity = 0.0
                    }
                }
            }
            .overlay() {
                
                ForEach(1...20,id: \.self){index in
                    Circle()
                        .fill(Color.primaryGradient)
                        .frame(width: .random(in: 3...5), height: .random(in: 3...5))
                        .offset(x: .random(in: -5...5), y: .random(in: -5...5))
                        .offset(x: animationValues[3] ? 45 : 10)
                        .rotationEffect(.init(degrees: Double(index) * 18.0))
                        .scaleEffect(animationValues[2] ? 1 : 0.01)
                        .opacity(animationValues[4] ? 0 : 1)
                }
                .position(x: movement.x * 2 + 12, y: movement.y * 2 + 12)
                
                
            }
            .onChange(of: emojiPositionSet) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    withAnimation(.easeInOut(duration: 0.35)){
                        animationValues[0] = true
                    }
                    withAnimation(.easeInOut(duration: 0.45).delay(0.06)){
                        animationValues[1] = true
                    }
                    withAnimation(.easeInOut(duration: 0.35).delay(0.3)){
                        animationValues[2] = true
                    }
                    withAnimation(.easeInOut(duration: 0.35).delay(0.4)){
                        animationValues[3] = true
                    }
                    withAnimation(.easeInOut(duration: 0.55).delay(0.55)){
                        animationValues[4] = true
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
