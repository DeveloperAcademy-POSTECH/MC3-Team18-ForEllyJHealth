//
//  Segment.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/20.
//

import Foundation

enum Segue: String {
	case audience
	case questions

	var identifier: String {
		switch self {
		case .audience: return "AudienceSegue"
		case .questions: return "QuestionsSeuge"
		}
	}
}
