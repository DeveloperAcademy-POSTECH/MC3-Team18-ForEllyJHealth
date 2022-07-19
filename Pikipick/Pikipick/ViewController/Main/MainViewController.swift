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
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		participateButton.layer.cornerRadius = participateButton.frame.height/2
    
    }

	@IBAction func participateButtonTapped(_ sender: UIButton) {
	}
    // UIHostingController를 사용해 UIKit 기반 App에 SwiftUI View를 연결합니다.
    // ref : https://www.createwithswift.com/using-a-swiftui-view-in-a-uikit-app/
    // 2. Create a UIHostingController
       let swiftUIController = UIHostingController(rootView: PresentationView())
       
       // 1. Create the IBAction outlet
    
    @IBAction func goToSwiftUIView(_ sender: Any) {
        // 3. Push the UIHostingController
        navigationController?.pushViewController(swiftUIController, animated: true)
    }
    
}

