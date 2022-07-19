//
//  AudienceViewController.swift
//  Pikipick
//
//  Created by Hyeongjung on 2022/07/18.
//

import UIKit

class AudienceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emoji: UILabel!
    
    @IBAction func tabClapButton(_ sender: UIButton) {
        self.emoji.text = "👏"
        viewFadeOut()
    }
    
    @IBAction func tabSurpriseButton(_ sender: UIButton) {
        self.emoji.text = "😮"
        viewFadeOut()
    }
    
    @IBAction func tapCelebrateButton(_ sender: UIButton) {
        self.emoji.text = "🎉"
        viewFadeOut()
    }
    
    @IBAction func tapFireButton(_ sender: UIButton) {
        self.emoji.text = "🔥"
        viewFadeOut()
    }
    
    @IBAction func tapCuriousbutton(_ sender: UIButton) {
        self.emoji.text = "🤔"
        viewFadeOut()
    }
    
    @IBAction func tapGoodButton(_ sender: UIButton) {
        self.emoji.text = "👍"
        viewFadeOut()
    }
    
    func viewFadeOut() {
        UIView.animate(withDuration: 5, animations: {
            self.emoji.alpha = 1
            self.emoji.alpha = 0
        })
    }
}
