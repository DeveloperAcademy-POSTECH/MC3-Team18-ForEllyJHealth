//
//  PTVoteListView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/27.
//

import SwiftUI

struct PTVoteListView: View {
    
    @Binding var selectedVoteType: VoteType
    @Binding var viewMode: Mode
    
    private let voteTypeList : [VoteType] = [VoteType.yesNo, VoteType.opt2, VoteType.opt3, VoteType.opt4]
    
    var body: some View {
        HStack {
            // YesNo
            Button {
                selectedVoteType = voteTypeList[0]
                viewMode = .vote
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.secondaryColor, lineWidth: 1)
                    GeometryReader{ g in
                        VStack {
                            HStack {
                                Text("Yes")
                                    .font(.system(size: 48))
                                    .bold()
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Text("No")
                                    .font(.system(size: 48))
                                    .bold()
                            }
                        }
                        
                        Path() { path in
                            path.move(to: CGPoint(x: 10, y: g.size.height * 0.85))
                            path.addLine(to: CGPoint(x: g.size.width * 0.9, y: g.size.height * 0.2))
                        }
                        .stroke(Color.accentColor, lineWidth: 1)
                    }//geometryReader
                    .padding()
                }//zstack
                
                .background(Color.secondaryGradient)
                .aspectRatio(0.8, contentMode: .fit)
                .cornerRadius(20)
            }
            // 234
            ForEach (1 ..< 4) { idx in
                Button {
                    selectedVoteType = voteTypeList[idx]
                    viewMode = .vote
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("secondaryColor"), lineWidth: 1)
                        
                        Text("Options")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                        
                        Text(String(idx + 1))
                            .font(.system(size: 96))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding()
                    }
                    .background(Color.secondaryGradient)
                    .aspectRatio(0.8, contentMode: .fit)
                    .cornerRadius(20)
                }
            }
        }
        .padding()
        .accentColor(Color("primaryColor"))
    }
}

struct PTVoteListView_Previews: PreviewProvider {
    static var previews: some View {
        PTVoteListView(selectedVoteType: .constant(.yesNo), viewMode: .constant(.votelist))
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
