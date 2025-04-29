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
		entity.id = UUID()
		entity.name = expense.name
		entity.amount = expense.amount
		entity.type = expense.type.rawValue
		entity.date = Date()
		
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
