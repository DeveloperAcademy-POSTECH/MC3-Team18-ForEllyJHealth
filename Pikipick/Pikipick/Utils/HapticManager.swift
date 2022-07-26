//
//  HapticManager.swift
//  MC2-Team1
//
//  Created by 황정현 on 2022/06/09.
//

import SwiftUI
import CoreHaptics

enum Haptic {
    case transient
    case continuous
    case dynamic
}

class HapticProperty {
    private(set) var count: Int
    private(set) var interval: [CGFloat]
    private(set) var hapticIntensity: [CGFloat]
    private(set) var hapticSharpness: [CGFloat]
    
    init(count: Int, interval: [CGFloat], intensity: [CGFloat], sharpness: [CGFloat]) {
        self.count = count
        self.interval = interval
        hapticIntensity = intensity
        hapticSharpness = sharpness
    }
}

class CustomizeHaptic {
    static var instance = CustomizeHaptic()
    var engine: CHHapticEngine?
    
    func haptic(hapticCase: Haptic, hapticProperty: HapticProperty) {
        switch hapticCase {
        case .transient:
            print("transient")
            transientHaptic(hapticProperty: hapticProperty)
        case .continuous:
            print("continuous")
            continuousHaptic(hapticProperty: hapticProperty)
        case .dynamic:
            print("dynamic")
            dynamicHaptic(hapticProperty: hapticProperty)
        }
    }
    
    //https://apps.apple.com/us/app/interactful/id1528095640
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error creating the engine: (error.localizedDescription)")
        }
        
        engine?.resetHandler = {
            print("Restarting haptic engine")
            do {
                try self.engine?.start()
            } catch {
                fatalError("Failed to restart the engine: (error)")
            }
        }
    }
    
    func transientHaptic(hapticProperty: HapticProperty) {
        
        let count = hapticProperty.count
        let interval = hapticProperty.interval
        let hapticIntensity = hapticProperty.hapticIntensity
        let hapticSharpness = hapticProperty.hapticSharpness
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for index in 0..<count {
            let relativeInterval: TimeInterval = TimeInterval(interval[0...index].reduce(0, +))
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(hapticIntensity[index]))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(hapticSharpness[index]))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: relativeInterval)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play pattern: (error.localizedDescription).")
        }
    }
    
    func continuousHaptic(hapticProperty: HapticProperty) {
        
        let count = hapticProperty.count
        let interval = hapticProperty.interval
        let hapticIntensity = hapticProperty.hapticIntensity
        let hapticSharpness = hapticProperty.hapticSharpness
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
        let totalDuration: TimeInterval = TimeInterval(interval[1..<count].reduce(0, +))
        var intensityControlPoints = [CHHapticParameterCurve.ControlPoint]()
        var sharpnessControlPoints = [CHHapticParameterCurve.ControlPoint]()
        
        for index in 0..<count {
            let relativeInterval: TimeInterval = TimeInterval(interval[0...index].reduce(0, +))
            
            intensityControlPoints.append(CHHapticParameterCurve.ControlPoint(relativeTime: relativeInterval, value: Float(hapticIntensity[index])))
            sharpnessControlPoints.append(CHHapticParameterCurve.ControlPoint(relativeTime: relativeInterval, value: Float(hapticSharpness[index])))
        }
        
        let intensityCurve = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: intensityControlPoints, relativeTime: TimeInterval(interval[0]))
        let sharpnessCurve = CHHapticParameterCurve(parameterID: .hapticSharpnessControl, controlPoints: sharpnessControlPoints, relativeTime: TimeInterval(interval[0]))
        
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: TimeInterval(interval[0]), duration: totalDuration)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve, sharpnessCurve])
            
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func dynamicHaptic(hapticProperty: HapticProperty) {
        
        let count = hapticProperty.count
        let interval = hapticProperty.interval
        let hapticIntensity = hapticProperty.hapticIntensity
        let hapticSharpness = hapticProperty.hapticSharpness
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.0)
        let totalDuration: TimeInterval = TimeInterval(interval[0..<count].reduce(0, +))
        var dynamicIntensity = [CHHapticDynamicParameter]()
        var dynamicSharpness = [CHHapticDynamicParameter]()
        
        for index in 0..<count {
            dynamicIntensity.append(CHHapticDynamicParameter(parameterID: .hapticIntensityControl, value: Float(hapticIntensity[index]), relativeTime: 0))
            dynamicSharpness.append(CHHapticDynamicParameter(parameterID: .hapticSharpnessControl, value: Float(hapticSharpness[index]), relativeTime: 0))
        }
        
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: totalDuration)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: 0)
            
            for index in 0..<count {
                let relativeInterval: TimeInterval = TimeInterval(interval[0...index].reduce(-interval[index], +))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + relativeInterval) {
                    do {
                        try player?.sendParameters([dynamicIntensity[index], dynamicSharpness[index]], atTime: CHHapticTimeImmediate)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
