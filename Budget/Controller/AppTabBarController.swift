//
//  AppTabBarController.swift
//  Budget
//
//  Created by Arthur Norat on 15/04/25.
//

import UIKit

final class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        customizeAppearance()
    }
    
    private func setupTabs() {
        // 1. Instanciar as ViewControllers
		let addExpenseVC = UINavigationController(rootViewController: AddExpenseViewController())
        let summaryVC = UINavigationController(rootViewController: SummaryViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
		
		if let addExpenseController = addExpenseVC.viewControllers.first as? AddExpenseViewController,
		   let summaryController = summaryVC.viewControllers.first as? SummaryViewController {
			addExpenseController.delegate = summaryController
		}
        
        // 2. Definir ícones e títulos
		addExpenseVC.tabBarItem = UITabBarItem(
			title: "Adicionar",
			image: UIImage(systemName: "plus"),
			selectedImage: UIImage(systemName: "plus.circle.fill")
		)
		
		summaryVC.tabBarItem = UITabBarItem(
            title: "Gastos",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.fill")
        )
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Config",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )
        
        // 3. Adicionar às tabs
        setViewControllers([addExpenseVC, summaryVC, settingsVC], animated: true)
    }
    
    private func customizeAppearance() {
        tabBar.tintColor = .systemBlue // Cor do ícone selecionado
        tabBar.unselectedItemTintColor = .systemGray // Cor dos ícones inativos
        tabBar.backgroundColor = .systemBackground // Fundo da TabBar
    }
}
