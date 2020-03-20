//
//  CoreDataManager.swift
//  MEMO
//
//  Created by 장용범 on 2020/03/19.
//  Copyright © 2020 장용범. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    var memos: [Memo] = []
    
    // 메모 가져오기
    func getMemos() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDataDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDataDesc]
        
        do {
            memos = try context.fetch(request)
        } catch {
            print(error)
        }
        
    }
    
    // 메모 추가하기
    func addMemo(content: String?, completion: @escaping ((Bool) -> Void)) {
        let newMemo = Memo(context: context)
        newMemo.content = content
        newMemo.date = Date()
        
        saveContext { success in
            completion(success)
        }
    }
    
    // 메모 삭제하기
    func deleteMemo(memo: Memo?, completion: @escaping ((Bool) -> Void)) {
        guard let deleteMemo = memo else { return }
        context.delete(deleteMemo)
        
        saveContext { success in
            completion(success)
        }
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MEMO")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext (completion: ((Bool) -> Void)) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(true)
            } catch let nserror as NSError {
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                completion(false)
            }
        }
    }
    
}

