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

func sendDataType(identifier: String) -> SendData {
    switch identifier {
    case "QQQ":
        return SendData.question
    case "VVV":
        return SendData.vote
    default:
        return SendData.emoji
    }
}

// PeerID + 질문 -> 질문으로 변환
func extractQuestion (data: String) -> String {
    guard let strIndex = data.firstIndex(of: "|") else { return "NIL"}
    let identifierLength = data.distance(from: data.startIndex, to: strIndex)
    let question = data.substring(from: identifierLength+1, to: data.count - 1)
    
    return question
}


