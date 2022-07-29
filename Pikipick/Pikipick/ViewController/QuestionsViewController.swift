//
//  QuestionsViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/29.
//

import MultipeerConnectivity
import UIKit

class QuestionsViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerEmojiLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var audience: SessionAudience?
    var deviceName: MCPeerID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.cornerRadius = 28
        headerEmojiLabel.clipsToBounds = true
        headerEmojiLabel.layer.cornerRadius = 22
        textView.layer.cornerRadius = 20
        sendButton.layer.cornerRadius = 28
        
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        textView.becomeFirstResponder()
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        audience?.sendQuestion(sendQuestion: textView.text ?? "", receiver: deviceName ?? MCPeerID())
        self.dismiss(animated: true)
    }
}
