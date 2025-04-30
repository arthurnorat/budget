//
//  ExpenseTableViewCell.swift
//  Budget
//
//  Created by Arthur Coelho on 30/07/24.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
	
	static let identifier = "CustomTableViewCell"
	
	// MARK: - UI Components
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16, weight: .medium)
		label.textColor = .label
		return label
	}()
	
	private let amountLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.textColor = .secondaryLabel
		label.textAlignment = .right
		return label
	}()
	
	private let typeLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textAlignment = .right
		return label
	}()
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		stack.spacing = 8
		return stack
	}()
	
	// MARK: - Lifecycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupViews() {
		// Organização hierárquica
		let leftStack = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
		leftStack.axis = .vertical
		leftStack.alignment = .leading
		leftStack.spacing = 4
		
		let rightStack = UIStackView(arrangedSubviews: [amountLabel])
		rightStack.axis = .vertical
		rightStack.alignment = .trailing
		
		stackView.addArrangedSubview(leftStack)
		stackView.addArrangedSubview(rightStack)
		
		contentView.addSubview(stackView)
	}	

	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		UIView.animate(withDuration: 0.2) {
			self.contentView.backgroundColor = highlighted ? UIColor.systemTeal.withAlphaComponent(0.1) : .systemBackground
		}
	}
	
	private func setupConstraints() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
		])
	}
	
	// MARK: - Configuration
	func configure(with expense: Expense) {
		nameLabel.text = expense.name
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		amountLabel.text = formatter.string(from: NSNumber(value: expense.amount))
		
		switch expense.type {
		case .fixed:
			typeLabel.text = "\(expense.type.rawValue)"
			typeLabel.textColor = .systemBlue
		case .variable:
			typeLabel.text = "\(expense.type.rawValue)"
			typeLabel.textColor = .systemOrange
		}
	}
}
