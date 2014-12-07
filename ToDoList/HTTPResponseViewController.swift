//
//  HTTPResponseViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 12/6/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class HTTPResponseViewController: UIViewController {
    
    // MARK: Properties
    
    var responseObject: AnyObject?
    @IBOutlet weak var responseMessage: UILabel!
    @IBOutlet weak var responseField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLayout()
    }
    
    func makeLayout() {
        if self.responseObject != nil {
            // Old Swift way
            // if let responseURL = self.responseObject!["url"] as? String {
            //     self.responseMessage.text = responseURL
            // }
            
            // SwiftyJSON way
            let responseJSON = JSON(self.responseObject!)
            self.responseMessage.text = responseJSON["url"].string
            
            self.responseField.text = responseJSON.description
            self.responseField.layer.borderColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).CGColor
            self.responseField.layer.borderWidth = 0.6
            self.responseField.layer.cornerRadius = 6.0
        }
        
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.doneButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        self.doneButton.layer.cornerRadius = 6.0
    }
    
    // MARK: IBActions
    
    @IBAction func doneButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
