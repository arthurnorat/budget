//
//  SummaryViewController.swift
//  Budget
//
//  Created by Arthur Coelho on 07/04/25.
//

import UIKit

final class SummaryViewController: UIViewController {
	
	// MARK: - Properties

	private let mainView = SummaryView()
	private let dataSource = ExpensesDataSource() // Substitui o array direto
	private var expenses: [Expense] = [] {
		didSet {
			dataSource.updateExpenses(expenses)
		}
	}

	// MARK: - Lifecycle

	override func loadView() {
		self.view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configTableView()
		mainView.tableView.tableHeaderView = createTableHeaderView()
	}
	
	func configTableView() {
		mainView.tableView.dataSource = dataSource // Usa o dataSource externo
		mainView.tableView.delegate = self
		mainView.tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: ExpenseTableViewCell.identifier)
	}
	
	private func createTableHeaderView() -> UIView {
		let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
		
		let label = UILabel()
		label.text = "Total: R$ 0,00"
		label.font = .boldSystemFont(ofSize: 16)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		
		header.addSubview(label)
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: header.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
		])
		
		return header
	}
	
	func addNewExpense(_ expense: Expense) {
		dataSource.addExpense(expense) // Supondo que ExpensesDataSource tenha este método
		mainView.tableView.reloadData()
	}
	
	
}

// MARK: - UITableViewDelegate
extension SummaryViewController: UITableViewDelegate {
	// Mantemos o delegate no controller pois lida com interação do usuário
		func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			tableView.deselectRow(at: indexPath, animated: true)
			// Lógica de seleção aqui
		}	
}

extension SummaryViewController: AddExpenseDelegate {
	func didCancelAddExpense() {
	}
	
	func didAddNewExpense(_ expense: Expense) {
		dataSource.addExpense(expense)
		
		// Atualiza tudo de uma vez
		let totalSpent = Double(dataSource.getTotalSpent())
		let totalBudget: Double = 3000 // Exemplo (poderia vir de um SettingsManager)
		
		mainView.updateBudgetValues(
			remaining: totalBudget - totalSpent,
			total: totalBudget
		)
		
		mainView.updateProgressBar(usedPercentage: totalSpent / totalBudget)
		
		if let header = mainView.tableView.tableHeaderView,
		   let label = header.subviews.first as? UILabel {
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			label.text = "Total: \(formatter.string(from: NSNumber(value: totalSpent)) ?? "")"
		}
		
		let newRowIndex = dataSource.numberOfExpenses() - 1 // Método que você precisa criar
		mainView.tableView.insertRows(at: [IndexPath(row: newRowIndex, section: 0)], with: .automatic)
	}
}
