//
//  ButtonTestView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/26.
//

import SwiftUI

struct PresentationMenuView: View {
    @State var isExpanded = false
    @State private var scale = 1.0
    
    var deviceName: String
    
    private let dividerColor = Color.dividerColor
    private let buttonWH: CGFloat = 32
    private let txtMaxLength = 18
    
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    Spacer()
                    HStack(spacing: 0) {
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Image(isExpanded ? "icn_chevron_right_32px" : "icn_chevron_left_32px")
                                .resizable()
                                .frame(width: buttonWH, height: buttonWH)
                        }.animation(.spring(), value: scale)
                        
                        if isExpanded {
                            PresentationMenuButtonListView(dividerColor: dividerColor)
                                .frame(height:buttonWH)
                        }
                        
                        Divider()
                            .frame(height: buttonWH)
                            .overlay(dividerColor)
                        Text(deviceName.count > txtMaxLength ? deviceName.substring(from: 0, to: txtMaxLength) : deviceName)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(minWidth: 36)
                            .foregroundColor(.white)
                            .padding([.horizontal])
                            .padding([.vertical], 8)
                    }
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondaryColor)
                        .animation(.easeInOut(duration: 0.1), value: isExpanded))
                }.padding(.top)
                Spacer()
            }
        }
    }
}

struct PresentationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        let testTxt = "Preview Test Text__"
        
        PresentationMenuView(deviceName:testTxt)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
