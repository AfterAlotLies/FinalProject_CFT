//
//  ShoppingCartService.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 19.06.2024.
//

import Foundation
import CoreData

// MARK: - IShoppingCart protocol
protocol IShoppingCart {
    func addCartData(productData: DataRepository)
    func fetchCartData() -> [DataRepository]?
    func removeProductData(_ title: String, _ price: Double, _ rating: Double, _ imageUrl: String)

}

// MARK: - ShoppingCartService
class ShoppingCartService: IShoppingCart {
    
    private let entityName: String = "UserCart"
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalProject_CFT")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                print(error)
            }
        }
        return container
    }()
    
    func addCartData(productData: DataRepository) {
        defer { self.saveContext() }
        let context = persistentContainer.viewContext
        let cartEntity = UserCart(context: context)
        cartEntity.title = productData.title
        cartEntity.price = productData.price
        cartEntity.rating = productData.rating.rate
        cartEntity.imageUrl = productData.image
    }
    
    func fetchCartData() -> [DataRepository]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserCart> = UserCart.fetchRequest()
        var array = [UserCart]()
        
        do {
            let cartItems = try context.fetch(fetchRequest)
            array = cartItems
            var new = [DataRepository]()
            array.forEach {
                new.append(DataRepository(title: $0.title, 
                                          price: $0.price,
                                          description: "",
                                          category: "",
                                          rating: Rating(rate: $0.rating, count: 0),
                                          image: $0.imageUrl))
            }
            return new
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func removeProductData(_ title: String, _ price: Double, _ rating: Double, _ imageUrl: String) {
        defer {self.saveContext()}
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCart>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND price == %lf AND rating == %lf AND imageUrl == %@" , title, price, rating, imageUrl as CVarArg)
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
        } catch let error as NSError {
            fatalError("Could not delete item. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - ShoppingCartService private methods
private extension ShoppingCartService {
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
            }
        }
    }
}
