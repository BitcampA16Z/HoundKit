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
        
        self.view = HKChatView()
        (self.view as! HKChatView).content = self.queryString
    }
}
