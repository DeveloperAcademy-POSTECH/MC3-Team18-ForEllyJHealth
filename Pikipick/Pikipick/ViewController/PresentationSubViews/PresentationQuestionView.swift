//
//  PTQuestionView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/28.
//

import SwiftUI

struct PresentationQuestionView: View {
    
    @State var selectedIdx = -1
    
    private let questionListSample = ["테스트 질문입니다.", "questionque stionquestio nque stionquestion questionqu esti on questionquestion question", "질문이 잘 작성됩니다.", "question", "question", "테스트 질문입니다.", "question", "테스트 질문입니다."]
    private let previewSliderWidth: CGFloat = 280
    
    var body: some View {
        HStack {
            //장식
            Color.primaryColor
                .frame(width: 4)
                .padding(.trailing, 64) // 우측 버튼을 위한 공백처리
            
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach (0 ..< questionListSample.count) { idx in
                        Button {
                            selectedIdx = (selectedIdx != idx) ? idx : -1
                        } label: {
                            QuestionButtonView(question: questionListSample[idx], isSelected: selectedIdx == idx ? true : false)
                        }
                    }
                } // scrollview
            } // vstack
            .frame(width: previewSliderWidth)
            .padding(.top)
            
            // 선택된 질문 보여주는 뷰
            VStack {
                Color.primaryColor
                    .frame(height: 8)
                HStack {
                    Image("emoji_questions_24px")
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("Question")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
                ScrollView {
                    Text(selectedIdx == -1 ? "질문을 선택해주세요." : questionListSample[selectedIdx])
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding([.horizontal, .bottom])
                }
            } // vstack
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color.secondaryColor)
            .cornerRadius(10)
            .padding(.top, 88)
            .padding(.bottom, 28)
            .padding(.horizontal)
        }
    }
}

struct PresentationQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationQuestionView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
