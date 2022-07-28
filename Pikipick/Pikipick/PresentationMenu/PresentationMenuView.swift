//
//  ButtonTestView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/26.
//

import SwiftUI

struct PresentationMenuView: View {
    @Binding var viewMode: ViewMode
    @State var isExpanded = false
    
    private let dividerColor = Color.dividerColor
    private let buttonWH: CGFloat = 44
    private let txtMaxCount = 18
    private let deviceName = UIDevice.current.name
    
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    Spacer()
                    HStack(spacing: 0) {
                        
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(isExpanded ? "icn_chevron_right_32px" : "icn_chevron_left_32px")
                                .resizable()
                                .frame(width: buttonWH, height: buttonWH)
                        }
                        
                        HStack(spacing: 0) {
                            PresentationMenuButtonListView(viewMode: $viewMode, dividerColor: dividerColor)
                                .frame(height:buttonWH)
                        }
                        .scaleEffect(x: isExpanded ? 1 : 0, y: 1, anchor: .center)
                        .frame(width: isExpanded ? 192 : 0)
                        .opacity(isExpanded ? 1 : 0)
                        
                        Divider()
                            .frame(height: buttonWH)
                            .overlay(dividerColor)
                        
                        Text(deviceName.count > txtMaxCount ? deviceName.substring(from: 0, to: txtMaxCount) : deviceName)
                            .frame(minWidth: 36)
                            .foregroundColor(.white)
                            .padding([.horizontal])
                            .padding([.vertical], 8)
                    }
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondaryColor)
                        .animation(.default, value: isExpanded))
                }.padding(.top)
                Spacer()
            }
        }
    }
}

struct PresentationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationMenuView(viewMode: .constant(.home))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
