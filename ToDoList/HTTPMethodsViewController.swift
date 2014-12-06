//
//  HTTPMethodsViewController.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

class HTTPMethodsViewController: UIViewController {
    
    // MARK: Properties
    
    var responseMessage: UILabel?
    var responseField: UITextView?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLayout()
    }
    
    func makeLayout() {
        // Create all View objects
        let welcomeMessage = UILabel()
        welcomeMessage.setTranslatesAutoresizingMaskIntoConstraints(false)
        welcomeMessage.text = NSUserDefaults.standardUserDefaults().stringForKey("WelcomeMessage")
        welcomeMessage.textAlignment = NSTextAlignment.Center
        
        let getButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        getButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        getButton.setTitle("GET Request", forState: UIControlState.Normal)
        getButton.addTarget(self, action: "performGETRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let postButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postButton.setTitle("POST Request", forState: UIControlState.Normal)
        postButton.addTarget(self, action: "performPOSTRequest", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.responseMessage = UILabel()
        self.responseMessage!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseMessage!.font = UIFont.boldSystemFontOfSize(17.0)
        self.responseMessage!.textAlignment = NSTextAlignment.Center
        self.responseMessage!.hidden = true
        
        self.responseField = UITextView()
        self.responseField!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseField!.font = UIFont(name: "Courier", size: 11)
        self.responseField!.layer.borderColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1).CGColor
        self.responseField!.layer.borderWidth = 0.6
        self.responseField!.layer.cornerRadius = 6.0
        
        // Add subviews to main View
        self.view.addSubview(welcomeMessage)
        self.view.addSubview(getButton)
        self.view.addSubview(postButton)
        self.view.addSubview(self.responseMessage!)
        self.view.addSubview(self.responseField!)
        
        // Create constraint dictionaries
        let viewsDictionary = [
            "welcomeMessage": welcomeMessage,
            "getButton": getButton,
            "postButton": postButton,
            "responseMessage": self.responseMessage!,
            "responseField": self.responseField!,
        ]
        let metricsDictionary = [
            "topMargin": 100,
            "spaceMargin": 20,
        ]
        
        // Add constraints to main View
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[responseField]-|", options: nil, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(topMargin)-[welcomeMessage]-(spaceMargin)-[getButton]-(spaceMargin)-[postButton]-(spaceMargin)-[responseMessage]-(spaceMargin)-[responseField]-(spaceMargin)-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    func performGETRequest(sender: UIButton!) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://httpbin.org/get",
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.responseField!.text = responseObject.description
                self.responseMessage!.text = responseObject["origin"] as String!
                self.responseMessage!.hidden = false
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                self.responseField!.text = error.localizedDescription
            }
        )
    }
    
    func performPOSTRequest(sender: UIButton!) {
        let manager = AFHTTPRequestOperationManager()
        
    }
}
