//
//  PresentationMenuBView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import SwiftUI

// https://swifttom.com/2020/10/23/how-to-make-a-expandable-button-in-swiftui/
struct PresentationMenuButtonView: View {
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

