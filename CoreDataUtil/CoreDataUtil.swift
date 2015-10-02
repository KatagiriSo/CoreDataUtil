//
//  CoreDataUtil.swift
//  CoreDataUtil
//
//  Created by 片桐奏羽 on 2015/10/02.
//  Copyright (c) 2015年 SoKatagiri. All rights reserved.
//

import UIKit
import CoreData


class CoreDataUtil: NSObject {
    var managerContext : NSManagedObjectContext?
    var entityDescription : NSEntityDescription?
    
    var DBName = "data.sqlite"
    static internal var shareInstance : CoreDataUtil? = nil
    
    static func share()->CoreDataUtil
    {
        if (shareInstance == nil) {
            shareInstance = CoreDataUtil()
        }
        return shareInstance!
    }
    
    override init() {
        super.init()
        setUp()
    }
    
    func setUp()
    {
        // バンドルからモデルファイルを読み込む
        let m = NSManagedObjectModel.mergedModelFromBundles(nil)
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel:m!)
        
        var error:NSError?

        // 永続ストアとしてSQLite使用
        psc.addPersistentStoreWithType(
            NSSQLiteStoreType,
            configuration: nil,
            URL: sqliteURL(),
            options: persistentOptions(),
            error: &error)
        
        self.managerContext = NSManagedObjectContext()
        self.managerContext!.persistentStoreCoordinator = psc
        
        self.entityDescription = NSEntityDescription.entityForName(Record.entityName, inManagedObjectContext: self.managerContext!)
    }
    
    func sqliteURL()->(NSURL?)
    {
        // 永続storeとしてsqliteのセット
        var documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]as! String
        
        println("path=\(documentPath)")
        let url = NSURL(fileURLWithPath:documentPath.stringByAppendingPathComponent(DBName))
        return url
    }
    
    // 永続ストアのオプション
    func persistentOptions()->[String:Bool]
    {
        // マイグレーションは自動的に
        var options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
        return options
    }
    
    func GET()->[Record]
    {
        let fetchReq = NSFetchRequest(entityName: self.entityDescription!.name!)
        fetchReq.returnsObjectsAsFaults = false
        // ソートしたいとき
//        let sortDescriptor = NSSortDescriptor(key: Record.keyTimeStamp, ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // フェッチ要求実行
        var error : NSError? = nil
        var results : Array! = self.managerContext!.executeFetchRequest(fetchReq, error: &error)
        if (error != nil) {
            println("[error]\(error?.description)")
        }
        
        return results as! [Record]
    }

    func save(errorp:NSErrorPointer)->Bool
    {
        if ((self.managerContext?.save(errorp)) != nil) {
            return true
        }
        return false
    }
    
    func CREATE()->Record
    {
        var record = Record(entity:self.entityDescription!, insertIntoManagedObjectContext: self.managerContext)
        return record
    }
        
    
    
    
}
