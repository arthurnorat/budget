//
//  WelcomeViewController.swift
//  Budget
//
//  Created by Arthur Norat on 15/04/25.
//

import UIKit
import Foundation

protocol AddExpenseDelegate: AnyObject {
	func didAddNewExpense(_ expense: Expense)
	func didCancelAddExpense()
}

final class AddExpenseViewController: UIViewController {
	
	// MARK: - Properties
	
	private let addExpenseView = AddExpenseView()
	weak var delegate: AddExpenseDelegate?
	private let dataSource = ExpensesDataSource()	
	
	// MARK: - Lifecycle
	
	override func loadView() {
		self.view = addExpenseView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addExpenseView.delegate = self
		setupKeyboard()
		setupButtonAnimation()
	}
    
    
    // MARK: - Actions
	
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
	
	private func setupKeyboard() {
		// Toque fora do teclado para fechá-lo
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapGesture)
		
		// Observadores para ajustar a view quando o teclado aparece/some
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
	}

	@objc private func dismissKeyboard() {
		view.endEditing(true)
	}

	@objc private func keyboardWillShow(notification: NSNotification) {
		guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
		view.frame.origin.y = -keyboardSize.height / 2 // Ajusta a view para cima
	}

	@objc private func keyboardWillHide() {
		view.frame.origin.y = 0 // Volta a view ao normal
	}
	
	private func setupButtonAnimation() {
		addExpenseView.addButton.addTarget(
			self,
			action: #selector(animateButtonTap),
			for: .touchDown
		)
		
		addExpenseView.addButton.addTarget(
			self,
			action: #selector(animateButtonRelease),
			for: [.touchUpInside, .touchUpOutside]
		)
	}

	@objc private func animateButtonTap(_ sender: UIButton) {
		UIView.animate(withDuration: 0.1) {
			sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		}
	}

	@objc private func animateButtonRelease(_ sender: UIButton) {
		UIView.animate(withDuration: 0.1) {
			sender.transform = .identity
		}
	}
	
}

// MARK: - AddExpenseViewProtocol

extension AddExpenseViewController: AddExpenseViewProtocol {
	func tappedAddButton() {
		guard let name = addExpenseView.nameTextField.text, !name.isEmpty,
			  let amountText = addExpenseView.amountTextField.text,
			  let amount = Float(amountText) else {
			return
		}
		
		let selectedType: Expense.ExpenseType = addExpenseView.typeSegmentedControl.selectedSegmentIndex == 0 ? .fixed : .variable
		
		let expense = Expense(name: name, amount: amount, type: selectedType)
		delegate?.didAddNewExpense(expense)
		
		// Limpa os campos
		addExpenseView.nameTextField.text = ""
		addExpenseView.amountTextField.text = ""
		addExpenseView.typeSegmentedControl.selectedSegmentIndex = 0
		
		// Navega para a SummaryView - a decidir
		if let tabBarController = self.tabBarController {
			tabBarController.selectedIndex = 1
		}
	}
}

private extension AddExpenseViewController {
	/// Valida os campos e retorna um `Expense` se válido, ou `nil` se inválido
	func validateForm() -> Expense? {
		// Validação do Nome
		guard let name = addExpenseView.nameTextField.text?.trimmingCharacters(in: .whitespaces),
			  !name.isEmpty,
			  name.count >= 2 else {
			showAlert(title: "Nome inválido", message: "Digite um nome com pelo menos 2 caracteres")
			return nil
		}
		
		// Validação do Valor
		guard let amountText = addExpenseView.amountTextField.text,
			  let amount = Float(amountText),
			  amount > 0 else {
			showAlert(title: "Valor inválido", message: "Digite um valor positivo")
			return nil
		}
		
		// Define o tipo (Fixo/Variável)
		let type: Expense.ExpenseType = addExpenseView.typeSegmentedControl.selectedSegmentIndex == 0 ? .fixed : .variable
		
		return Expense(name: name, amount: amount, type: type)
	}
	
	/// Exibe um alerta de erro
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
