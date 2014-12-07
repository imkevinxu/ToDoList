//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    
    // MARK: Properties
    
    var itemName: String
    var completed: Bool = false
    private var creationDate: NSDate
    
    // MARK: Initializers
    
    init(itemName: String) {
        self.itemName = itemName
        self.creationDate = NSDate()
        super.init()
    }
    
    override var description: String {
        return "ToDoItem: \(itemName)"
    }
    
    // MARK: Helpers
    
    func getCreationDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM d, yyy 'at' h:mm a"
        return dateFormatter.stringFromDate(creationDate)
    }
    
    // MARK: Encoding methods
    
    func initWithCoder(decoder: NSCoder) -> ToDoItem {
        itemName = decoder.decodeObjectForKey("itemName") as String
        completed = decoder.decodeBoolForKey("completed")
        creationDate = decoder.decodeObjectForKey("creationDate") as NSDate
        return self
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(itemName, forKey: "itemName")
        encoder.encodeBool(completed, forKey: "completed")
        encoder.encodeObject(creationDate, forKey: "creationDate")
    }
}
