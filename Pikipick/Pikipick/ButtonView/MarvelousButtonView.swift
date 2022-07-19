//
//  MarvelousButtonView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

//ConfettiSwiftUi 라이브러리 사용
//ref : https://github.com/simibac/ConfettiSwiftUI

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
     
            ZStack{
                //애니메이션을 하나씩 실행합니다.
                ForEach(finishedAnimationCouter...counter, id:\.self){ i in
                    MarvelousConfettiContainer(animate:$animate[i], finishedAnimationCouter:$finishedAnimationCouter, num:1)
                }
                //Button의 counter 가 트리거 역할을 합니다. counter가 변경될때 애니메이션이 작동합니다.
                Button("👏"){
                    animate[counter].toggle()
                    animate.append(false)
                    counter+=1
                }
            }
        }
    }

//애니메이션이 실행될 컨테이너를 그려주는 뷰입니다.
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
//구체적인 애니메이션을 설정할 수 있는 뷰입니다.
struct MarvelousConfetti: View{
    @Binding var animate:Bool
    @Binding var finishedAnimationCouter:Int
    @State var movement = MarvelousMovement(x: 0, y: 0, z: 1, opacity: 0)
    

    var body: some View{
        Text("👏")
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.z)
            .opacity(movement.opacity)
            .onChange(of: animate) { _ in
                withAnimation(Animation.easeOut(duration: 0.4)) {
                    movement.opacity = 1
                    //랜덤하게 애니메이션을 보여줄 가로축 길이입니다.
                    movement.x = CGFloat.random(in: -300...400)
                    //랜덤하게 애니메이션을 보여줄 세로축 길이입니다.
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

struct MarvelousButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelousButtonView()
    }
}
