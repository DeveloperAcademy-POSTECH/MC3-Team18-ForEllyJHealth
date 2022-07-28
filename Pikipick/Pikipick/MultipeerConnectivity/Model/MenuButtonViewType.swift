//
//  MenuButtonViewType.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import Foundation
import SwiftUI

enum MenuButtonViewType: String {
    case close, vote, qAndA
    
    var name: String {
           switch self {
           case .close: return "CLOSE"
           case .vote: return "VOTE"
           case .qAndA: return "Q&A"
       }
    }
    
    var color: Color {
        switch self {
        case .close: return Color.closeButtonColor
        case .vote: return Color.white
        case .qAndA: return Color.white
        }
    }
        
}
