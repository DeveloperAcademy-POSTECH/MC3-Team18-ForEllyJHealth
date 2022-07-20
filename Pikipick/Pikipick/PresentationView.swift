//
//  PresentationView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct PresentationView: View {
    //@StateObject private var viewModel: ViewModel
    @State var isPresentationReady : Bool = false
    var body: some View {
        VStack{
            Spacer()
            ButtonActionView()
        }
    }
}

//@MainActor
//final class ViewModel: ObservableObject {
//    var sessionPresenter: SessionPresenter
//
//    var cancellable : AnyCancellable?
//
//    public init(sessionPresenter: SessionPresenter) {
//        self.sessionPresenter = sessionPresenter
//        cancellable = sessionPresenter.$receivedEmoji.sink { [weak self] _ in
//            self?.objectWillChange.send()
//        }
//    }
//
//    public func changeItem() {
//        sessionPresenter.receivedEmoji = SomeItem(doubleValue: .zero)
//    }
//}


struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
