//
//  SettingTableViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/15.
//

import UIKit

class SettingTableViewController: UITableViewController {
	var SettingMenus = ["오픈소스 라이센스", "버전정보"]

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = SettingMenus[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			guard let vc = storyboard?.instantiateViewController(withIdentifier: "LicenseVC") as? LicenseViewController else { return }
			navigationController?.pushViewController(vc, animated: true)
		}
	}


}
