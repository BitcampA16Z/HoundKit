//
//  HKViewController.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import UIKit

class HKChatViewController: UIViewController {
    var queryString: String?  {
        didSet {
            print("Setting queryString (aka content) in ViewController")
            print(queryString)
            (self.view as! HKChatView).content = self.queryString
        }
    }
    var isSent: Boolean = false {
        didSet {
            print("Setting isSent in ViewController")
            print(isSent)
            (self.view as! HKChatView).isSent = self.isSent
        }
    }
    var jsonResponse: String? = nil {
        didSet {
            print("Setting jsonResponse in ViewController")
            print(jsonResponse)
            (self.view as! HKChatView).jsonResponse = self.jsonResponse
        }
    }
    
    override func loadView() {
        
        print("view controller loading")
        print(self.queryString)
        self.view = HKChatView()
        (self.view as! HKChatView).content = self.queryString
        (self.view as! HKChatView).isSent = self.isSent
    }
}
