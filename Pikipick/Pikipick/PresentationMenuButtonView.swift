//
//  ButtonTestView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/26.
//

import SwiftUI

// https://swifttom.com/2020/10/23/how-to-make-a-expandable-button-in-swiftui/
struct MenuButtons: View {
    var buttonName: String
    var buttonColor: Color
    
    var body: some View {
        Button(action: {
            print("Menu Button tapped")
            
        }) {
            Text(buttonName)
                .font(.system(size: 12))
                .foregroundColor(buttonColor)
        }
        .frame(width:64, height: 24)
    }
}

struct PresentationMenuButtonView: View {
    var deviceName: String
    @State var isExpanded = false
    @State private var scale = 1.0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondaryColor)
                        .frame(width: isExpanded ? 422 : 230, height: 40, alignment: .trailing)
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
                                .frame(width: 32, height: 32)
                        }.animation(.spring(), value: scale)
                            
                        if isExpanded {
                            Divider()
                                .frame(height: 32)
                                .overlay(Color.dividerColor)
                            MenuButtons(buttonName: "CLOSE", buttonColor: Color.closeButtonColor)
                            Divider()
                                .frame(height: 32)
                                .overlay(Color.dividerColor)
                            MenuButtons(buttonName: "VOTE", buttonColor: .white)
                            Divider()
                                .frame(height: 32)
                                .overlay(Color.dividerColor)
                            MenuButtons(buttonName: "Q&A", buttonColor: .white)
                        }
                        Divider()
                            .frame(height: 32)
                            .overlay(Color.dividerColor)
                        Text(deviceName)
                            .frame(width: 166)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .padding([.horizontal], 16)
                    }
                    
                }
            }
            .padding([.top], 24)
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
