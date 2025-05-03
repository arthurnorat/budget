//
//  ExpenseEntity+CoreDataProperties.swift
//  Budget
//
//  Created by Arthur Norat on 28/04/25.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var amount: Double
    @NSManaged public var type: String?
    @NSManaged public var date: Date?

}

extension ExpenseEntity : Identifiable {

}
