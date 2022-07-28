//
//  HomePresentationView.swift
//  Pikipick
//
//  Created by 송시원 on 2022/07/26.
//

import SwiftUI

struct HomePresentationView: View {
    @Binding var viewMode: mode
    
    var body: some View {
        HStack {
            Button() {
                viewMode = .votelist
            } label: {
                Text("투표")
                    .padding()
                    .background(.gray)
            }
            
            Button(){
                viewMode = .question
            } label: {
                Text("질문")
                    .padding()
                    .background(.gray)
            }
        }
    }
}


struct HomePresentationView_Previews: PreviewProvider {
    static var previews: some View {
        HomePresentationView(viewMode: .constant(.home))
    }
}
