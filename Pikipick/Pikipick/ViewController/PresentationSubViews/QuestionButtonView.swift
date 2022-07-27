//
//  QuestionButtonView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/28.
//

import SwiftUI

struct QuestionButtonView: View {
    
    let question: String
    let isSelected: Bool

    
    var body: some View {
            HStack {
                Text(question)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ZStack {
                    Circle()
                        .foregroundColor(.black)
                    Circle()
                        .foregroundColor(.backgroundColor)
                        .padding(1)
                    
                    if isSelected {
                        Color.primaryGradient
                            .clipShape(Circle())
                            .padding(3)
                        Image("emoji_hand_yellow_16px")
                            .frame(width: 16, height: 16, alignment: .center)
                    } else {
                        Color.secondaryGradient
                            .clipShape(Circle())
                            .padding(3)
                        Image("emoji_hand_white_16px")
                            .frame(width: 16, height: 16, alignment: .center)
                    }
                }
                .frame(width: 32, height: 32, alignment: .center)
                .padding(.trailing, 8)
                .padding([.top,.bottom], 10)
            }
            .background(Color.secondaryColor)
            .cornerRadius(20)
    }
}

struct QuestionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionButtonView(question: "question", isSelected: true)
    }
}
