//
//  SummaryView.swift
//  Budget
//
//  Created by Arthur Coelho on 04/04/25.
//

import UIKit

final class SummaryView: UIView {	

	// MARK: - UI Elements
	
	lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	lazy var budgetTrackerLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .systemBackground
		label.text = "Budget Tracker"
		label.font = .boldSystemFont(ofSize: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var remainingBudgetView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		
		// Left labels
		let titleLabel = UILabel()
		titleLabel.text = "Remaining Budget"
		titleLabel.font = .boldSystemFont(ofSize: 16)
//		titleLabel.textColor = .white.withAlphaComponent(0.9)
		
		let amountLabel = UILabel()
		amountLabel.text = "R$ 1.500,00"
		amountLabel.font = .systemFont(ofSize: 12)
//		amountLabel.textColor = .white
		
		// Right label
		let totalAmountLabel = UILabel()
		totalAmountLabel.text = "R$ 3.000,00"
		totalAmountLabel.font = .systemFont(ofSize: 14)
//		totalAmountLabel.textColor = .white
		totalAmountLabel.textAlignment = .right
		
		// Stacks
		let leftStack = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
		leftStack.axis = .vertical
		leftStack.spacing = 4
		leftStack.alignment = .leading
		
		let mainStack = UIStackView(arrangedSubviews: [leftStack, totalAmountLabel])
		mainStack.axis = .horizontal
		mainStack.distribution = .fill
		mainStack.alignment = .center // Alinhamento central vertical automático!
		mainStack.spacing = 8
		
		// Constraints
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(mainStack)
		
		NSLayoutConstraint.activate([
			mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor) // Centraliza tudo
		])
		
		view.heightAnchor.constraint(equalToConstant: 100).isActive = true
		return view
	}()
	
	lazy var budgetUsageView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
	
		let titleLabel = UILabel()
		titleLabel.text = "Budget Usage"
		titleLabel.font = .boldSystemFont(ofSize: 16)
//		titleLabel.textColor = .white
		
		let progressBar = UIProgressView(progressViewStyle: .default)
		progressBar.progressTintColor = .systemTeal
		progressBar.trackTintColor = .lightGray.withAlphaComponent(0.6)
		progressBar.progress = 0.5 // Exemplo de progresso
		progressBar.heightAnchor.constraint(equalToConstant: 6).isActive = true
		
		
		let mainStack = UIStackView(arrangedSubviews: [titleLabel, progressBar])
		mainStack.axis = .vertical
		mainStack.spacing = 12
		mainStack.distribution = .fill
		mainStack.alignment = .fill
		
		// Constraints
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(mainStack)
		
		NSLayoutConstraint.activate([
			mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Centraliza tudo
			
			progressBar.widthAnchor.constraint(equalTo: mainStack.widthAnchor)
		])
		
		view.heightAnchor.constraint(equalToConstant: 100).isActive = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var spendingHistoryLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .systemBackground
		label.text = "Spending history"
		label.font = .boldSystemFont(ofSize: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
		tableView.separatorStyle = .none
		return tableView
	}()	


	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .systemBackground
		setupUI()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup UI
	
	private func setupUI() {
		backgroundColor = .systemBackground
		
		// Configura hierarquia
		
		mainStackView.addArrangedSubview(budgetTrackerLabel)
		mainStackView.addArrangedSubview(remainingBudgetView)
		mainStackView.addArrangedSubview(budgetUsageView)
		mainStackView.addArrangedSubview(spendingHistoryLabel)
		mainStackView.addArrangedSubview(tableView)
		
		addSubview(mainStackView)
		
	}
	
	func configConstraints() {
		NSLayoutConstraint.activate([
			
			// tableView
			mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			
			// Constraints para a tableView (opcional, já que está na stack view)
			tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200) // Altura mínima
		])
	}	
	
	func updateBudgetValues(remaining: Double, total: Double) {
		guard let mainStack = remainingBudgetView.subviews.first as? UIStackView,
			  let leftStack = mainStack.arrangedSubviews.first as? UIStackView,
			  let amountLabel = leftStack.arrangedSubviews.last as? UILabel,
			  let totalLabel = mainStack.arrangedSubviews.last as? UILabel else { return }
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		
		amountLabel.text = formatter.string(from: NSNumber(value: remaining))
		totalLabel.text = formatter.string(from: NSNumber(value: total))
	}	
	
	func updateProgressBar(usedPercentage: Double) {
		guard let mainStack = budgetUsageView.subviews.first as? UIStackView,
			  let progressBar = mainStack.arrangedSubviews.last as? UIProgressView else { return }
		
		progressBar.progress = Float(usedPercentage)
		progressBar.progressTintColor = usedPercentage > 0.8 ? .systemRed : .systemTeal // Alerta visual se >80%
	}
}
