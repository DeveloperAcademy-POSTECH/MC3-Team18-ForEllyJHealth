//
//  LocalNetworkPrivacy.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/20.
//

import Foundation
import Network
import UIKit

class LocalNetworkPrivacy : NSObject {
	let service: NetService

	var completion: ((Bool) -> Void)?
	var timer: Timer?
	var publishing = false
	
	override init() {
		service = .init(domain: "local.", type:"_lnp._tcp.", name: "LocalNetworkPrivacy", port: 1100)
		super.init()
	}
	
	@objc
	func checkAccessState(completion: @escaping (Bool) -> Void) {
		self.completion = completion
		
		timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
			guard UIApplication.shared.applicationState == .active else {
				return
			}
			
			if self.publishing {
				self.timer?.invalidate()
				self.completion?(false)
			}
			else {
				self.publishing = true
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
