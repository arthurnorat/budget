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
	
	lazy var mainStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 20
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	lazy var budgetTrackerLabel: UILabel = {
		makeLabel(text: "Budget tracker",
				  font: .boldSystemFont(ofSize: 30),
				  alignment: .center)
	}()
	
	lazy var formContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .secondarySystemBackground
		view.layer.cornerRadius = 12
		return view
	}()
	
	lazy var addNewExpenseLabel: UILabel = {
		let label = UILabel()
		label.text = "Add new expense"
		label.font = .systemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var nameTextField: UITextField = {
		makeTextField(placeholder: "Gasto",
					  keyboardType: .default)
	}()
	
	lazy var amountTextField: UITextField = {
		makeTextField(placeholder: "Valor (R$)",
					  keyboardType: .decimalPad)
	}()
	
	lazy var typeSegmentedControl: UISegmentedControl = {
		let segmented = UISegmentedControl(items: ["Fixo", "Variável"])
		segmented.selectedSegmentTintColor = .systemTeal
		segmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
		segmented.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
		segmented.heightAnchor.constraint(equalToConstant: 36).isActive = true
		return segmented
	}()
	
	lazy var addButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Adicionar", for: .normal)
		button.titleLabel?.font = .boldSystemFont(ofSize: 16)
		button.backgroundColor = .systemTeal
		button.tintColor = .white
		button.layer.cornerRadius = 8
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Actions
	
	//	var onCloseButtonTapped: (() -> Void)?
	
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
		
		// Form Stack
		let formStack = UIStackView(arrangedSubviews: [
			createFormLabel("Adicionar Nova Despesa"),
			nameTextField,
			amountTextField,
			typeSegmentedControl,
			addButton
		])
		formStack.axis = .vertical
		formStack.spacing = 16
		
		// Form Container
		formContainerView.addSubview(formStack)
		formStack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			formStack.topAnchor.constraint(equalTo: formContainerView.topAnchor, constant: 20),
			formStack.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 16),
			formStack.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: -16),
			formStack.bottomAnchor.constraint(equalTo: formContainerView.bottomAnchor, constant: -20)
		])
		
		// Main Stack
		mainStackView.addArrangedSubview(budgetTrackerLabel)
		mainStackView.addArrangedSubview(formContainerView)
		addSubview(mainStackView)
	}
	
	private func createFormLabel(_ text: String) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = .boldSystemFont(ofSize: 20)
		label.textAlignment = .center
		return label
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			formContainerView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
		])
	}
}

// Adicione esta extensão para criar componentes de forma mais limpa
private extension AddExpenseView {
	func makeLabel(text: String, font: UIFont, alignment: NSTextAlignment = .left) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = font
		label.textAlignment = alignment
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func makeTextField(placeholder: String, keyboardType: UIKeyboardType = .default) -> UITextField {
		let textField = UITextField()
		textField.placeholder = placeholder
		textField.keyboardType = keyboardType
		textField.borderStyle = .none
		textField.backgroundColor = .tertiarySystemBackground
		textField.layer.cornerRadius = 8
		textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
		textField.leftViewMode = .always
		return textField
	}
}
