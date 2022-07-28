//
//  PresentationMenuBView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import SwiftUI

struct PresentationMenuButtonListView: View {
    
    let dividerColor: Color
    
    var body: some View {
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: MenuButtonViewType.close.name, buttonTextColor:  MenuButtonViewType.close.color,transferViewType: MenuButtonViewType.close)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: MenuButtonViewType.vote.name, buttonTextColor:  MenuButtonViewType.vote.color, transferViewType: MenuButtonViewType.vote)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(buttonName: MenuButtonViewType.qAndA.name, buttonTextColor:  MenuButtonViewType.qAndA.color, transferViewType: MenuButtonViewType.qAndA)
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
            case .qAndA:
                print("QuestionButton Pressed")
                break
            }
        }) {
            Text(buttonName)
                .font(.system(.caption))
                .foregroundColor(buttonTextColor)
        }
        .frame(width:64)
    }
}

