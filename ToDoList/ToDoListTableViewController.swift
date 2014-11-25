//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var toDoItems: [ToDoItem] = []
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.readToDoItemsFromUserDefaults()
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell
        let toDoItem = self.toDoItems[indexPath.row]
        cell.textLabel.text = toDoItem.itemName
        if toDoItem.completed {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.toDoItems.removeAtIndex(indexPath.row)
            self.writeToDoItemsToUserDefaults()
            self.tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let tappedItem = self.toDoItems[indexPath.row]
        tappedItem.completed = !tappedItem.completed
        self.writeToDoItemsToUserDefaults()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    // MARK: IBActions

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as AddToDoItemViewController
        let item = source.todoItem
        if let newItem = item {
            self.toDoItems.append(newItem)
            self.writeToDoItemsToUserDefaults()
            self.tableView.reloadData()
            SVProgressHUD.showSuccessWithStatus("Successfully added!")
        }
    }
    
    // MARK: Convenience
    
    func writeToDoItemsToUserDefaults() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self.toDoItems) as NSData?
        self.defaults.setObject(data, forKey: "toDoItems")
        self.defaults.synchronize()
    }
    
    func readToDoItemsFromUserDefaults() {
        let data = self.defaults.objectForKey("toDoItems") as? NSData
        if data != nil {
            self.toDoItems = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as [ToDoItem]
        } else {
            self.writeToDoItemsToUserDefaults()
        }
    }
    
}
