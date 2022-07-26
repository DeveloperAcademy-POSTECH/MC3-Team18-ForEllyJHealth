//
//  TestPresentationView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/26.
//

import SwiftUI

enum mode: String {
    case home, vote, question
}

struct TestPresentationView: View {
    
    @State var viewMode: mode = .home
    var body: some View {
        
        ZStack{
            switch viewMode {
            case .home:
                HomePresentationView(viewMode: $viewMode)
            case .vote:
                Text("vote")
                
            case .question:
                Text("question")
            }
            
        }
        
    }
}

struct TestPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        TestPresentationView()
    }
}

