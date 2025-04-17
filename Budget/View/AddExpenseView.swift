//
//  AddExpenseView.swift
//  Budget
//
//  Created by Arthur Norat on 16/04/25.
//

import UIKit

protocol AddExpenseViewProtocol: AnyObject {
	func tappedAddButton()
}

class AddExpenseView: UIView {
	
	weak var delegate: AddExpenseViewProtocol?
	
	public func delegate(_ delegate: AddExpenseViewProtocol?) {
		self.delegate = delegate
	}
	
	// MARK: - UI Elements
	
	lazy var budgetTrackerLabel: UILabel = {
		let label = UILabel()
		label.text = "Budget Tracker"
		label.font = .boldSystemFont(ofSize: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var addNewExpenseLabel: UILabel = {
		let label = UILabel()
		label.text = "Add new expense"
		label.font = .systemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var nameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Nome do gasto"
		textField.borderStyle = .roundedRect
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()

	lazy var amountTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Valor"
		textField.keyboardType = .decimalPad
		textField.borderStyle = .roundedRect
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	lazy var typeSegmentedControl: UISegmentedControl = {
		let segmented = UISegmentedControl(items: ["Fixo", "Variável"])
		segmented.selectedSegmentIndex = 0
		segmented.translatesAutoresizingMaskIntoConstraints = false
		return segmented
	}()

	lazy var addButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Adicionar", for: .normal)
		button.addTarget(self, action: #selector(tappedAddButton(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Actions
	
//	ver o que é isso: var onCloseButtonTapped: (() -> Void)?
	
	@objc func tappedAddButton(_ sender: UIButton) {
		delegate?.tappedAddButton()
	}
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: - Setup
	private func setupUI() {
		backgroundColor = .systemBackground
		
		addSubview(budgetTrackerLabel)
		addSubview(addNewExpenseLabel)
		addSubview(nameTextField)
		addSubview(amountTextField)
		addSubview(typeSegmentedControl)
		addSubview(addButton)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			
			// budgetTrackerLabel
			budgetTrackerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
			budgetTrackerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			budgetTrackerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			budgetTrackerLabel.heightAnchor.constraint(equalToConstant: 40),
			
			// addNewExpenseLabel
			addNewExpenseLabel.topAnchor.constraint(equalTo: budgetTrackerLabel.bottomAnchor, constant: 16),
			addNewExpenseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			addNewExpenseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			addNewExpenseLabel.heightAnchor.constraint(equalToConstant: 20),
			
			// nameTextField
			nameTextField.topAnchor.constraint(equalTo: addNewExpenseLabel.bottomAnchor, constant: 8),
			nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			nameTextField.heightAnchor.constraint(equalToConstant: 40),
			
			// amountTextField
			amountTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12),
			amountTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
			amountTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
			amountTextField.heightAnchor.constraint(equalToConstant: 40),
			
			// typeSegmentedControl
			typeSegmentedControl.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 12),
			typeSegmentedControl.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
			typeSegmentedControl.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
			typeSegmentedControl.heightAnchor.constraint(equalToConstant: 32),
			
			// addButton
			addButton.topAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 16),
			addButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
			addButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
			addButton.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
