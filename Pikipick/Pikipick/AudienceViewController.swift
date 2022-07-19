//
//  AudienceViewController.swift
//  Pikipick
//
//  Created by Hyeongjung on 2022/07/18.
//

import UIKit

class AudienceViewController: UIViewController {

    let fadeOutTime = 4
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        emoji.text = "👏"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        emoji.text = "😮"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        emoji.text = "🎉"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }
    @IBAction func tapFireButton(_ sender: UIButton) {
        emoji.text = "🔥"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        emoji.text = "🤔"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }
    @IBAction func tapGoodButton(_ sender: UIButton) {
        emoji.text = "👍"
        viewFadeOut(fadeOutTime: fadeOutTime)
    }

    func viewFadeOut(fadeOutTime: Int) {
        UIView.animate(withDuration: TimeInterval(fadeOutTime), animations: {
            self.emoji.alpha = 1
            self.emoji.alpha = 0
        })
    }

}
