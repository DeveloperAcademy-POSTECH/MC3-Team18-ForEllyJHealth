//
//  AudienceViewController.swift
//  Pikipick
//
//  Created by Hyeongjung on 2022/07/18.
//

import UIKit
import MultipeerConnectivity

class AudienceViewController: UIViewController {

    private let fadeOutTime = 4
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
    
    override func viewWillDisappear(_ animated: Bool) {
        audience.stopAdvertise()
        audience.sessionDisconnect()
    }
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        emoji.text = "👏"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.Marvelous, receiver: deviceName!)
    }
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        emoji.text = "😮"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.Surprising, receiver: deviceName!)
    }
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        emoji.text = "🎉"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.Congrats, receiver: deviceName!)
    }
    @IBAction func tapFireButton(_ sender: UIButton) {
        emoji.text = "🔥"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.LEGO, receiver: deviceName!)
    }
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        emoji.text = "🤔"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.Idk, receiver: deviceName!)
    }
    @IBAction func tapGoodButton(_ sender: UIButton) {
        emoji.text = "👍"
        viewFadeOut(fadeOutTime: fadeOutTime)
        audience.send(emoji: EmojiName.Good, receiver: deviceName!)
    }

    func viewFadeOut(fadeOutTime: Int) {
        UIView.animate(withDuration: TimeInterval(fadeOutTime), animations: {
            self.emoji.alpha = 1
            self.emoji.alpha = 0
        })
    }

}
