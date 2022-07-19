//
//  MarvelousButtonView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import ConfettiSwiftUI
import SwiftUI

struct MarvelousMovement{
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var opacity: Double
}

struct MarvelousButtonView: View {
    @State var animate = [false]
    @State var finishedAnimationCouter = 0
    @State var counter = 0
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(finishedAnimationCouter...counter, id:\.self){ i in
                    MarvelousConfettiContainer(animate:$animate[i], finishedAnimationCouter:$finishedAnimationCouter, num:1)
                }
            }
            
            Button("👏"){
                animate[counter].toggle()
                animate.append(false)
                counter+=1
            }
        }
    }
}

struct MarvelousConfettiContainer: View {
    @Binding var animate:Bool
    @Binding var finishedAnimationCouter:Int

    var num:Int
    
    var body: some View{
        ZStack{
            ForEach(0...num-1, id:\.self){ _ in
                MarvelousConfetti(animate: $animate, finishedAnimationCouter:$finishedAnimationCouter)
            }
        }
        .onChange(of: animate){_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                finishedAnimationCouter+=1
            }
        }
    }
}

struct MarvelousConfetti: View{
    @Binding var animate:Bool
    @Binding var finishedAnimationCouter:Int
    @State var movement = MarvelousMovement(x: 0, y: 0, z: 1, opacity: 0)
    

    var body: some View{
        Text("👏")
            .frame(width: 50, height: 50, alignment: .center)
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.z)
            .opacity(movement.opacity)
            .onChange(of: animate) { _ in
                withAnimation(Animation.easeOut(duration: 0.4)) {
                    movement.opacity = 1
                    movement.x = CGFloat.random(in: -300...400)
                    movement.y = -300 * CGFloat.random(in: 0.5...0.9)
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
