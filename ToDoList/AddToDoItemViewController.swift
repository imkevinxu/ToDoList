//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    // MARK: Properties
    
    var todoItem: ToDoItem?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as UIBarButtonItem == self.doneButton {
            if countElements(self.textField.text) > 0 {
                self.todoItem = ToDoItem(itemName: self.textField.text)
            }
        }
    }
    
}
