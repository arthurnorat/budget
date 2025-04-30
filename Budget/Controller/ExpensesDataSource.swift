//
//  ExpensesDataSource.swift
//  Budget
//
//  Created by Arthur Coelho on 09/04/25.
//

import UIKit
import CoreData

final class ExpensesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
	
    private var expenses: [Expense] = []
	private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Public Methods
	
	func getContext() -> NSManagedObjectContext {
		return coreDataManager.context
	}
	
    func updateExpenses(_ newExpenses: [Expense]) {
		self.expenses = newExpenses
    }
    
    func addExpense(_ expense: Expense) {
        let entity = ExpenseEntity(context: coreDataManager.context)
		entity.id = expense.id
		entity.name = expense.name
		entity.amount = expense.amount
		entity.type = expense.type.rawValue
		entity.date = expense.date
		
		coreDataManager.saveContext()
		
		expenses.append(expense)
    }
	
	func getAllExpenses() -> [Expense] {
			return expenses
	}
    
	func getExpense(at index: Int) -> Expense? {
		guard index < expenses.count else { return nil }
		return expenses[index]
	}
	
	func getTotalSpent() -> Double {
		return expenses.reduce(0) { $0 + $1.amount }
	}
	
	func numberOfExpenses() -> Int {
		return expenses.count
	}
	
	func deleteExpense(at index: Int) {
		// 1. Verifica se o índice é válido
		guard index < expenses.count else { return }
		
		// 2. Obtém a entidade do CoreData correspondente
		let expenseToDelete = expenses[index]
		if let entity = try? coreDataManager.context.fetch(ExpenseEntity.fetchRequest())
			.first(where: { $0.id == expenseToDelete.id }) {
			
			// 3. Remove do CoreData
			coreDataManager.context.delete(entity)
			coreDataManager.saveContext()
		}
		
		// 4. Remove do array local
		expenses.remove(at: index)
	}
	
	
    
    // MARK: - UITableViewDataSource
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExpenseTableViewCell.identifier,
            for: indexPath
        ) as? ExpenseTableViewCell else {
            return UITableViewCell()
        }
        
        let expense = expenses[indexPath.row]
        cell.configure(with: expense)
        return cell
    }
}
