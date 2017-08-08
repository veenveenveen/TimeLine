//
//  CoreDataManager.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    //单例
    static let shareManager = CoreDataManager()
    
    //管理对象模型
    fileprivate var managedObjectModel: NSManagedObjectModel!
    //持久化存储调度器
    fileprivate var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    //管理对象上下文
    fileprivate var managedObjectContext: NSManagedObjectContext!
    
    //FetchedResultsController控制器
    var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult>!
    
    fileprivate override init() {
        super.init()
        
        //获取模型描述文件的URL .xcdatamodeld文件编译后在bundle中生成 .momd 文件
        let modelURL = Bundle.main.url(forResource: "TimeLineModel", withExtension: "momd")
        //实例化 指定模型描述文件
        managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        /*添加存储器
         Type:存储类型, 数据库/XML/二进制/内存
         configuration:不需要额外配置,可以为nil
         URL:数据保存的文件的URL 这里我们放到documents里
         options:可以为空
         */
        let fileURL = applicationDocumentDirectory().appendingPathComponent("coreData.sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: nil)
        }
        catch {
            print(#function, "add Persistent Store error")
        }
        
        //实例化管理对象上下文
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        //指定上下文所处的持久化存储调度器
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        //创建请求对象，并指明操作Note表
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeLineItem")
        // 设置排序规则
        let sort = NSSortDescriptor(key: "timeText", ascending: false)
        request.sortDescriptors = [sort];
        //创建NSFetchedResultsController控制器实例，并绑定MOC
        fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: "sectionName", cacheName: nil)
        
        do {
            try fetchedResultController.performFetch()
        }
        catch {
            print(#function, "fetch error")
        }
    }
    
    //获取document目录的URL
    fileprivate func applicationDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    //保存上下文
    func saveContext() {
        if managedObjectContext != nil {
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                }
                catch {
                    print(#function, "save error")
                }
            }
        }
    }
    
    //删除
    func deleteItemAtIndexPath(_ indexPath: IndexPath) {
        let note = fetchedResultController.object(at: indexPath)
        managedObjectContext.delete(note as! NSManagedObject)
        //切记！要保存
        saveContext()
    }
    
    //增加
    func addNewItem(timeText: String, contentText: String) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "TimeLineItem", into: managedObjectContext) as! TimeLineItem
        item.timeText = timeText
        item.contentText = contentText
        //切记！要保存
        saveContext()
    }
}
