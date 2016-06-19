//
//  HKView.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import UIKit

class HKChatView: UIView {
    
    var mockView: UIImageView
    
    var queryLabel: UILabel
    
    var draftMock: UIImage
    var sentMock: UIImage
    
    let DEBUG_COLORS = false
    
    var content: String? {
        willSet(newContent) {
            print("content set")
            print(newContent)
            if newContent != content {
//                self.setNeedsLayout()
            }
        }
    }
    
    var isSent: Boolean = false {
        willSet(newSentValue) {
            mockView.image = newSentValue.boolValue ? sentMock : draftMock
            print("setting isSent: " + isSent.boolValue.description + " -> " + newSentValue.boolValue.description)
            if newSentValue.boolValue != isSent.boolValue {
//                self.setNeedsLayout()
            }
        }
    }
    
    static func resolveImage(imageName: String) -> UIImage {
        if UIImage(named: imageName) != nil {
            print("image loaded: " + imageName)
            return UIImage(named: imageName)!
        } else {
            fatalError("ERROR: The image named '" + imageName + "' could not be found.")
        }
    }
    
    override init (frame: CGRect) {
        draftMock = HKChatView.resolveImage(imageName: "query2.png")
        sentMock = HKChatView.resolveImage(imageName: "chatmock.png")
        
        mockView = UIImageView(image: draftMock)
        mockView.contentMode = UIViewContentMode.scaleAspectFill
        
        queryLabel = UILabel()
        
        super.init(frame: frame)
        
        self.addSubview(mockView)
        self.addSubview(queryLabel)
        
        addViewContent()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // We don't need this
        fatalError("This class does not support NSCoding")
    }
    
    func addViewContent() {
        queryLabel.frame = CGRect(x: 0.0, y: 0.0, width: 345.0, height: 170.0)
        
        queryLabel.numberOfLines = 0
        queryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        queryLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24.0)
        queryLabel.textAlignment = NSTextAlignment.center
        
        if let content = self.content {
            queryLabel.text = content
            if (self.isSent) {
                queryLabel.text! += " (SENT)"
            }
            
        } else {
            queryLabel.text = "Ask me anything..."
        }
        
        if DEBUG_COLORS {
            queryLabel.backgroundColor = UIColor(red: 0.5, green: 0.1, blue: 0.7, alpha: 0.5)
            queryLabel.layer.borderWidth = 3.0
            queryLabel.layer.borderColor = UIColor(red: 0.5, green: 0.1, blue: 0.7, alpha: 0.8).cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("laying out subviews")
        print(content)
        mockView.frame = self.bounds
        
        addViewContent()
    }
}
