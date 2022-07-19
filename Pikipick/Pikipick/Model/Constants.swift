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

// MARK: 발신 및 수신할 이모지의 케이스
enum EmojiName: String, CaseIterable {
    case Marvelous, Surprising, Congrats, LEGO, Idk, Good
}

// MARK: Enum -> String 변환
func emojiIs(emojiName: String) -> String {
    switch emojiName {
    case "Marvelous":
        return "👏"
    case "Surprising":
        return "😮"
    case "Congrats":
        return "🎉"
    case "LEGO":
        return "🔥"
    case "Idk":
        return "🤔"
    case "Good":
        return "👍"
    default:
        return "*NIL*"
    }
}
