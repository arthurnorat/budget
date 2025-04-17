//
//  CustomTableViewCell.swift
//  Budget
//
//  Created by Arthur Coelho on 30/07/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var amountLabel: UILabel!	
	@IBOutlet weak var typeLabel: UILabel!
	
	static let identifier: String = "CustomTableViewCell"
	
	static func nib() -> UINib {
		return UINib(nibName: self.identifier, bundle: nil)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupCellApperance()
	}
	
	func setupCellApperance() {
		typeLabel.textAlignment = .right
		typeLabel.textColor = .systemGray
	}
	
	func configure(with expense: Expense) {
		nameLabel.text = expense.name
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
//		formatter.currencySymbol = ""
		amountLabel.text = formatter.string(from: NSNumber(value: expense.amount))
		
		switch expense.type {
		case .fixed:
			typeLabel.text = "🔄 \(expense.type.rawValue)" // Ou apenas expense.type.rawValue
			typeLabel.textColor = .systemBlue
		case .variable:
			typeLabel.text = "🔀 \(expense.type.rawValue)" // Ou apenas expense.type.rawValue
			typeLabel.textColor = .systemOrange
		}
		
		// Opcional: ícone diferente baseado no tipo
		let typeIcon = expense.type == .fixed ? "🔄" : "🔀"
		typeLabel.text = "\(typeIcon) \(expense.type.rawValue)"
	}
}
