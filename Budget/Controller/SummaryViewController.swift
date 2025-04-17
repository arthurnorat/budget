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
		title = "Resumo"		
	}
	
	func configTableView() {
		mainView.tableView.dataSource = dataSource // Usa o dataSource externo
		mainView.tableView.delegate = self
		mainView.tableView.register(
			CustomTableViewCell.nib(),
			forCellReuseIdentifier: CustomTableViewCell.identifier)
	}
	
	func createTableHeaderView() -> UIView {
		let headerView = UIView()
		headerView.backgroundColor = .systemGray6
		
		let nameLabel = UILabel()
		nameLabel.text = "Nome"
		nameLabel.font = .boldSystemFont(ofSize: 16)
		
		let amountLabel = UILabel()
		amountLabel.text = "Valor"
		amountLabel.font = .boldSystemFont(ofSize: 16)
		amountLabel.textAlignment = .center
		
		let typeLabel = UILabel()
		typeLabel.text = "Tipo"
		typeLabel.font = .boldSystemFont(ofSize: 16)
		typeLabel.textAlignment = .right
		
		let stack = UIStackView(arrangedSubviews: [nameLabel, amountLabel, typeLabel])
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 8
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		headerView.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
			stack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
			stack.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
			stack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
		])
		
		// Define a altura do header
		let screenWidth = UIScreen.main.bounds.width
		headerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 40)
		
		return headerView
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
	func didAddNewExpense(_ expense: Expense) {
		print("New expense added: \(expense.name), amount: \(expense.amount)")
		dataSource.addExpense(expense)
		mainView.tableView.reloadData()
	}
}
