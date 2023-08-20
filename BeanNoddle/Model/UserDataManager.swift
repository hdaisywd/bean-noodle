//
//  UserDataManager.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/21.
//

import Foundation
import CoreData
import UIKit

class UserDataManager {
    static let shared = UserDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func createUser(_ userId: UUID) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context) {
            let newUser = NSManagedObject(entity: userEntity, insertInto: context)
            newUser.setValue(userId, forKey: "user_id")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
    func fetchPosts(_ userId: NSUUID) -> [Post] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        var retPosts = [Post]()
        do {
            let fetchedPost = try context.fetch(fetchRequest)
            for eachPost in fetchedPost {
                print(eachPost.user_id)
                if eachPost.user_id == userId as UUID {
                    retPosts.append(eachPost)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return retPosts

    }
}
