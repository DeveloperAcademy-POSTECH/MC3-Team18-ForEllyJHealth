//
//  ViewController.swift
//  Pikipick
//
//  Created by 황정현 on 2022/07/14.
//
import SwiftUI
import UIKit

class MainViewController: UIViewController {
	@IBOutlet weak var participateButton: UIButton!
	@IBOutlet weak var presentationButton: UIButton!
	@IBOutlet weak var mainImage: UIImageView!
	@IBOutlet weak var lineView: UIView!
	@IBOutlet weak var appNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	let localNetworkAuth = LocalNetworkAuthorization()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		mainImage.translatesAutoresizingMaskIntoConstraints = false
		mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20).isActive = true
		mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
		mainImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(1.1)).isActive = true
		if view.frame.size.height < 844 {
			mainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -(view.frame.height/7)).isActive = true
		} else if view.frame.size.height > 1000 {
			mainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -(view.frame.height/5)).isActive = true
			appNameLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height/25)
			descriptionLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height/25)
		} else {
			mainImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		}
		
		lineView.translatesAutoresizingMaskIntoConstraints = false
		lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
		lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
		
		participateButton.layer.cornerRadius = participateButton.frame.height/2
		presentationButton.layer.cornerRadius = participateButton.frame.height/2
    }
	
	func showSettingAlert() {
		let alert = UIAlertController(title: "Pikipick 앱이 사용자의 로컬 네트워크에 있는 기기를 찾고 기기와 연결하려고 합니다.", message: "이 앱은 사용자가 사용하는 네트워크에 있는 기기를 찾고 기기와 연결할 수 있게 됩니다.", preferredStyle: .alert)
		
		let settingAction = UIAlertAction(title: "설정", style: .default, handler: { (UIAlertAction) in
			if let appSettings = URL(string: UIApplication.openSettingsURLString) {
				UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
			}
		})
		
		let cancleAction = UIAlertAction(title: "취소", style: .cancel)
		[settingAction, cancleAction].forEach { alert.addAction($0) }
		self.present(alert, animated: true, completion: nil)
	}

    @IBAction private func participateButtonTapped(_ sender: UIButton) {
		participateButton.alpha = 0.8
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.participateButton.alpha = 1
		}
		participateButton.isUserInteractionEnabled = false
		presentationButton.isUserInteractionEnabled = false
        
        localNetworkAuth.requestAuthorization { granted in
            if granted {
                let participateVC = self.storyboard?.instantiateViewController(withIdentifier: "ParticipateViewController")
                self.navigationController?.pushViewController(participateVC ?? UIViewController(), animated: true)
            } else {
                self.showSettingAlert()
            }
            self.participateButton.isUserInteractionEnabled = true
            self.presentationButton.isUserInteractionEnabled = true
        }
	}
    
	@IBAction private func presentationButtonTapped(_ sender: UIButton) {
		presentationButton.alpha = 0.8
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.presentationButton.alpha = 1
		}
		participateButton.isUserInteractionEnabled = false
		presentationButton.isUserInteractionEnabled = false
        
        localNetworkAuth.requestAuthorization { granted in
            if granted {
                let swiftUIController = UIHostingController(rootView: PresentationView())
                self.navigationController?.pushViewController(swiftUIController, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            } else {
                self.showSettingAlert()
            }
            self.participateButton.isUserInteractionEnabled = true
            self.presentationButton.isUserInteractionEnabled = true
        }
	}
}

