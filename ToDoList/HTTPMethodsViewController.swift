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
        
        
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setTitle("GET Request", forState: UIControlState.Normal)
        button.addTarget(self, action: "performGETRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
//        self.performGETRequest()
    }
    
    func performGETRequest(sender: UIButton!) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://httpbin.org/get",
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println(responseObject)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                println(error)
            }
        )
    }
}
