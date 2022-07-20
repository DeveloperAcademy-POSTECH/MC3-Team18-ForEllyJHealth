//
//  ParticipateViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/15.
//

import UIKit
import MultipeerConnectivity

class ParticipateViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
    private var detector = PresenterDetector()
    
	private var presenterList = [MCPeerID]()
    
    let waitTime: TimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.dataSource = self
		self.tableView.delegate = self
        
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
    
    // https://gigas-blog.tistory.com/44
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "RELOAD")
        
        tableView.refreshControl = refresh
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        refresh.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
            self.tableView.reloadData()
        }
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
			emptyMessage("현재 연결 가능한 기기가 없습니다.")
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let presenterStrLength = presenterList[indexPath.row].displayName.count
        cell.textLabel?.text = presenterList[indexPath.row].displayName.substring(from: 0, to: presenterStrLength - minusPresenterSuffixNum)
		
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
