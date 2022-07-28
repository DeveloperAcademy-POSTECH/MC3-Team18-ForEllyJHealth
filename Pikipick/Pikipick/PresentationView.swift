//
//  PresentationView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct PresentationView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var presenter: SessionPresenter
    @Binding var viewMode: ViewMode
    @State var isPresentationReady : Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            PresentationMenuView(viewMode: $viewMode, isExpanded: false)
            VStack{
                Spacer()
                ButtonActionView(presenter: presenter)
                    .offset(y: -17)
            }
        }
    }
}

//struct PresentationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentationView(viewMode: .constant(.question))
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
