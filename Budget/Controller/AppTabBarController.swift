//
//  AppTabBarController.swift
//  Budget
//
//  Created by Arthur Norat on 15/04/25.
//


final class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        customizeAppearance()
    }
    
    private func setupTabs() {
        // 1. Instanciar as ViewControllers
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let summaryVC = UINavigationController(rootViewController: SummaryViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        // 2. Definir ícones e títulos
        mainVC.tabBarItem = UITabBarItem(
            title: "Gastos",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.fill")
        )
        
        summaryVC.tabBarItem = UITabBarItem(
            title: "Resumo",
            image: UIImage(systemName: "chart.pie"),
            selectedImage: UIImage(systemName: "chart.pie.fill")
        )
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Config",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )
        
        // 3. Adicionar às tabs
        setViewControllers([mainVC, summaryVC, settingsVC], animated: true)
    }
    
    private func customizeAppearance() {
        tabBar.tintColor = .systemBlue // Cor do ícone selecionado
        tabBar.unselectedItemTintColor = .systemGray // Cor dos ícones inativos
        tabBar.backgroundColor = .systemBackground // Fundo da TabBar
    }
}