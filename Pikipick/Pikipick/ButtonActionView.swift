//
//  ButtonActionView.swift
//  Pikipick
//
//  Created by Jun.Mac on 2022/07/19.
//

import SwiftUI

struct ButtonActionView: View {
    var body: some View {
            
        HStack(){
            
            SurprisingButtonView()
            MarvelousButtonView()
            CongratsButtonView()
            LegoButtonView()
            IdkButtonView()
            GoodButtonView()
            
        }
    }
}

struct ButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionView()
    }
}
