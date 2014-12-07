//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, AddToDoItemViewControllerDelegate {
    
    // MARK: Properties
    
    var toDoItems: [ToDoItem] = []
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.readToDoItemsFromUserDefaults()
        self.addGestureRecognizers()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addToDoItemSegue" {
            let navigationController = segue.destinationViewController as UINavigationController
            let destination = navigationController.topViewController as AddToDoItemViewController
            destination.numToDoItems = self.toDoItems.count
        }
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
        for gestureRecognizer in tableView.gestureRecognizers! {
            if gestureRecognizer is UILongPressGestureRecognizer && gestureRecognizer.state == UIGestureRecognizerState.Began {
                let creationDateString = NSMutableAttributedString(string: "Created: \(toDoItem.getCreationDate())")
                creationDateString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16.0), range: NSMakeRange(0, 8))
                cell.textLabel.attributedText = creationDateString
            }
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
        let tappedItem = self.toDoItems[indexPath.row]
        tappedItem.completed = !tappedItem.completed
        self.writeToDoItemsToUserDefaults()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    // MARK: AddToDoItemViewControllerDelegate
    
    func addNewItem(toDoItem: ToDoItem) {
        self.toDoItems.append(toDoItem)
        self.writeToDoItemsToUserDefaults()
        self.tableView.reloadData()
        SVProgressHUD.showSuccessWithStatus("Successfully added!")
    }
    
    // MARK: UIGestureRecognizer
    
    func addGestureRecognizers() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "revealCreationDate:")
        gestureRecognizer.minimumPressDuration = 0.3
        self.tableView.addGestureRecognizer(gestureRecognizer)
    }
    
    func revealCreationDate(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Ended {
            let location = gestureRecognizer.locationInView(self.tableView)
            let heldIndexPath = self.tableView.indexPathForRowAtPoint(location) as NSIndexPath?
            if let indexPath = heldIndexPath {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }

    // MARK: IBActions
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {}
    
    // MARK: Convenience
    
    func writeToDoItemsToUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(self.toDoItems) as NSData?
        defaults.setObject(data, forKey: "ToDoItems")
        defaults.synchronize()
    }
    
    func readToDoItemsFromUserDefaults() {
        let data = NSUserDefaults.standardUserDefaults().objectForKey("ToDoItems") as NSData?
        if data != nil {
            self.toDoItems = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as [ToDoItem]
        } else {
            self.writeToDoItemsToUserDefaults()
        }
    }
    
}
