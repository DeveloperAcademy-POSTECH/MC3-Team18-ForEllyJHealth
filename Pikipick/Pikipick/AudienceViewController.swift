//
//  AudienceViewController.swift
//  Pikipick
//
//  Created by Hyeongjung on 2022/07/18.
//

import MultipeerConnectivity
import UIKit

class AudienceViewController: UIViewController {

    private let fadeOutTime = 3
    var isHapticOn : Bool = true
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var emoji: UILabel!
	
	var deviceName: MCPeerID?
    private var audience = SessionAudience()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceNameLength = (deviceName?.displayName.count ?? minusPresenterSuffixNum) - minusPresenterSuffixNum
        if let text = deviceName?.displayName {
            titleLabel.text = "\(text.substring(from: 0, to: deviceNameLength))의 발표입니다."
		}
        
        audience.startAdvertise()
        audience.currentPresenter = deviceName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "Haptic_preference") == nil {
            UserDefaults.standard.set(true, forKey: "Haptic_preference")
        }
        isHapticOn = UserDefaults.standard.object(forKey: "Haptic_preference") as? Bool ?? true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audience.stopAdvertise()
        audience.sessionDisconnect()
    }
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        emoji.text = "👏"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData: emojiStrIs(emoji: UUID().uuidString + (emoji.text ?? "")), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        emoji.text = "😮"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData: emojiStrIs(emoji: UUID().uuidString + (emoji.text ?? "")), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        emoji.text = "🎉"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData: emojiStrIs(emoji: UUID().uuidString + (emoji.text ?? "")), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapFireButton(_ sender: UIButton) {
        emoji.text = "🔥"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData: emojiStrIs(emoji: UUID().uuidString + (emoji.text ?? "")), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        emoji.text = "🤔"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData: emojiStrIs(emoji: UUID().uuidString + (emoji.text ?? "")), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapGoodButton(_ sender: UIButton) {
        emoji.text = "👍"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(sendData:  UUID().uuidString + (emoji.text ?? ""), receiver: deviceName!)
        runHaptic(isHapticOn: isHapticOn)
    }

    func viewFadeOut(fadeOutTime: Int) {
        UIView.animate(withDuration: TimeInterval(fadeOutTime), animations: {
            self.emoji.alpha = 1
            self.emoji.alpha = 0
        })
    }
    
    func runHaptic(isHapticOn: Bool){
        if isHapticOn {
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
            impactFeedbackGenerator?.impactOccurred()
        }
    }
    
    
}
