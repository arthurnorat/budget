//
//  SummaryViewController.swift
//  Budget
//
//  Created by Arthur Coelho on 07/04/25.
//

import UIKit
import CoreData

final class SummaryViewController: UIViewController {
	
	// MARK: - Properties
	
	
	private let mainView = SummaryView()
	private let dataSource = ExpensesDataSource() // Substitui o array direto
	private var expenses: [Expense] = [] {
		didSet {
			dataSource.updateExpenses(expenses)
		}
	}
	private let coreDataManager = CoreDataManager.shared

	// MARK: - Lifecycle

	override func loadView() {
		self.view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configTableView()
		mainView.tableView.tableHeaderView = createTableHeaderView()
		loadExpenses()		
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
	
	private func loadExpenses() {
		// 1. Cria um 'pedido' (fetch request) para buscar todas as ExpenseEntity no CoreData
		let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
		
		do {
			// 2. Tenta buscar os dados no CoreData (usando o contexto)
			let savedExpenses = try coreDataManager.context.fetch(request)
			
			// 3. Converte as ExpenseEntity (CoreData) para o modelo local Expense (se necessário)
			let expenses = savedExpenses.map { entity in
				Expense(
					id: entity.id ?? UUID(),
					name: entity.name ?? "",
					amount: entity.amount,
					type: ExpenseType(rawValue: entity.type ?? "") ?? .variable,  // Conversão segura
					date: entity.date ?? Date()
				)
			}
			
			// 4. Atualiza o dataSource com os dados buscados
			dataSource.updateExpenses(expenses)
			
			// 5. Recarrega a tabela para exibir os dados
			mainView.tableView.reloadData()
			
		} catch {
			// 6. Se houver erro, mostra no console (em produção, exibiríamos um alerta)
			print("Erro ao carregar despesas:", error.localizedDescription)
		}
	}
	
	
}

// MARK: - UITableViewDelegate

extension SummaryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		//1. Adiciona a ação de deletar
		let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] _, _, completionHandler in
			//2. Deleta a despesa
			self?.dataSource.deleteExpense(at: indexPath.row)
			
			//3. Atualiza a tabela
			tableView.deleteRows(at: [indexPath], with: .automatic)
			
			//4. Informa que a ação foi concluída
			completionHandler(true)
		}
		
		//5. Retorna a configuração com a ação
		return UISwipeActionsConfiguration(actions: [deleteAction])
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
