//
//  CoreDataManager.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/9.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let shareManger = CoreDataManager()
    
    fileprivate override init() {
        super.init()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "TimeLineModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    ///save
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    ///add new
    @discardableResult
    func insertNewItem(timeText: String = Date.currentDate(), contentText: String = "this is a test test test") -> TimeLineItem {
        let item = NSEntityDescription.insertNewObject(forEntityName: "TimeLineItem", into: context) as! TimeLineItem
        item.timeText = timeText
        item.contentText = contentText
        saveContext()
        return item
    }
    
    ///delete
    func deleteAll() {
        for item in queryData() {
            context.delete(item)
        }
        saveContext()
    }
    
    ///query
    func queryData() -> [TimeLineItem] {
        var fetchObjects = [TimeLineItem]()
        let fetchRequest = NSFetchRequest<TimeLineItem>(entityName: "TimeLineItem")
        do {
            fetchObjects = try context.fetch(fetchRequest)
            for item in fetchObjects {
                print(item.timeText!,",",item.contentText!)
            }
        } catch {
            print(error.localizedDescription)
        }
        return fetchObjects
    }
    
    
    
}
