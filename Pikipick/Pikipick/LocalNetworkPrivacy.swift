//
//  LocalNetworkPrivacy.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/20.
//

import Foundation
import Network
import UIKit

final class LocalNetworkPrivacy : NSObject {
	private let service: NetService

	private var completion: ((Bool) -> Void)?
	private var timer: Timer?
	private var isPublishing = false
	
	override init() {
		service = .init(domain: "local.", type:"_lnp._tcp.", name: "LocalNetworkPrivacy", port: 1100)
		super.init()
	}
	
	@objc func checkAccessState(completion: @escaping (Bool) -> Void) {
		self.completion = completion
		
		timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
			guard UIApplication.shared.applicationState == .active else {
				return
			}
			
			if self.isPublishing {
				self.timer?.invalidate()
				self.completion?(false)
			}
			else {
				self.isPublishing = true
				self.service.delegate = self
				self.service.publish()
				
			}
		})
	}
	
	deinit {
		service.stop()
	}
}

extension LocalNetworkPrivacy : NetServiceDelegate {
	func netServiceDidPublish(_ sender: NetService) {
		timer?.invalidate()
		completion?(true)
	}
}
