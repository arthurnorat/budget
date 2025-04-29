//
//  CoreDataManager.swift
//  Budget
//
//  Created by Arthur Norat on 28/04/25.
//


import CoreData

class CoreDataManager {
    // 1. Singleton (instância única)
    static let shared = CoreDataManager()
    
    // 2. Container persistente (conexão com o modelo)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BudgetModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Falha ao carregar o CoreData: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    // 3. Contexto de manipulação (onde operações são feitas)
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // 4. Método para salvar alterações
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erro ao salvar no CoreData:", error.localizedDescription)
            }
        }
    }
}