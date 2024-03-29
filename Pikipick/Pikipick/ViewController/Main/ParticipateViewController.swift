//
//  ParticipateViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/15.
//

import MultipeerConnectivity
import UIKit
import SwiftUI

class ParticipateViewController: UIViewController, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var refreshButton: UIButton!
	
    private var detector = PresenterDetector()
	private var presenterList = [MCPeerID]()
    
    let waitTime: TimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		let guideMessageLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height-88, width: view.frame.width, height: 88))
		guideMessageLabel.text = "Please select a presenter device."
		guideMessageLabel.textColor = UIColor.white
		guideMessageLabel.backgroundColor = UIColor(named: "secondaryColor")
		guideMessageLabel.textAlignment = .center
		guideMessageLabel.clipsToBounds = true
		guideMessageLabel.layer.cornerRadius = 30
		
		backButton.applyGradient(colours: [UIColor(named: "gradientFirstColor") ?? UIColor.black, UIColor.black], locations: [0.0, 1.0])
		backButton.layer.cornerRadius = backButton.frame.height/2
		backButton.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
		backButton.layer.borderWidth = 1
		
		refreshButton.applyGradient(colours: [UIColor(named: "gradientFirstColor") ?? UIColor.black, UIColor.black], locations: [0.0, 1.0])
		refreshButton.layer.cornerRadius = refreshButton.frame.height/2
		refreshButton.layer.borderColor = UIColor(named: "secondaryColor")?.cgColor
		refreshButton.layer.borderWidth = 1
		
		view.addSubview(guideMessageLabel)
		
        detector.startBrowsing()
        initRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detector.startBrowsing()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        detector.stopBrowsing()
        detector.sessionDisconnect()
    }
	
	@IBAction func backButtonTapped(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func refresgButtonTapped(_ sender: UIButton) {
		tableView.reloadData()
		self.tableView.separatorStyle = .none
	}
	
    // https://gigas-blog.tistory.com/44
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "RELOAD")
        tableView.refreshControl = refresh
		self.tableView.separatorStyle = .none
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        refresh.endRefreshing()
		self.tableView.reloadData()
		self.tableView.separatorStyle = .none
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segue.audience.identifier {
			let cell = sender as? UITableViewCell ?? UITableViewCell()
			let indexPath = tableView.indexPath(for: cell)
			let audienceVC = segue.destination as! AudienceViewController
            audienceVC.deviceName = presenterList[indexPath!.row]
			if let indexPath = indexPath {
                audienceVC.deviceName = presenterList[indexPath.row]
			}
		}
	}
}

extension ParticipateViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if detector.connectedPeers.isEmpty {
			emptyMessage()
		} else {
			restore()
		}
        
        if !presenterList.isEmpty {
            presenterList.removeAll()
        }
        
        var count = 0
        for peer in detector.connectedPeers {
            if(peer.displayName.contains(presenterSuffix)) {
                count += 1
                presenterList.append(peer)
            }
        }
        return count
	}
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipateTableViewCell", for: indexPath) as! ParticipateTableViewCell
        let presenterStrLength = presenterList[indexPath.row].displayName.count
        cell.deviceName.text = presenterList[indexPath.row].displayName.substring(from: 0, to: presenterStrLength - minusPresenterSuffixNum)
		cell.selectionStyle = .none
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 56
	}
	
}

extension ParticipateViewController {
	func emptyMessage() {
		let message = "🤔\nThere is no connectable device."
		let attributedString = NSMutableAttributedString(string: message)
		attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 56), range: (message as NSString).range(of: "🤔"))
		attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: (message as NSString).range(of: "\nThere is no connectable device."))
		let messageLabel = UILabel()
		messageLabel.numberOfLines = 2
		messageLabel.attributedText = attributedString
		messageLabel.textAlignment = .center
		
		tableView.backgroundView = messageLabel
		tableView.separatorStyle = .none
	}
	func restore() {
		tableView.backgroundView = nil
		tableView.separatorStyle = .singleLine
	}
}
