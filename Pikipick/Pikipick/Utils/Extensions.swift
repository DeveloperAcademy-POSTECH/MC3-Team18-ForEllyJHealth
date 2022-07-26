//
//  Extensions.swift
//  Weather
//
//  Created by Dara To on 2022-06-12.
//

import SwiftUI

extension Color {
    static let primaryColor = Color("primaryColor")
    static let secondaryColor = Color("secondaryColor")
    static let backgroundColor = Color("backgroundColor")
    static let primaryGradient = LinearGradient(gradient: Gradient(colors: [Color("primaryColorSaturation"), Color("primaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let secondaryGradient = LinearGradient(gradient: Gradient(colors: [Color("secondaryColor"), Color("secondaryColorSaturation")]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
