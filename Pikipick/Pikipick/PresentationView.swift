//
//  PresentationView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct PresentationView: View {
    @Environment (\.dismiss) var dismiss
    @State var isPresentationReady : Bool = false
    @State private var showingAlert = false
    var body: some View {
        VStack{
            Spacer()
            ButtonActionView()
        }
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showingAlert = true
                        }
                         label: {
                             Image(systemName: "chevron.backward")
                             Text("Back")
                        }
                    }
                }
                .alert("알람타이틀",isPresented: $showingAlert) {
                                Button("나가기", role: .destructive) {
                                    dismiss()
                                }
                            } message: {
                                Text("샘플입니다.")
                            }
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
