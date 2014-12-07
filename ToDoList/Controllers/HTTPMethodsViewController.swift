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
    
    // AFNetworking Methods
    
    func performGETRequestSuccess(sender: UIButton!) {
        let successURL = NSURL(string: "http://httpbin.org/get") as NSURL!
        self.performGETRequest(successURL)
    }
    
    func performGETRequestError(sender: UIButton!) {
        let errorURL = NSURL(string: "http://httpbin.org/error") as NSURL!
        self.performGETRequest(errorURL)
    }
    
    func performGETRequest(url: NSURL) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url.absoluteString,
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                self.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
    
    func performPOSTRequest(sender: UIButton!) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        let parameters = [
            "foo": "bar"
        ]
        manager.POST("http://httpbin.org/post",
            parameters: parameters,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                self.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
    
    func performPOSTFileRequest(sender: UIButton!) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        let parameters = [
            "foo": "bar"
        ]
        let filePath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Info", ofType: "plist")!)
        manager.POST("http://httpbin.org/post",
            parameters: parameters,
            constructingBodyWithBlock: {(formData: AFMultipartFormData!) in
                formData.appendPartWithFileURL(filePath, name: "info", error: nil)
                SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
            }, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                self.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
    
    
}
