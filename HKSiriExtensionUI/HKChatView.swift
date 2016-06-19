//
//  HKView.swift
//  HoundKit
//
//  Created by Colin King on 6/18/16.
//  Copyright © 2016 Colin King. All rights reserved.
//

import UIKit

class HKChatView: UIView {
    
    var contentLabel: UILabel
    var mockView: UIImageView
    
    var draftMock: UIImage
    var sentMock: UIImage
    
    var content: String? {
        willSet(newContent) {
            print("content set")
            print(newContent)
            if newContent != content {
                self.setNeedsLayout()
            }
        }
    }
    
    var isSent: Boolean = false {
        willSet(newSentValue) {
            mockView.image = newSentValue.boolValue ? sentMock : draftMock
            print("setting is sent")
            print(isSent)
            print(newSentValue)
            if newSentValue.boolValue != isSent.boolValue {
                self.setNeedsLayout()
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
        
        contentLabel = UILabel()
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.numberOfLines = 0
        
        super.init(frame: frame)
        
        print("Initing ChatView")
        
        let queryLabel = UILabel()
        queryLabel.numberOfLines = 1
        queryLabel.text = "QUERY:"
        queryLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24.0)
        queryLabel.frame = CGRect(x: 10.0, y: 45.0, width: 100.0, height: 40.0)
        
        self.addSubview(mockView)
//        self.addSubview(queryLabel)
        self.addSubview(contentLabel)
    }
    
    convenience init () {
        print("convenience constructor")
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
//        draftMock = HKChatView.resolveImage(imageName: "houndify-bg")
//        sentMock = HKChatView.resolveImage(imageName: "chatmock.png")
//        
//        mockView = UIImageView(image: draftMock)
//        mockView.contentMode = UIViewContentMode.scaleAspectFill
//        
//        contentLabel = UILabel()
//        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//        contentLabel.numberOfLines = 0
//        
//        super.init(coder: aDecoder)
//        
//        print("Initing ChatView")
//        print("Well hoping for the storyboard -- decoder")
    }
    
    func commonInit() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("laying out subviews")
        print(content)
        mockView.frame = self.bounds
        if let content = self.content {
            contentLabel.text = content
            contentLabel.frame = CGRect(x: 113.0, y: 85.0, width: 150.0, height: 75.0)
        }
    }
}
