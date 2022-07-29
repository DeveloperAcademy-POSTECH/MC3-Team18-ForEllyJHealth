//
//  PresentationMenuBView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import SwiftUI

struct PresentationMenuButtonListView: View {
    @Binding var viewMode: ViewMode
    let dividerColor: Color
    
    var body: some View {
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(viewMode: $viewMode, buttonName: MenuButtonViewType.close.name, buttonTextColor:  MenuButtonViewType.close.color,transferViewType: MenuButtonViewType.close)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(viewMode: $viewMode, buttonName: MenuButtonViewType.vote.name, buttonTextColor:  MenuButtonViewType.vote.color, transferViewType: MenuButtonViewType.vote)
        Divider()
            .overlay(dividerColor)
        PresentationMenuButtonView(viewMode: $viewMode, buttonName: MenuButtonViewType.qAndA.name, buttonTextColor:  MenuButtonViewType.qAndA.color, transferViewType: MenuButtonViewType.qAndA)
    }
}


// https://swifttom.com/2020/10/23/how-to-make-a-expandable-button-in-swiftui/
struct PresentationMenuButtonView: View {
    @Environment (\.dismiss) var dismiss
    @State private var showingAlert = false
    @Binding var viewMode: ViewMode
    
    var buttonName: String
    var buttonTextColor: Color
    var transferViewType: MenuButtonViewType
    
    var body: some View {
        Button(action: {
            switch transferViewType {
            case .close:
                showingAlert.toggle()
                print("CloseButton Pressed")
            case .vote:
                viewMode = .votelist
                print("VoteButton Pressed")
            case .qAndA:
                viewMode = .question
                print("QuestionButton Pressed")
            }
        }) {
            Text(buttonName)
                .font(.system(.caption))
                .foregroundColor(buttonTextColor)
        }
        .frame(width:64)
        .alert("End Presentation",isPresented: $showingAlert) {
            Button("Exit", role: .destructive) {
                AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    dismiss()
                })
            }
        } message: {
            Text("If you exit, the question and voting you recieved will disappear.")
        }
    }
}

