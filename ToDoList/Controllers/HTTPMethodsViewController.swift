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
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLayout()
    }
    
    func makeLayout() {
        // Create all UIView objects
        let welcomeMessage = UILabel()
        welcomeMessage.setTranslatesAutoresizingMaskIntoConstraints(false)
        welcomeMessage.text = NSUserDefaults.standardUserDefaults().stringForKey("WelcomeMessage")
        welcomeMessage.textAlignment = NSTextAlignment.Center
        
        let getButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        getButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        getButton.setTitle("GET Request", forState: UIControlState.Normal)
        getButton.addTarget(self, action: "performGETRequestSuccess:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let errorButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        errorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        errorButton.setTitle("Error Request", forState: UIControlState.Normal)
        errorButton.addTarget(self, action: "performGETRequestError:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let postButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postButton.setTitle("POST Request", forState: UIControlState.Normal)
        postButton.addTarget(self, action: "performPOSTRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let postFileButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        postFileButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postFileButton.setTitle("POST Multi-Part Request", forState: UIControlState.Normal)
        postFileButton.addTarget(self, action: "performPOSTFileRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add UIView objects to main View
        self.view.addSubview(welcomeMessage)
        self.view.addSubview(getButton)
        self.view.addSubview(errorButton)
        self.view.addSubview(postButton)
        self.view.addSubview(postFileButton)
        
        // Create constraint dictionaries
        let viewsDictionary = [
            "welcomeMessage": welcomeMessage,
            "getButton": getButton,
            "errorButton": errorButton,
            "postButton": postButton,
            "postFileButton": postFileButton,
        ]
        let metricsDictionary = [
            "topMargin": 100,
            "spaceMargin": 50,
        ]
        
        // Add constraints to main View
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[welcomeMessage]-|", options: nil, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(topMargin)-[welcomeMessage]-(spaceMargin)-[getButton]-(spaceMargin)-[errorButton]-(spaceMargin)-[postButton]-(spaceMargin)-[postFileButton]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    // MARK: UIButton Action Methods
    
    func performGETRequestSuccess(sender: UIButton!) {
        let successURL = NSURL(string: "http://httpbin.org/get") as NSURL!
        HTTPHelper.GET(self, url: successURL)
    }
    
    func performGETRequestError(sender: UIButton!) {
        let errorURL = NSURL(string: "http://httpbin.org/error") as NSURL!
        HTTPHelper.GET(self, url: errorURL)
    }
    
    func performPOSTRequest(sender: UIButton!) {
        let postURL = NSURL(string: "http://httpbin.org/post") as NSURL!
        HTTPHelper.POST(self, url: postURL, parameters: ["foo": "bar"])
    }
    
    func performPOSTFileRequest(sender: UIButton!) {
        let postURL = NSURL(string: "http://httpbin.org/post") as NSURL!
        HTTPHelper.POST(self, url: postURL, parameters: ["foo": "bar"], filePath: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Info", ofType: "plist")!)!)
    }
}
