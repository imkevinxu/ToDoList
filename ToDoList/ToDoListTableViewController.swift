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
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
}
