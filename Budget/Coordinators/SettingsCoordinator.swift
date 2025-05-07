//
//  SettingsCoordinator.swift
//  Budget
//
//  Created by Arthur Norat on 06/05/25.
//

import UIKit

final class SettingsCoordinator: Coordinator {
	
	// MARK: - Coordinator Properties
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController
	
	// MARK: - Computed Properties
	var rootViewController: UIViewController {
		return navigationController.viewControllers.first!
	}
	
	// MARK: - Initialization
	init() {
		self.navigationController = UINavigationController()
		configureNavigationController()
	}
	
	// MARK: - Coordinator Lifecycle
	func start() {
		let viewController = SettingsViewController()
		navigationController.setViewControllers([viewController], animated: false)
	}
	
	// MARK: - Private Methods
	private func configureNavigationController() {
		navigationController.navigationBar.prefersLargeTitles = true
		// Customizações específicas do navigation
	}
}
