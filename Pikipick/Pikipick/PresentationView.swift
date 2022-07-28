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
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            VStack{
                Spacer()
                ButtonActionView()
                    .offset(y: -17)
            }
            .onAppear(perform: {
                AppUtility.lockOrientation(UIInterfaceOrientationMask.landscape)
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAlert.toggle()
                    }
                label: {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
                }
            }
            .alert("알람타이틀",isPresented: $showingAlert) {
                Button("나가기", role: .destructive) {
                    AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                        dismiss()
                    })
                }
            } message: {
                Text("샘플입니다.")
            }
        }
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
