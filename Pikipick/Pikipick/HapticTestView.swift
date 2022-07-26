//
//  HapticTestView.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/27.
//

import SwiftUI

struct HapticTestView: View {
    
    private let customHapticSoundA: [HapticProperty] = [HapticProperty(count: 1, interval: [0.05], intensity: [0.65], sharpness: [0.45]), HapticProperty(count: 2, interval: [0.0, 0.1], intensity: [0.3, 0.6], sharpness: [0.55, 0.7])]
    private let customHapticSoundB: [HapticProperty] = [HapticProperty(count: 1, interval: [0.0], intensity: [0.65], sharpness: [0.65]), HapticProperty(count: 3, interval: [0.0, 0.1, 0.15], intensity: [0.7, 0.3, 0.55], sharpness: [0.5, 0.7, 0.85])]
    
    var body: some View {
        
        VStack{
            Button("HapticTest Start Sound A") {
                CustomizeHaptic.instance.haptic(hapticCase: Haptic.transient, hapticProperty: customHapticSoundA[0])
            }
            Button("HapticTest End Sound A") {
                CustomizeHaptic.instance.haptic(hapticCase: Haptic.continuous, hapticProperty: customHapticSoundA[1])
            }
            Button("HapticTest Start Sound B") {
                CustomizeHaptic.instance.haptic(hapticCase: Haptic.transient, hapticProperty: customHapticSoundB[0])
            }
            Button("HapticTest End Sound B") {
                CustomizeHaptic.instance.haptic(hapticCase: Haptic.transient, hapticProperty: customHapticSoundB[1])
            }
        }
        .onAppear(perform: CustomizeHaptic.instance.prepareHaptics)
    }
}

struct HapticTestView_Previews: PreviewProvider {
    static var previews: some View {
        HapticTestView()
    }
}
