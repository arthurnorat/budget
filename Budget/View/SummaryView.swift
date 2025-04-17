//
//  MainViewController.swift
//  Budget
//
//  Created by Arthur Coelho on 04/04/25.
//

import UIKit



final class SummaryView: UIView {	

	// MARK: - UI Elements	

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
		
		
		addSubview(tableView)
//		addSubview(typeSegmentedControl)
		
	}
	
	func configConstraints() {
		NSLayoutConstraint.activate([
			
			// tableView
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 48),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
