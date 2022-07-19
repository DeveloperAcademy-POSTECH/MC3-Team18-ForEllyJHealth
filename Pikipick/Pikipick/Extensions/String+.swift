//
//  String+.swift
//  MultipeerTutorial
//
//  Created by 황정현 on 2022/07/19.
//

import Foundation

// https://ios-development.tistory.com/379
// Presenter, Detector의 MCPeerID Suffix 제거를 위함
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
