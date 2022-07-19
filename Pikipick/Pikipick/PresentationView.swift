//
//  PresentationView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct PresentationView: View {
    
    @State var isPresentationReady : Bool = false
    
    var body: some View {
        VStack{
            Spacer()
           
            ButtonActionView()

        }
    }
}
        

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView()
    }
}
