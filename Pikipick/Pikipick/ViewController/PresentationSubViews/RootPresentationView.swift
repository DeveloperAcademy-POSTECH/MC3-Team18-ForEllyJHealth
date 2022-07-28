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

struct RootPresentationView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    @StateObject var presenter = SessionPresenter()

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
                                presenter.clearReceivedVoteList()
                            } label: {
                                CircleNavigationButton(icnName: "icn_autorenew_24px", buttonSize: buttonSize)
                            }
                        }
                    }
                    
                    Text(UIDevice.current.name)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: buttonSize, alignment: .center)
                    // TODO: 프레임 최솟값 사용할지 확인 필요.
                        .background(Color.secondaryColor)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .padding()
            
            switch viewMode {
            case .home:
                PresentationView(presenter: presenter, viewMode: $viewMode)
                
            case .votelist:
                VStack{
                    PresentationVoteListView(presenter: presenter, selectedVoteType: $selectedVoteType, viewMode: $viewMode)
                        .padding(.top, 60)
                }
            case .vote:
                PTVoteView(presenter: presenter, selectedVoteType: selectedVoteType)
                    .padding(.vertical, 8)
            case .question:
                PresentationQuestionView(presenter: presenter)
            }
            
            
        }
        .onAppear(perform: {
            AppUtility.lockOrientation(UIInterfaceOrientationMask.landscape)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        })
        .edgesIgnoringSafeArea(orientation == .landscapeRight ? [.leading] : [.trailing])
        .background(Color("backgroundColor"))
        .accentColor(Color("primaryColor"))
        .onRotate { newOrientation in
            // https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
            orientation = newOrientation
        }
    }
}

struct TestPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        RootPresentationView()
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
