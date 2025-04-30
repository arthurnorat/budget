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
	var id: UUID
	var name: String
	var amount: Double
	var type: ExpenseType
	var date: Date
	
	init(
		id: UUID = UUID(),
		name: String,
		amount: Double,
		type: ExpenseType,
		date: Date = Date()
	) {
		self.id = id
		self.name = name
		self.amount = amount
		self.type = type
		self.date = date
	}
}
