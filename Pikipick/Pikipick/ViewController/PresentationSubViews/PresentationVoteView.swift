//
//  PTVoteView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/27.
//

import SwiftUI

enum VoteType: CaseIterable {
    case yesNo, opt2, opt3, opt4
    
    var options: [String] {
        switch self {
        case .yesNo:
            return ["emoji_man_ok_32px", "emoji_woman_no_32px"]
        case .opt2:
            return ["emoji_one_32px", "emoji_two_32px"]
        case .opt3:
            return ["emoji_one_32px", "emoji_two_32px", "emoji_three_32px"]
        case .opt4:
            return ["emoji_one_32px", "emoji_two_32px", "emoji_three_32px", "emoji_four_32px"]
        }
    }
    
    var viewSpacing: CGFloat {
        switch self{
        case .yesNo:
            return 32
        case .opt2:
            return 32
        case .opt3:
            return 24
        case .opt4:
            return 16
        }
    }
    
    var viewRatio: CGFloat {
        switch self{
        case .yesNo:
            return 1.2
        case .opt2:
            return 1.2
        case .opt3:
            return 1
        case .opt4:
            return 0.8
        }
    }
    
    // MARK: 데이터 처리를 위해서 -> 딕셔너리에 할당된 이넘의 케이스를 넣어주어야함
    var emojiTag: [String] {
        switch self {
        case .yesNo:
            return ["emoji_man_ok_32px", "emoji_woman_no_32px"]
        case .opt2:
            return ["emoji_one_32px", "emoji_two_32px"]
        case .opt3:
            return ["emoji_one_32px", "emoji_two_32px", "emoji_three_32px"]
        case .opt4:
            return ["emoji_one_32px", "emoji_two_32px", "emoji_three_32px", "emoji_four_32px"]
        }
    }
}

struct PTVoteView: View {
    
    let selectedVoteType : VoteType
    
    var body: some View {
        HStack(spacing: selectedVoteType.viewSpacing) {
            Spacer()
            ForEach (0 ..< selectedVoteType.options.count) { idx in
                ZStack(alignment: .top) {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .overlay(Color.secondaryGradient)
                            .cornerRadius(30)
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(Color.secondaryColor, lineWidth: 1)
                        Text("11")
                        // TODO: 인덱스에 맞게 해당 위치에 대한 값을 반환해주어야함.
                            .foregroundColor(.accentColor)
                            .font(.system(size: 96))
                            .bold()
                    }
                    .aspectRatio(selectedVoteType.viewRatio, contentMode: .fit)
                    .padding(.top, 36)

                    
                    ZStack {
                        Circle()
                        .foregroundColor(.black)
                        Circle()
                            .foregroundColor(Color.backgroundColor)
                            .padding(3)
                        Rectangle()
                            .overlay(Color.secondaryGradient)
                            .clipShape(Circle())
                            .padding(6)
                        Image(selectedVoteType.options[idx])
                    }
                    .frame(width: 72, height: 72, alignment: .center)
                }// zstack
                .accentColor(Color("primaryColor"))

            } //foreach
            Spacer()

        } // hstack
        .padding(.top, 60)
        .padding(.bottom)
        
    }
}

struct PTVoteView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        PTVoteView(selectedVoteType: .yesNo)
            .previewInterfaceOrientation(.landscapeLeft)
        PTVoteView(selectedVoteType: .opt3)
            .previewInterfaceOrientation(.landscapeLeft)
        PTVoteView(selectedVoteType: .opt4)
            .previewInterfaceOrientation(.landscapeLeft)
        }
        .preferredColorScheme(.dark)
    }
}
