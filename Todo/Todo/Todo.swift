//
//  Todo.swift
//  Todo
//
//  Created by Aye Thu Thu Zaw on 2020/06/22.
//  Copyright © 2020 ALJ. All rights reserved.
//

import Foundation
import RealmSwift

class ToDo: Object{
     @objc dynamic var name: String = ""
       @objc dynamic var desc: String = ""
       @objc dynamic var isComplete: Bool = false
       @objc dynamic var createDate: NSDate = NSDate(timeIntervalSince1970: 0)
       @objc dynamic var updateDate: NSDate = NSDate(timeIntervalSince1970: 0)
}
