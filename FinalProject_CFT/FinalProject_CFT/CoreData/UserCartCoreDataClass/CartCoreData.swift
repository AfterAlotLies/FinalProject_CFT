//
//  CartCoreData.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 19.06.2024.
//

import Foundation
import CoreData

@objc(UserCart)
public class UserCart: NSManagedObject {
    
}

extension UserCart {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCart> {
        return NSFetchRequest<UserCart>(entityName: "UserCart")
    }

    @NSManaged public var title: String
    @NSManaged public var price: Double
    @NSManaged public var rating: Double
    @NSManaged public var imageUrl: String
}
