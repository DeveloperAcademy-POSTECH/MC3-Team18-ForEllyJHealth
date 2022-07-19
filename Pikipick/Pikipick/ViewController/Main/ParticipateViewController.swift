//
//  ParticipateViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/15.
//

import UIKit

class ParticipateViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var devices = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.dataSource = self
		self.tableView.delegate = self
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "Segue" {
			let cell = sender as! UITableViewCell
			let indexPath = tableView.indexPath(for: cell)
			let audienceVC = segue.destination as! AudienceViewController
			audienceVC.deviceName = devices[indexPath!.row]
			if let indexPath = indexPath {
				audienceVC.deviceName = devices[indexPath.row]
			}
		}
	}
}

extension ParticipateViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if devices.isEmpty {
			emptyMessage("현재 연결 가능한 기기가 없습니다.")
		} else {
			restore()
		}
		return devices.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = devices[indexPath.row]
		
		return cell
	}
}

extension ParticipateViewController: UITableViewDelegate {
	
}

extension ParticipateViewController {
	func emptyMessage(_ message: String) {
		let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		messageLabel.text = message
		messageLabel.textAlignment = .center
		
		tableView.backgroundView = messageLabel
		tableView.separatorStyle = .none
	}
	func restore() {
		tableView.backgroundView = nil
		tableView.separatorStyle = .singleLine
	}
}
