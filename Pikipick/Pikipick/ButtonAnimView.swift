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
    @State var animate = [false]
    @State var finishedAnimationCouter = 0
    @State var counter = 0
    @Binding var emoji: Emoji
    
    var body: some View {
        
            ZStack{
                ForEach(finishedAnimationCouter...counter, id:\.self){ i in
                    ConfettiContainer(animate:$animate[i], finishedAnimationCouter:$finishedAnimationCouter,emoji: $emoji ,num:1)
                }
                Button(emoji.emoticon){
                    animate[counter].toggle()
                    animate.append(false)
                    counter+=1
                }
            }
        }
    }
struct ConfettiContainer: View {
    @Binding var animate:Bool
    @Binding var finishedAnimationCouter:Int
    @State var movement = Movement(x: 0, y: 0, z: 1, opacity: 0)
    @Binding var emoji: Emoji
    var num:Int
    
    var body: some View{
        ZStack{
            ForEach(0...num-1, id:\.self){ _ in
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
        }
        .onChange(of: animate){_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                finishedAnimationCouter+=1
            }
        }
    }
}
