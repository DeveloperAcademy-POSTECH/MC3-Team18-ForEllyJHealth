//
//  SettingModel.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/16.
//

import Foundation

struct OpenSource: Hashable {
	var openSourceName: String
	var licenseName: String
	var url: String
	var copyright: String
}

struct License: Hashable {
	var licenseName: String
	var licanseNotice: String
}
