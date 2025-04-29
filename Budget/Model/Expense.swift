//
//  Expense.swift
//  Budget
//
//  Created by Arthur Coelho on 30/07/24.
//

import Foundation


enum ExpenseType: String {
	case fixed = "Fixo"
	case variable = "Variável"
}

struct Expense {
	var name: String
	var amount: Double
	var type: ExpenseType
}
