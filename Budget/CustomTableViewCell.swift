//
//  CustomTableViewCell.swift
//  Budget
//
//  Created by Arthur Coelho on 30/07/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	
	static let identifier: String = "CustomTableViewCell"
	
	static func nib() -> UINib {
		return UINib(nibName: self.identifier, bundle: nil)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	func setupCell(title: String) {
		titleLabel.text = title
	}
	
	//override func setSelected(_ selected: Bool, animated: Bool) {
	//	super.setSelected(selected, animated: animated)
	//		Configure the view for the selected state
	//}
    
}
