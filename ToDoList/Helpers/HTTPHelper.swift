//
//  HTTPHelper.swift
//  ToDoList
//
//  Created by Kevin Xu on 12/7/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import Foundation

class HTTPHelper {
    
    // MARK: AFNetworking Methods

    class func GET(vc: UIViewController, url: NSURL) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url.absoluteString,
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                vc.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
    
    class func POST(vc: UIViewController, url: NSURL, parameters: NSDictionary) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        manager.POST(url.absoluteString,
            parameters: parameters,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                vc.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
    
    class func POST(vc: UIViewController, url: NSURL, parameters: NSDictionary, filePath: NSURL) {
        SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
        let manager = AFHTTPRequestOperationManager()
        manager.POST(url.absoluteString,
            parameters: parameters,
            constructingBodyWithBlock: {(formData: AFMultipartFormData!) in
                formData.appendPartWithFileURL(filePath, name: "file", error: nil)
                SVProgressHUD.showWithMaskType(UInt(SVProgressHUDMaskTypeBlack))
            }, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseViewController = HTTPResponseViewController(nibName: "HTTPResponseView", bundle: nil)
                responseViewController.responseObject = responseObject
                vc.presentViewController(responseViewController, animated: true, completion: {
                    SVProgressHUD.showSuccessWithStatus("Success")
                })
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Error")
            }
        )
    }
}