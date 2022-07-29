//
//  Button+.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/28.
//

import UIKit

extension UIButton {
	func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
		let gradient: CAGradientLayer = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = colours.map { $0.cgColor }
		gradient.locations = locations
		gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
		gradient.cornerRadius = 25
		self.layer.insertSublayer(gradient, at: 0)
	}
    func sendButtonGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = 82
        self.layer.insertSublayer(gradient, at: 0)
    }
}
