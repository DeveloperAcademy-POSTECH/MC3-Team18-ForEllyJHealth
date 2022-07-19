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
	
	func showSettingAlert() {
		let alert = UIAlertController(title: "Pikipick 앱이 사용자의 로컬 네트워크에 있는 기기를 찾고 기기와 연결하려고 합니다.", message: "이 앱은 사용자가 사용하는 네트워크에 있는 기기를 찾고 기기와 연결할 수 있게 됩니다.", preferredStyle: .alert)
		
		
		let settingAction = UIAlertAction(title: "설정", style: .default, handler: { (UIAlertAction) in
			if let appSettings = URL(string: UIApplication.openSettingsURLString) {
				UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
			}
		})
		let cancleAction = UIAlertAction(title: "취소", style: .cancel)
		alert.addAction(settingAction)
		alert.addAction(cancleAction)
		self.present(alert, animated: true, completion: nil)
	}

	@IBAction func participateButtonTapped(_ sender: UIButton) {
		LocalNetworkPrivacy().checkAccessState { granted in
			if granted {
				let participateVC = self.storyboard?.instantiateViewController(withIdentifier: "ParticipateViewController")
				self.navigationController?.pushViewController(participateVC ?? UIViewController(), animated: true)
			} else {
				self.showSettingAlert()
			}
		}
	}
	
}

