//
//  ParticipateTableViewCell.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/27.
//

import UIKit

class ParticipateTableViewCell: UITableViewCell {
	@IBOutlet weak var deviceName: UILabel!
	@IBOutlet weak var iconButton: UIButton!
	override class func awakeFromNib() {
		super.awakeFromNib()
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		contentView.backgroundColor = UIColor(named: "secondaryColor")
		contentView.layer.cornerRadius = 25
		iconButton.layer.cornerRadius = 17
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		
		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
	}
}
