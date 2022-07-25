//
//  MultipeerStringTransition.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/25.
//

import Foundation

enum SendData: String, CaseIterable {
    case question, vote, emoji
}

func sendDataTypeIs(identifier: String) -> SendData {
    switch identifier {
    case "QQQ":
        return SendData.question
    case "VVV":
        return SendData.vote
    default:
        return SendData.emoji
    }
}

func questionIs (data: String) -> String {
    guard let strIndex = data.firstIndex(of: "|") else { return "NIL"}
    let index = data.distance(from: data.startIndex, to: strIndex)
    let question = data.substring(from: index+1, to: data.count - 1)
    
    return question
}


