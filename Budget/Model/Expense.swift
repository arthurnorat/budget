//
//  Expense.swift
//  Budget
//
//  Created by Arthur Coelho on 30/07/24.
//

import Foundation

struct Expense {
	var name: String
	var amount: Float
	var type: ExpenseType
	
	enum ExpenseType: String {
		case fixed = "Fixo"
		case variable = "Variável"
	}
}
