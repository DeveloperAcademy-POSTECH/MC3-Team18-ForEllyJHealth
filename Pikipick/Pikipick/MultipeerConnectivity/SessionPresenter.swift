//
//  Presenter.swift
//  MultipeerTutorial
//
//  Created by 황정현 on 2022/07/18.
//

import Foundation
import MultipeerConnectivity
import os

// https://developer.apple.com/documentation/multipeerconnectivity
// https://www.ralfebert.com/ios-app-development/multipeer-connectivity/

// MARK: 발표자 클래스 Info
/* 발표자 클래스
 - 발표자 View(이하, PView)에서 초기화가 이루어져야합니다
 - Advertising: List View에서의 데이터 갱신을 위함(PresenterDetector Browser에게 알리기 위함). PView에 들어간 직후 Start, 뷰 전환이 이루어질 때 Stop
 - Browsing: Audience 확인을 위함. PView에 들어간 직후 Start, 뷰 전환이 이루어질 때 Stop
 - 뷰 전환 시(onDisappear), sessionDisconnect도 함께 호출해야합니다
 - 자세한 예시는 https://github.com/jeong-hyeonHwang/MultipeerTest PresenterView 참고
 */

class SessionPresenter: NSObject, ObservableObject {
    // 전송하고자하는 정보의 타입
    private let serviceType = "example-emoji"
    // 나의 기기 이름
    private let myPeerId = MCPeerID(displayName: "\(UIDevice.current.name + presenterSuffix)")
    // 서비스 발신
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    // 서비스 탐색
    private let serviceBrowser: MCNearbyServiceBrowser
    // 연결된 모든 디바이스 탐색을 위한 세션
    private let session: MCSession
    
    // 로그 출력
    private let log = Logger()
    
    // 현재 연결된 Peer의 리스트
    @Published var connectedPeers: [MCPeerID] = []
    // MARK: 현재 수신한 데이터
    @Published var receivedData: String? = nil
    
    @Published var receivedQuestionList: [String]? = nil
    
    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        serviceBrowser.delegate = self
        serviceAdvertiser.delegate = self
    }
    
    deinit {
        // Peer Browsing Stop
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func startAdvertise() {
        // Peer Advertising Start
        serviceAdvertiser.startAdvertisingPeer()
    }
    
    func stopAdvertise() {
        serviceAdvertiser.stopAdvertisingPeer()
    }
    
    func startBrowsing() {
        // Peer Browsing Start
        serviceBrowser.startBrowsingForPeers()
    }
    
    func stopBrowsing() {
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func sessionDisconnect() {
        session.disconnect()
    }
}

// Error Notice Delegate
extension SessionPresenter: MCNearbyServiceAdvertiserDelegate {
    // Receive Invitation == true
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        log.info("didReceiveInvitationFromPeer \(peerID)")
        
        // MARK: Accept Invitation
        if !peerID.displayName.contains(presenterSuffix) {
            invitationHandler(true, session)
        }
    }
}

extension SessionPresenter: MCNearbyServiceBrowserDelegate {
    // Found Peer
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        log.info("ServiceBrowser found peer: \(peerID)")
        //MARK: Invite Peer who We Found
        if !peerID.displayName.contains(presenterSuffix) {
            browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
        }
    }
    
    // Lost Peer
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
    }
}

extension SessionPresenter: MCSessionDelegate {
    
    // Inform Peer Status Change
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        
        // Update Peer's Status
        // !CAUTION! Automatically
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    // MARK: 이모지 수신
    /* 이모지 수신
     - peer로부터 이모지를 수신한 경우, currentEmoji의 정보를 갱신합니다
     */
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8) {
            log.info("didReceive Emoji \(string)")
            DispatchQueue.main.async {
                let identifier = string.substring(from: 0, to: 3)
                
                switch sendDataTypeIs(identifier: identifier) {
                case .question:
                    self.receivedQuestionList?.append(questionIs(data: string))
                case .vote:
                    break
                case .emoji:
                    self.receivedData = string
                    break
                }
            }
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
