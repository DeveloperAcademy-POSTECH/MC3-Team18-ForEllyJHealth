//
//  MultipeerVoteDataModel.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/25.
//

import Foundation

enum Vote: Int, CaseIterable {
    case yes, no, option1, option2, option3, option4
}

// PeerID + 투표 결과 -> [PeerID: 투표 결과] 형태로 변환
func voteIs (data: String) -> [String: Int]? {
    guard let strIndex = data.firstIndex(of: "|") else { return ["NIL PEER": -1]}
    let peerNameLastIndex = data.distance(from: data.startIndex, to: strIndex)
    let peerName = data.substring(from: 0, to: peerNameLastIndex)
    let voteResult = data.substring(from: peerNameLastIndex+1, to: data.count - 1)
    if let vote = Int(voteResult) {
        return [peerName: vote]
    } else {
        return [peerName: -1]
    }
}
