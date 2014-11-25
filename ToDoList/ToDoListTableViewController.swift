//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    var todoItems: [ToDoItem] = []
    
    func loadInitialData() {
        self.todoItems.append(ToDoItem(itemName: "Buy milk"))
        self.todoItems.append(ToDoItem(itemName: "Buy eggs"))
        self.todoItems.append(ToDoItem(itemName: "Read a book"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInitialData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell
        let toDoItem = self.todoItems[indexPath.row]
        cell.textLabel.text = toDoItem.itemName
        return cell
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
}
