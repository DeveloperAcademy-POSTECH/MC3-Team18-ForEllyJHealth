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
    @IBOutlet weak var emojiView: UIView!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var clapButton: UIButton!
    @IBOutlet weak var surpriseButton: UIButton!
    @IBOutlet weak var celebrateButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var curiousButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var longPressGesture: UILongPressGestureRecognizer!
    
    @IBOutlet weak var sendButton: UIButton!
    var beforeButton: UIButton!
    
    var emoji: String = ""
    var emoji123: UILabel!
//    var emoji123: String = ""
    
    var deviceName: MCPeerID?
    private var audience = SessionAudience()
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceNameLength = (deviceName?.displayName.count ?? minusPresenterSuffixNum) - minusPresenterSuffixNum
        if let text = deviceName?.displayName {
            titleLabel.text = "\(text.substring(from: 0, to: deviceNameLength))"
        }
        
        segmentControl?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentControl?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        
        audience.startAdvertise()
        audience.currentPresenter = deviceName
    }
    
    
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            emojiView.alpha = 1.0
            voteView?.alpha = 0.0
        } else {
            emojiView.alpha = 0.0
            voteView?.alpha = 1.0
        }
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
    
    @IBAction func sendIt(_ sender: UILongPressGestureRecognizer) {
        if longPressGesture.state.rawValue == 1 {
            print(emoji)
            print(emoji123.text)
            print("완료됐음")
            audience.sendEmoji(sendEmoji: emoji, receiver: deviceName!)
        }
    }
    
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        print(emoji)
        emoji123.text = "👏"
        selectemoji(button: clapButton, beforeButton: beforeButton)
        emoji = "👏"
        runHaptic(isHapticOn: isHapticOn)
        print(emoji123.text!)
    }
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        selectemoji(button: surpriseButton, beforeButton: beforeButton)
        emoji = "😮"
        emoji123?.text = "😮"
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        selectemoji(button: celebrateButton, beforeButton: beforeButton)
        emoji = "🎉"
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapFireButton(_ sender: UIButton) {
        selectemoji(button: fireButton, beforeButton: beforeButton)
        emoji = "🔥"
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        selectemoji(button: curiousButton, beforeButton: beforeButton)
        emoji = "🤔"
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapGoodButton(_ sender: UIButton) {
        selectemoji(button: goodButton, beforeButton: beforeButton)
        emoji = "👍"
        runHaptic(isHapticOn: isHapticOn)
    }
    
    @IBAction func tapYesButton(_ sender: UIButton) {
        selectemoji(button: yesButton, beforeButton: beforeButton)
        emoji = "🙆‍♂️"
    }
    
    @IBAction func tapNoButton(_ sender: UIButton) {
        selectemoji(button: noButton, beforeButton: beforeButton)
        emoji = "🙅‍♀️"
    }
    
    @IBAction func tapOneButton(_ sender: UIButton) {
        selectemoji(button: oneButton, beforeButton: beforeButton)
        emoji = "1️⃣"
    }
    
    @IBAction func tapTwoButton(_ sender: UIButton) {
        selectemoji(button: twoButton, beforeButton: beforeButton)
        emoji = "2️⃣"
    }
    
    @IBAction func tapThreeButton(_ sender: UIButton) {
        selectemoji(button: threeButton, beforeButton: beforeButton)
        emoji = "3️⃣"
    }
    
    @IBAction func tapFourButton(_ sender: UIButton) {
        selectemoji(button: fourButton, beforeButton: beforeButton)
        emoji = "4️⃣"
    }
    
    
    @IBAction func pressButton(_ sender: UIButton) {
        print(emoji)
        print("시작")
        sendButton?.configuration?.background.strokeColor = .yellow
        sendButton?.configuration?.baseBackgroundColor = UIColor(named: "primaryColor")
        
        //        UIColor(named: "primaryColor") as? CGColor
        //        sendButton.configuration.stock = UIColor
    }
    
    @IBAction func pressAction(_ sender: UILongPressGestureRecognizer) {
        //        print(emoji)
        print(longPressGesture.state.rawValue)
        if longPressGesture.state.rawValue == 1 {
            print(emoji)
            print(emoji123.text)
            print("완료됐음")
            audience.sendEmoji(sendEmoji: emoji, receiver: deviceName!)
            
        }
    }
    
    func selectemoji(button: UIButton!, beforeButton: UIButton?) {
        
        if button.configuration?.baseBackgroundColor == UIColor(named: "secondaryColor") && beforeButton?.configuration?.baseBackgroundColor == UIColor(named: "primaryColor"){
            button.configuration?.baseBackgroundColor = UIColor(named: "primaryColor")
            beforeButton?.configuration?.baseBackgroundColor = UIColor(named: "secondaryColor")
        } else if beforeButton == nil {
            button.configuration?.baseBackgroundColor = UIColor(named: "primaryColor")
        }
        self.beforeButton = button
    }
    
    func runHaptic(isHapticOn: Bool) {
        if isHapticOn {
            impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
            impactFeedbackGenerator?.impactOccurred()
        }
    }
    
    
}

//class MyLongPressGesture : UILongPressGestureRecognizer{
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        print("진동시작")
//        // 진동 코드
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        print("진동끄읕")
//        // 진동 종료
//    }
//}
