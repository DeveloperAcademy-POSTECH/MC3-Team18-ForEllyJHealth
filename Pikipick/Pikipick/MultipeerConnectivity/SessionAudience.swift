//
//  SessionListener.swift
//  MultipeerTutorial
//
//  Created by 황정현 on 2022/07/14.
//

import MultipeerConnectivity
import os
import SwiftUI

// https://developer.apple.com/documentation/multipeerconnectivity
// https://www.ralfebert.com/ios-app-development/multipeer-connectivity/

// MARK: 청중 클래스 Info **IMPORTANT**
/* 청중 클래스
 - 청중 View(이하, AView)에서 초기화가 이루어져야합니다
 - Advertising: Presenter와의 세션 연결을 위함. AView에 들어간 직후 Start, 뷰 전환이 이루어질 때 Stop
 - 뷰 전환 시(onDisappear), sessionDisconnect도 함께 호출해야합니다
 - 자세한 예시는 https://github.com/jeong-hyeonHwang/MultipeerTest AudienceView 참고
 */

class SessionAudience: NSObject, ObservableObject {
    
    // 청중이 연결하고자하는 발표자
    var currentPresenter: MCPeerID?
    
    // 전송하고자하는 정보의 타입
    private let serviceType = "example-emoji"
    // 나의 기기 이름
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    // 서비스 발신
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    // 연결된 모든 디바이스 탐색을 위한 세션
    private let session: MCSession
    
    // 로그 출력
    private let log = Logger()
    
    // 현재 연결된 Peer의 리스트
    @Published var connectedPeers: [MCPeerID] = []
    
    // MARK: 이모지 전송
    /* 이모지 전송
     - 연결된 peer가 존재한다면, 특정 peer 선택 후 이모지를 전송합니다
     */
    func send(emoji: String, receiver: MCPeerID) {
        log.info("sendEmoji: \(String(describing: emoji)) to \(receiver.displayName)")

        // Is there any Connected Peers more than 1
        if (!session.connectedPeers.isEmpty) {
            do {
                try session.send(emoji.data(using: .utf8)!, toPeers: [receiver], with: .reliable)
            } catch {
                log.error("Error for sending: \(String(describing: error))")
            }
        }
    }
    
    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
    }
    
    deinit {
        // Peer Advertising Stop
        serviceAdvertiser.stopAdvertisingPeer()
        
    }
    
    func startAdvertise() {
        // Peer Advertising Start
        serviceAdvertiser.startAdvertisingPeer()
    }
    
    func stopAdvertise() {
        serviceAdvertiser.stopAdvertisingPeer()
    }
    
    func sessionDisconnect() {
        session.disconnect()
    }
}

// Error Notice Delegate
extension SessionAudience: MCNearbyServiceAdvertiserDelegate {
    // Receive Invitation == true
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        log.info("didReceiveInvitationFromPeer \(peerID)")
        
        // MARK: Accept Invitation **IMPORTANT**
        if(peerID.displayName == currentPresenter?.displayName)
        {
            invitationHandler(true, session)
        }
    }
}

extension SessionAudience: MCSessionDelegate {
    
    // Inform Peer Status Change
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        
        // Update Peer's Status
        // !CAUTION! Automatically
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    // Inform Peer's transfer Data bytes
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8) {
            log.info("didReceive emoji \(string)")
        } else {
            log.info("didReceive invalid value \(data.count) bytes")
        }
    }
    
    // Can't Receive Specific Item 1
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    // Can't Receive Specific Item 2
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with Progress: Progress) {
    }
    
    // Can't Receive Specific Item 3
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

