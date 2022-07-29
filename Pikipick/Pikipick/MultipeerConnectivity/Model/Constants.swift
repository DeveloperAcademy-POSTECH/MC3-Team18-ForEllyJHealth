//
//  Constants.swift
//  MultipeerTutorial
//
//  Created by 황정현 on 2022/07/14.
//

import Foundation

// MARK: Presenter Device 식별 접미사
let presenterSuffix = "PRE"
// MARK: Detector Device 식별 접미사
let detectorSuffix = "DEC"

let minusPresenterSuffixNum = presenterSuffix.count + 1
let minusDetectorSuffixNum = presenterSuffix.count + 1

// MARK: 발신 및 수신할 이모지의 케이스
enum EmojiName: String, CaseIterable {
    case marvelous, surprising, congrats, lego, idk, good, empty
    
    var emojiIs: String {
        switch self {
        case .marvelous:
            return "👏"
        case .surprising:
            return "😮"
        case .congrats:
            return "🎉"
        case .lego:
            return "🔥"
        case .idk:
            return "🤔"
        case .good:
            return "👍"
        case .empty:
            return ""
        }
    }
}

func emojiStrIs(emoji: String) -> String {
    switch emoji {
    case "👏":
        return "marvelous"
    case "😮":
        return "surprising"
    case "🎉":
        return "congrats"
    case "🔥":
        return "lego"
    case "🤔":
        return "idk"
    case "👍":
        return "good"
    default:
        return "*NIL*"
    }
}
