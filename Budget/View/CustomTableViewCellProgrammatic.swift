//
//  CustomTableViewCellProgrammatic.swift
//  Budget
//
//  Created by Arthur Coelho on 04/04/25.
//


import UIKit

final class CustomTableViewCellProgrammatic: UITableViewCell {
	static let identifier = "CustomTableViewCellProgrammatic"

	// Adicione as UILabels etc. aqui futuramente

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}