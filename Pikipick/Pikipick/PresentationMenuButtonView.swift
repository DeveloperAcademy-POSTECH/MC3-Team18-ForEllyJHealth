//
//  ButtonTestView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/26.
//

import SwiftUI

// https://swifttom.com/2020/10/23/how-to-make-a-expandable-button-in-swiftui/
struct MenuButton: View {
    var buttonName: String
    var buttonTextColor: Color
    
    private let fontSize = CGFloat(12)
    var body: some View {
        Button(action: {
            print("Menu Button tapped")
            
        }) {
            Text(buttonName)
                .font(.system(size: fontSize))
                .foregroundColor(buttonTextColor)
        }
        .frame(width:64, height: 24)
    }
}

struct PresentationMenuButtonView: View {
    @State var isExpanded = false
    @State private var scale = 1.0
    
    var deviceName: String
    private let buttonWH = CGFloat(32)
    private let textHorPadding = CGFloat(16)
    private let viewHorPadding = CGFloat(24)
    private let deviceNameWidth = CGFloat(166)
    private let defaultTextColor = Color.white
    private let closeButtonColor = Color.closeButtonColor
    private let bgNonExpandedFrameWidth = CGFloat(230)
    private let bgExpandedFrameWidth = CGFloat(422)
    private let bgHeight = CGFloat(40)
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondaryColor)
                        .frame(width: isExpanded ? bgExpandedFrameWidth : bgNonExpandedFrameWidth, height: bgHeight, alignment: .trailing)
                        .animation(.easeInOut(duration: 0.1), value: isExpanded)
                }
                HStack(spacing: 0) {
                    Spacer()
                    Group {
                        Button(action: {
                            print("Expandable button tapped!!!")
                            isExpanded.toggle()
                            
                        }) {
                            Image(isExpanded ? "icn_chevron_right_32px" : "icn_chevron_left_32px")
                                .resizable()
                                .frame(width: buttonWH, height: buttonWH)
                        }.animation(.spring(), value: scale)
                            
                        if isExpanded {
                            Divider()
                                .frame(height: buttonWH)
                                .overlay(Color.dividerColor)
                            MenuButton(buttonName: "CLOSE", buttonTextColor: closeButtonColor)
                            Divider()
                                .frame(height: buttonWH)
                                .overlay(Color.dividerColor)
                            MenuButton(buttonName: "VOTE", buttonTextColor: defaultTextColor)
                            Divider()
                                .frame(height: buttonWH)
                                .overlay(Color.dividerColor)
                            MenuButton(buttonName: "Q&A", buttonTextColor: defaultTextColor)
                        }
                        Divider()
                            .frame(height: buttonWH)
                            .overlay(Color.dividerColor)
                        Text(deviceName)
                            .frame(width: deviceNameWidth)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .padding([.horizontal], textHorPadding)
                    }
                    
                }
            }
            .padding([.top], viewHorPadding)
            Spacer()
        }
        .background(.black)
    }
}

struct PresentationMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        PresentationMenuButtonView(deviceName: "AAA - IOS - POS - 111")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
