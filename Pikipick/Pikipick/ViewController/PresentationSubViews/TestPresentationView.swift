//
//  TestPresentationView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/26.
//

import SwiftUI

enum mode: String {
    case home, votelist, vote, question
}

struct TestPresentationView: View {
    
    @State var viewMode: mode = .home
    var body: some View {
        
        ZStack{
            VStack{
                HStack {
                    Button{
                        viewMode = .home
                    } label: {
                        ZStack{
                            Circle()
                                .strokeBorder(Color("secondaryColor"), lineWidth: 1)
                                .frame(width: 44, height: 44, alignment: .center)
                                .foregroundColor(.black)
                            // TODO: 그라데이션 적용 필요
                            
                            Image("icn_chevron_left_32px")
                                .frame(width: 32, height: 32)
                        }
                    }
                    Spacer()
                    Text("Cool's")
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 44, alignment: .center)
                    // TODO: 프레임 최솟값 사용할지 확인 필요.
                        .background(Color("secondaryColor"))
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
            
            switch viewMode {
            case .home:
                HomePresentationView(viewMode: $viewMode)
            case .votelist:
                VStack{
                    Spacer()
                    PTVoteListView()
                        .padding(.bottom)
                }
            case .vote:
                Text("question")
                
            case .question:
                Text("question")
            }
        }
//        .ignoresSafeArea()
        .edgesIgnoringSafeArea([.leading])
        // MARK: 좋은 방식 없을까?
//        ignoresSafeArea(.container, edges: .top)
        .background(Color("backgroundColor"))
        .accentColor(Color("primaryColor"))
    }
}

struct TestPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        TestPresentationView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

