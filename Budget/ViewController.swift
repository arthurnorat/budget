//
//  ViewController.swift
//  Budget
//
//  Created by Arthur Coelho on 29/07/24.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var expenseTextField: UITextField!
	@IBOutlet weak var addExpenseButton: UIButton!
	
	var expenses: [Int] = [3, 1, 6, 8]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configTableView()		
	}
	
	func configTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
	}
	
	@IBAction func addExpensePressed(_ sender: UIButton) {
		let newExpense = expenseTextField.text ?? ""
		if let expenseValue = Int(newExpense), !newExpense.isEmpty {
			expenses.append(expenseValue)
			tableView.reloadData()
			expenseTextField.text = ""
		}
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return expenses.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
		cell?.setupCell(title: String(expenses[indexPath.row]))
		return cell ?? UITableViewCell()
	}
}
