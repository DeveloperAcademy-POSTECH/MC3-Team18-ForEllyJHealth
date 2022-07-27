//
//  PresentationMenuBView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import SwiftUI

struct PresentationMenuButtonListView: View {
    
    var dividerColor: Color
    
    private let closeButtonColor = Color.closeButtonColor
    private let defaultTextColor = Color.white
    
    var body: some View {
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: "CLOSE", buttonTextColor: closeButtonColor,transferViewType: MenuButtonViewType.close)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: "VOTE", buttonTextColor: defaultTextColor, transferViewType: MenuButtonViewType.vote)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: "Q&A", buttonTextColor: defaultTextColor, transferViewType: MenuButtonViewType.question)
    }
}


// https://swifttom.com/2020/10/23/how-to-make-a-expandable-button-in-swiftui/
struct PresentationMenuButtonView: View {
    var buttonName: String
    var buttonTextColor: Color
    var transferViewType: MenuButtonViewType
    
    var body: some View {
        Button(action: {
            switch transferViewType {
            case .close:
                print("CloseButton Pressed")
            case .vote:
                print("VoteButton Pressed")
                break
            case .question:
                print("QuestionButton Pressed")
                break
            }
        }) {
            Text(buttonName)
                .font(.system(.caption))
                .foregroundColor(buttonTextColor)
        }
        .frame(width:64, height: 24)
    }
}

