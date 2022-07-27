//
//  TestPresentationView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/26.
//

import SwiftUI

enum ViewMode: String {
    case home, votelist, vote, question
}

struct TestPresentationView: View {
    
    @State var viewMode: ViewMode = .home
    @State var selectedVoteType : VoteType = .yesNo
    
    private let buttonSize: CGFloat = 44
    
    var body: some View {
        
        ZStack{
            VStack{
                HStack {
                    switch viewMode {
                    case .home:
                        Spacer()
                        
                    case .votelist, .question:
                        Group{
                            Button{
                                viewMode = .home
                            } label: {
                                CircleNavigationButton(icnName: "icn_close_32px", buttonSize: buttonSize)
                            }
                            Spacer()
                        }
                    case .vote:
                        Group{
                            Button{
                                viewMode = .votelist
                            } label: {
                                CircleNavigationButton(icnName: "icn_chevron_left_32px", buttonSize: buttonSize)
                            }
                            Spacer()
                            Button{
                                //  refresh counts
                            } label: {
                                CircleNavigationButton(icnName: "icn_autorenew_24px", buttonSize: buttonSize)
                            }
                        }
                    }
                    
                    Text("Cool's")
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: buttonSize, alignment: .center)
                    // TODO: 프레임 최솟값 사용할지 확인 필요.
                        .background(Color.secondaryColor)
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
                    PTVoteListView(selectedVoteType: $selectedVoteType, viewMode: $viewMode)
                        .padding(.top, 60)
                }
            case .vote:
                PTVoteView(selectedVoteType: selectedVoteType)
                    .padding(.vertical, 8)
            case .question:
                PTQuestionView()
            }
        }
        .edgesIgnoringSafeArea([.leading])
        // TODO: 뷰 오리엔테이션 추적가능? 오케이 적용가능
        
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


struct CircleNavigationButton: View {
    let icnName: String
    let buttonSize: CGFloat
    
    var body: some View {
        ZStack{
            Color.secondaryGradient
                .frame(width: buttonSize, height: buttonSize, alignment: .center)
                .clipShape(Circle())
            Circle()
                .strokeBorder(Color("secondaryColor"), lineWidth: 1)
                .frame(width: buttonSize, height: buttonSize, alignment: .center)
            Image(icnName)
        }
    }
}
