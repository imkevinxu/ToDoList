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
        // Create all View objects
        let welcomeMessage = UILabel()
        welcomeMessage.setTranslatesAutoresizingMaskIntoConstraints(false)
        welcomeMessage.text = NSUserDefaults.standardUserDefaults().stringForKey("WelcomeMessage")
        welcomeMessage.textAlignment = NSTextAlignment.Center
        
        let getButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        getButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        getButton.setTitle("GET Request", forState: UIControlState.Normal)
        getButton.addTarget(self, action: "performGETRequestSuccess:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let postButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postButton.setTitle("POST Request", forState: UIControlState.Normal)
        postButton.addTarget(self, action: "performGETRequestSuccess:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add subviews to main View
        self.view.addSubview(welcomeMessage)
        self.view.addSubview(getButton)
        self.view.addSubview(postButton)
        
        // Create constraint dictionaries
        let viewsDictionary = [
            "welcomeMessage": welcomeMessage,
            "getButton": getButton,
            "postButton": postButton,
        ]
        let metricsDictionary = [
            "topMargin": 100,
            "spaceMargin": 50,
        ]
        
        // Add constraints to main View
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[welcomeMessage]-|", options: nil, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(topMargin)-[welcomeMessage]-(spaceMargin)-[getButton]-(spaceMargin)-[postButton]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    func performGETRequestSuccess(sender: UIButton!) {
        let successURL = NSURL(string: "http://httpbin.org/get") as NSURL!
        self.performGETRequest(successURL)
    }
    
    func performGETRequest(url: NSURL) {
        SVProgressHUD.showWithStatus("Loading")
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url.absoluteString,
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                self.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Response Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Response Error")
            }
        )
    }
    
    func performPOSTRequest(sender: UIButton!) {
        let manager = AFHTTPRequestOperationManager()
        
    }
}
