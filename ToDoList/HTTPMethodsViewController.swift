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
        let manager = AFHTTPRequestOperationManager()
        manager.GET("http://httpbin.org/get",
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("HTTP GET SUCCESS!!!!")
                println(responseObject)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Failure")
            }
        )
    }
}
