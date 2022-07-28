//
//  AudienceViewController.swift
//  Pikipick
//
//  Created by Hyeongjung on 2022/07/18.
//

import MultipeerConnectivity
import UIKit
import SwiftUI

class AudienceViewController: UIViewController {
    
    @IBOutlet weak var animatedCountingLabel: UILabel!
    
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 1.5
    
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
    var emojiButton: UIButton!
    
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
    
    func setUpCircularProgressBarView() {
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // align to the center of the screen
//        circularProgressBarView.center = view.center
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        circularProgressBarView.createCircularPath()
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
        circularProgressBarView.topAnchor.constraint(equalTo: sendButton.topAnchor, constant: 70).isActive = true
        circularProgressBarView.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 70).isActive = true
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            emojiView.alpha = 1.0
            voteView.alpha = 0.0
        } else {
            emojiView.alpha = 0.0
            voteView.alpha = 1.0
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
            if emojiView.alpha == 1.0 {
                audience.sendEmoji(sendEmoji: emoji, receiver: deviceName!)
            } else {
                audience.sendVote(sendVote: emoji, receiver: deviceName!)
            }
            sendButton.configuration?.background.strokeColor = UIColor(named: "secondaryColorSaturation")
            if emojiButton != nil {
                emojiButton.configuration?.baseBackgroundColor = UIColor(named: "secondaryColor")
            }
            circularProgressBarView = CircularProgressBarView(frame: .zero)
            circularProgressBarView.createCircularPath()
            view.addSubview(circularProgressBarView)
            circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
            circularProgressBarView.topAnchor.constraint(equalTo: sendButton.topAnchor, constant: 70).isActive = true
            circularProgressBarView.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 70).isActive = true
        }
    }
    
    @IBAction func cancelPressing(_ sender: UIButton) {
//        sendButton.configuration?.background.strokeColor = UIColor(named: "secondaryColorSaturation")
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.createCircularPath()
        view.addSubview(circularProgressBarView)
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
        circularProgressBarView.topAnchor.constraint(equalTo: sendButton.topAnchor, constant: 70).isActive = true
        circularProgressBarView.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 70).isActive = true
    }
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        emoji = "👏"
        selectedEmoji(emoji: emoji, button: clapButton, beforeButton: beforeButton)
    }
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        emoji = "😮"
        selectedEmoji(emoji: emoji, button: surpriseButton, beforeButton: beforeButton)
    }
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        emoji = "🎉"
        selectedEmoji(emoji: emoji, button: celebrateButton, beforeButton: beforeButton)
    }
    @IBAction func tapFireButton(_ sender: UIButton) {
        emoji = "🔥"
        selectedEmoji(emoji: emoji, button: fireButton, beforeButton: beforeButton)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        emoji = "🤔"
        selectedEmoji(emoji: emoji, button: curiousButton, beforeButton: beforeButton)
        runHaptic(isHapticOn: isHapticOn)
    }
    @IBAction func tapGoodButton(_ sender: UIButton) {
        emoji = "👍"
        selectedEmoji(emoji: emoji, button: goodButton, beforeButton: beforeButton)
        runHaptic(isHapticOn: isHapticOn)
    }
    
    @IBAction func tapYesButton(_ sender: UIButton) {
        emoji = "🙆‍♂️"
        selectedEmoji(emoji: emoji, button: yesButton, beforeButton: beforeButton)
    }
    @IBAction func tapNoButton(_ sender: UIButton) {
        emoji = "🙅‍♀️"
        selectedEmoji(emoji: emoji, button: noButton, beforeButton: beforeButton)
    }
    @IBAction func tapOneButton(_ sender: UIButton) {
        emoji = "1️⃣"
        selectedEmoji(emoji: emoji, button: oneButton, beforeButton: beforeButton)
    }
    @IBAction func tapTwoButton(_ sender: UIButton) {
        emoji = "2️⃣"
        selectedEmoji(emoji: emoji, button: twoButton, beforeButton: beforeButton)
    }
    @IBAction func tapThreeButton(_ sender: UIButton) {
        emoji = "3️⃣"
        selectedEmoji(emoji: emoji, button: threeButton, beforeButton: beforeButton)
    }
    @IBAction func tapFourButton(_ sender: UIButton) {
        emoji = "4️⃣"
        selectedEmoji(emoji: emoji, button: fourButton, beforeButton: beforeButton)
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        print(emoji)
        print("시작")
        sendButton.configuration?.background.strokeColor = UIColor(named: "primaryColor")
        setUpCircularProgressBarView()
    }
    
    func selectedEmoji(emoji: String, button: UIButton!, beforeButton: UIButton?) {
        runHaptic(isHapticOn: isHapticOn)
        if button.configuration?.baseBackgroundColor == UIColor(named: "secondaryColor") && beforeButton?.configuration?.baseBackgroundColor == UIColor(named: "primaryColor"){
            button.configuration?.baseBackgroundColor = UIColor(named: "primaryColor")
            beforeButton?.configuration?.baseBackgroundColor = UIColor(named: "secondaryColor")
        } else {
            button.configuration?.baseBackgroundColor = UIColor(named: "primaryColor")
        }
        if let audienceView = self.parent as? AudienceViewController {
            audienceView.emoji = emoji
            audienceView.emojiButton = button
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
