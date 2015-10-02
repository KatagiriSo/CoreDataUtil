//
//  Record.swift
//  CoreDataUtil
//
//  Created by 片桐奏羽 on 2015/10/02.
//  Copyright (c) 2015年 SoKatagiri. All rights reserved.
//

import Foundation
import CoreData

/* プロパティを追加したい場合、
1. Model.xcdatamodeldに新Versionを追加
2. 追加したい属性を追加などの編集
3. インスペクタで使用するモデルを新Versionを指定
4. クラス側も対応する属性の追加(@NSManaged)
*/
@objc(Record)
class Record : NSManagedObject
{
    @NSManaged var timestamp:NSDate
    @NSManaged var text:String
    
    static let entityName = "Record"
    static let keyTimeStamp = "timestamp"
    static let keyText = "text"
}