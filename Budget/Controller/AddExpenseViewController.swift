//
//  WelcomeViewController.swift
//  Budget
//
//  Created by Arthur Norat on 15/04/25.
//

import UIKit

protocol AddExpenseDelegate: AnyObject {
	func didAddNewExpense(_ expense: Expense)
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
	}
    
    
    // MARK: - Actions
	
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}

// MARK: - AddExpenseViewProtocol

extension AddExpenseViewController: AddExpenseViewProtocol {
	func tappedAddButton() {
		guard let name = addExpenseView.nameTextField.text, !name.isEmpty,
			  let amountText = addExpenseView.amountTextField.text,
			  let amount = Float(amountText) else {
			// Mostrar alerta de erro
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
