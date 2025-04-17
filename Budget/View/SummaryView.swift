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
		label.text = "Budget Tracker"
		label.font = .boldSystemFont(ofSize: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var remainingBudgetView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemTeal
		
		// Left labels
		let titleLabel = UILabel()
		titleLabel.text = "Remaining Budget"
		titleLabel.font = .boldSystemFont(ofSize: 16)
		titleLabel.textColor = .white.withAlphaComponent(0.9)
		
		let amountLabel = UILabel()
		amountLabel.text = "R$ 1.500,00"
		amountLabel.font = .systemFont(ofSize: 12)
		amountLabel.textColor = .white
		
		// Right label
		let totalAmountLabel = UILabel()
		totalAmountLabel.text = "R$ 3.000,00"
		totalAmountLabel.font = .systemFont(ofSize: 14)
		totalAmountLabel.textColor = .white
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
		view.backgroundColor = .systemIndigo
		
		let titleLabel = UILabel()
		titleLabel.text = "Budget Usage"
		titleLabel.font = .boldSystemFont(ofSize: 16)
		titleLabel.textColor = .white
		
		let progressBar = UIProgressView(progressViewStyle: .default)
		progressBar.progressTintColor = .systemGreen
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
		label.text = "Spending history"
		label.font = .boldSystemFont(ofSize: 28)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
}
