//
//  ParticipateViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/15.
//

import UIKit

class ParticipateViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	var data = ["AAA-BBBBB-001", "AAA-BBBBB-002", "AAA-BBBBB-003", "AAA-BBBBB-004", "AAA-BBBBB-005"]
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.dataSource = self
		self.tableView.delegate = self
    }
    

}

extension ParticipateViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = data[indexPath.row]
		
		return cell
	}
}

extension ParticipateViewController: UITableViewDelegate {
	
}
