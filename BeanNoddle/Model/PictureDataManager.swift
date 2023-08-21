//
//  PictureDataManager.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/21.
//

import Foundation
import CoreData
import UIKit

class PictureDataManager {
    static let shared = PictureDataManager()

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
    
    func fetchPicture(_ postId: NSUUID) -> [Picture] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Picture> = Picture.fetchRequest()
        
        var retPicture = [Picture]()
        do {
            let fetchedPicture = try context.fetch(fetchRequest)
            for eachPicture in fetchedPicture {
                if eachPicture.post_id == postId as UUID {
                    retPicture.append(eachPicture)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return retPicture

    }
}
