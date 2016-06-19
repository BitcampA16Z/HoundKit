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
        draftMock = HKChatView.resolveImage(imageName: "chatmockdraft.png")
        sentMock = HKChatView.resolveImage(imageName: "chatmock.png")
        
        mockView = UIImageView(image: draftMock)
        mockView.contentMode = UIViewContentMode.scaleAspectFill
        
        contentLabel = UILabel()
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.numberOfLines = 0
        
        super.init(frame: frame)
        
        self.addSubview(mockView)
        self.addSubview(contentLabel)
    }
    
    convenience init () {
        print("convenience constructor")
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
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
    
    //        - (instancetype)initWithFrame:(CGRect)frame {
    //    self = [super initWithFrame:frame];
    //    if (self) {
    //    _draftMock = [UIImage imageNamed:@"chatmockdraft.png"];
    //    _sentMock = [UIImage imageNamed:@"chatmock.png"];
    //
    //    _mockView = [[UIImageView alloc] initWithImage:_draftMock];
    //    [_mockView setContentMode:UIViewContentModeScaleToFill];
    //    [self addSubview:_mockView];
    //
    //    _recipientLabel = [[UILabel alloc] init];
    //    [_recipientLabel setNumberOfLines:0];
    //    [_recipientLabel setLineBreakMode:NSLineBreakByWordWrapping];
    //    [_recipientLabel setTextColor:[UIColor whiteColor]];
    //    [self addSubview:_recipientLabel];
    //
    //    _contentLabel = [[UILabel alloc] init];
    //    [_contentLabel setNumberOfLines:0];
    //    [_contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    //    [self addSubview:_contentLabel];
    //    }
    //    return self;
    //}
    
    //    - (void)setContent:(NSString *)content {
    //    if ([_content isEqualToString:content]) {
    //    return;
    //    }
    //    _content = content;
    //
    //    [self setNeedsLayout];
    //    }
    
    
    
    //    - (void)setSent:(BOOL)sent {
    //    if (_sent == sent) {
    //    return;
    //    }
    //    
    //    _sent = sent;
    //    
    //    UIImage *mockImage = (_sent ? _sentMock : _draftMock);
    //    [_mockView setImage:mockImage];
    //    }
}
