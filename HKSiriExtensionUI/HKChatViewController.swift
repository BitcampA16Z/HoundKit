//
//  HKViewController.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import UIKit

class HKChatViewController: UIViewController {
    var queryString: String?
    var isSent: Boolean = false
    
    override func loadView() {
        print("view controller loading")
        print(self.queryString)
        self.view = HKChatView()
        (self.view as! HKChatView).content = self.queryString
        (self.view as! HKChatView).isSent = self.isSent
    }
}
