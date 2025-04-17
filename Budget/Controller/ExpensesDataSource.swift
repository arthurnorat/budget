//
//  ExpensesDataSource.swift
//  Budget
//
//  Created by Arthur Coelho on 09/04/25.
//

import UIKit

final class ExpensesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    private var expenses: [Expense] = []
    
    // MARK: - Public Methods
    func updateExpenses(_ expenses: [Expense]) {
        self.expenses = expenses
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
	
	func getAllExpenses() -> [Expense] {
			return expenses
	}
    
    func getExpense(at indexPath: IndexPath) -> Expense {
        return expenses[indexPath.row]
    }
	
	
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else {
            fatalError("Failed to dequeue CustomTableViewCell")
        }
        
        let expense = expenses[indexPath.row]
        cell.configure(with: expense)
        return cell
    }
}
