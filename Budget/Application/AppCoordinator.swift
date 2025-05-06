//
//  AppCoordinator.swift
//  Budget
//
//  Created by Arthur Coelho on 04/04/25.
//

import UIKit
import Foundation

protocol Coordinator {
	var childCoordinators: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	
	func start()
}

final class AppCoordinator: Coordinator {
	
	
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController
	private var window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
		self.navigationController = UINavigationController()
		
	}
	
	func start() {
		
		// Cria coordenadores para cada fluxo
		let addExpenseCoordinator = AddExpenseCoordinator()
		let summaryCoordinator = SummaryCoordinator()
		let settingsCoordinator = SettingsCoordinator()
		
		// Inicia cada coordenador
		addExpenseCoordinator.start()
		summaryCoordinator.start()
		settingsCoordinator.start()
		
		// Configura a TabBarController
		let tabBarController = AppTabBarController(
			addExpenseCoordinator: addExpenseCoordinator,
			summaryCoordinator: summaryCoordinator,
			settingsCoordinator: settingsCoordinator
		)
		
		// Manter referência aos coordenadores
		childCoordinators = [
			addExpenseCoordinator,
			summaryCoordinator,
			settingsCoordinator
		]
		
		window.rootViewController = tabBarController
		window.makeKeyAndVisible()		
	}
		
}


