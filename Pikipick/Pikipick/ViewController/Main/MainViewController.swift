//
//  ViewController.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/14.
//

import UIKit

class MainViewController: UIViewController {
	@IBOutlet weak var participateButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		participateButton.layer.cornerRadius = participateButton.frame.height/2
    }

	@IBAction func participateButtonTapped(_ sender: UIButton) {
	}
	
}

