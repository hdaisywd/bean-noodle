import UIKit
import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

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

    func saveData(postId: NSUUID, userId: NSUUID, emotionSelectedNumber: Int, content: String, imageList: [Data]) {
        let context = persistentContainer.viewContext

        let postEntity = NSEntityDescription.entity(forEntityName: "Post", in: context)
        
        if let postEntity = postEntity {
            let newPost = NSManagedObject(entity: postEntity, insertInto: context)
            newPost.setValue(postId, forKey: "post_id")
            newPost.setValue(userId, forKey: "user_id")
            newPost.setValue(content, forKey: "post_text")
            newPost.setValue(emotionSelectedNumber, forKey: "emotion_num")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let pictureEntity = NSEntityDescription.entity(forEntityName: "Picture", in: context)
        for image in imageList {
            if let pictureEntity = pictureEntity {
                let newPicture = NSManagedObject(entity: pictureEntity, insertInto: context)
                newPicture.setValue(image, forKey: "picture")
                newPicture.setValue(postId, forKey: "post_id")
            }
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}

