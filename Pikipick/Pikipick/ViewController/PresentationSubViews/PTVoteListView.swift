//
//  PTVoteListView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/27.
//

import SwiftUI

struct PTVoteListView: View {
    var body: some View {
        HStack {
            // YesNo
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("secondaryColor"), lineWidth: 1)
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
                        
                        //라인 그려야함.
                        Path() { path in
                            path.move(to: CGPoint(x: 10, y: g.size.height * 0.85))
                            path.addLine(to: CGPoint(x: g.size.width * 0.9, y: g.size.height * 0.2))
                        }
                        .stroke(Color.accentColor, lineWidth: 1)
                    }//geometryReader
                    .padding()
                }//zstack
                
                .background(.black)
                // TODO: 그라데이션 적용 필요
                .aspectRatio(0.8, contentMode: .fit)
                .cornerRadius(20)
            }
            // 234
            ForEach (2 ..< 5) { idx in
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("secondaryColor"), lineWidth: 1)
                        
                        Text("Options")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                        
                        Text(String(idx))
                            .font(.system(size: 96))
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding()
                    }
                    .background(.black)
                    // TODO: 그라데이션 적용 필요
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
        PTVoteListView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
