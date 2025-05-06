//
//  AppTabBarController.swift
//  Budget
//
//  Created by Arthur Norat on 15/04/25.
//

import UIKit

final class AppTabBarController: UITabBarController {
	
    init(
		addExpenseCoordinator: AddExpenseCoordinator,
		summaryCoordinator: SummaryCoordinator,
		settingsCoordinator: SettingsCoordinator
	) {
		super.init(nibName: nil, bundle: nil)
		
		// Configurar as view controllers dos controladores
		viewControllers = [
			addExpenseCoordinator.navigationController,
			summaryCoordinator.navigationController,
			settingsCoordinator.navigationController
		]
		
		// Configurar a comunicação entre as abas
		if let addExpenseVC = addExpenseCoordinator.rootViewController as? AddExpenseViewController,
		   let summaryVC = summaryCoordinator.rootViewController as? SummaryViewController {
			addExpenseVC.delegate = summaryVC
		}
		
		customizeAppearance()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func customizeAppearance() {
		tabBar.tintColor = .systemBlue // Cor do ícone selecionado
		tabBar.unselectedItemTintColor = .systemGray // Cor dos ícones inativos
		tabBar.backgroundColor = .systemBackground // Fundo da TabBar
		
		// Configura os itens da TabBar
		viewControllers?[0].tabBarItem = UITabBarItem(
			title: "Adicionar",
			image: UIImage(systemName: "plus"),
			selectedImage: UIImage(systemName: "plus.circle.fill")
		)
		
		viewControllers?[1].tabBarItem = UITabBarItem(
			title: "Gastos",
			image: UIImage(systemName: "list.bullet"),
			selectedImage: UIImage(systemName: "list.bullet.fill")
		)
		
		viewControllers?[2].tabBarItem = UITabBarItem(
			title: "Config",
			image: UIImage(systemName: "gear"),
			selectedImage: UIImage(systemName: "gear.fill")
		)
	}
}
