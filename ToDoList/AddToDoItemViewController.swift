//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

protocol AddToDoItemViewControllerDelegate {
    func addNewItem(toDoItem: ToDoItem)
}

class AddToDoItemViewController: UIViewController {
    
    // MARK: Properties
    
    var toDoItem: ToDoItem?
    var numToDoItems: Int = 0
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var numItemsLabel: UILabel!
    
    var delegate: AddToDoItemViewControllerDelegate?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numItemsLabel.text = "Currently \(self.numToDoItems) To-Do Items"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as UIBarButtonItem == self.doneButton {
            if countElements(self.textField.text) > 0 {
                self.delegate = segue.destinationViewController as ToDoListTableViewController
                self.delegate!.addNewItem(ToDoItem(itemName: self.textField.text))
            }
        }
    }
}
