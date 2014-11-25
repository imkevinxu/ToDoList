//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var itemName: String
    var completed: Bool = false
    private var creationDate: NSDate
    
    init(itemName: String) {
        self.itemName = itemName
        creationDate = NSDate()
        super.init()
    }
    
    override var description: String {
        return "ToDoItem: \(itemName)"
    }
    
    func initWithCoder(decoder: NSCoder) -> ToDoItem {
        itemName = decoder.decodeObjectForKey("itemName") as String
        completed = decoder.decodeBoolForKey("completed")
        return self
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(itemName, forKey: "itemName")
        encoder.encodeBool(completed, forKey: "completed")
        encoder.encodeObject(creationDate, forKey: "creationDate")
    }
}
