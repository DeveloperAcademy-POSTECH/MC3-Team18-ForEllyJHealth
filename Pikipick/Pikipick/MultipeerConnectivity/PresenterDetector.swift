//
//  Audience.swift
//  MultipeerTutorial
//
//  Created by 황정현 on 2022/07/18.
//

import Foundation
import MultipeerConnectivity
import os

// https://developer.apple.com/documentation/multipeerconnectivity
// https://www.ralfebert.com/ios-app-development/multipeer-connectivity/

// MARK: 발표자 탐지 클래스 Info
/* 발표자 탐지 클래스
- 청중의 List View (이하, LView)에서 초기화가 이루어져야합니다
- Browsing: Presenter 탐지를 위함. LView에 들어간 직후 Start, 뷰 전환이 이루어질 때 Stop
- 뷰 전환 시(onDisappear), sessionDisconnect도 함께 호출해야합니다
- 자세한 예시는 https://github.com/jeong-hyeonHwang/MultipeerTest ListView 참고
 */

class PresenterDetector: NSObject, ObservableObject {
    // 전송하고자하는 정보의 타입
    private let serviceType = "example-emoji"
    // 나의 기기 이름
    private let myPeerId = MCPeerID(displayName: "\(UIDevice.current.name + detectorSuffix)")
    // 서비스 탐색
    private let serviceBrowser: MCNearbyServiceBrowser
    // 연결된 모든 디바이스 탐색을 위한 세션
    private let session: MCSession
    
    // 로그 출력
    private let log = Logger()
    
    // Save Connected Peers
    @Published var connectedPeers: [MCPeerID] = []
    
    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        serviceBrowser.delegate = self
    }
    
    deinit {
        // Peer Browsing Stop
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func sessionIs() -> MCSession {
        return session
    }
    
    func browserIs() -> MCNearbyServiceBrowser {
        return serviceBrowser
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

extension PresenterDetector: MCNearbyServiceBrowserDelegate {
    // Browsing Not Begin
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        log.error("ServiceBrowser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    // Found Peer
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        log.info("ServiceBrowser found peer: \(peerID)")
        //MARK: Invite Peer who We Found
        if(peerID.displayName.contains(presenterSuffix)) {
            browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
        }
    }
    
    // Lost Peer
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
    }
}

extension PresenterDetector: MCSessionDelegate {
    
    // Inform Peer Status Change
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    // Inform Peer's transfer Data bytes
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let string = String(data: data, encoding: .utf8) {
            log.info("didReceive Emoji \(string)") }
    }
    
    // Can't Receive Specific Item 1
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }
    
    // Can't Receive Specific Item 2
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with Progress: Progress) {
        log.error("Receiving resources is not supported")
    }
    
    // Can't Receive Specific Item 3
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }
}
